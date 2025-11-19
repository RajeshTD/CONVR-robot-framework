*** Settings ***
Resource     ../../utils/common_keywords.robot
Variables     ../locators/email_locators.py

*** Keywords ***

# Switch To Email Tab
#     [Documentation]    Ensures the view is switched to the 'Email' tab. If not already on the email tab, it will be clicked.
#     ${is_visible}=    Run Keyword And Return Status    Get Element States  ${Email_breadcrums}    validate    value & visible    'Email_breadcrums should be visible.'
#     IF    not ${is_visible}
#         Click    ${EmailMenu}
#         Wait For Load State    networkidle
#         Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email page is not opened Sucessfully
#         # Wait For Elements State    ${Email_breadcrums}    visible       
#     END
Switch To Email Tab
    [Documentation]    Switches to the 'Email' tab and verifies it opened successfully.

    ${tab_visible}=    Run Keyword And Return Status    Get Element States    ${Email_breadcrums}    validate    value & visible
    IF    not ${tab_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${EmailMenu}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Switch To Email Tab: Failed to click 'Email' menu. Ensure it is visible and enabled.

        Wait For Load State    networkidle

        ${breadcrum_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${breadcrum_visible}    msg=Switch To Email Tab: 'Email' page did not open successfully after clicking the menu.
    END

# Create New Mail
#     [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    Wait for new message tittle to verify that the new message tittle should be visible after click on New buton or CreateNewMessage button
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#     Click    ${SubmissionAssetsButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    SubmissionAssetsDialog    ${SubmissionAssetsDialog}    visible    Wait for the submissionAssetsDialog to verify that the message 'Select one or more assets to attach to your message' is displayed
#     ${is_list}=    Evaluate    isinstance($email_data['AssetName'], list)
#     IF    ${is_list}
#         ${asset}=    Get From List    ${email_data['AssetName']}    0
#     ELSE
#         ${asset}=    Set Variable    ${email_data['AssetName']}
#     END
#     ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${asset}    ${SelectOriginalDocument_checkbox}
#     Check Checkbox    ${asset_name}
#     Click    ${Attach1AssetButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    AttachmentText    ${AttachmentText}    visible   Wait for AttachmentText to verify that the attachment text is visible.
#     ${attachmentText}=    Get Text    ${AttachmentText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${asset}    ${attachmentText}    
#     Click    ${SendButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Wait for Email_breadcrums to verify that the email was sent.
Create New Mail
    [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
    ...    This method ensures the email fields, attachment, and send functionality work as expected.
    ...    *Arguments:*
    ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
    [Arguments]    ${email_data}

    Switch To Email Tab

    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    Run Keyword If    ${is_visible}    Click    ${CreateNewMessageButton}
    Run Keyword If    not ${is_visible}    Click    ${NewEmailButton}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=New message title is not visible after opening new email. Verify that the new email dialog opened successfully.

    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=From field value mismatch. Expected '${email_data['From']}', but got '${fromText}'.

    Fill Text    ${RecipientsField}    ${email_data['To']}

    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field value mismatch. Expected '${email_data['Subject']}', but got '${subjectText}'.

    Fill Text    ${EmailBody}    ${email_data['Body']}

    ${status}    Run Keyword And Return Status    Click    ${SubmissionAssetsButton}
    Run Keyword And Continue On Failure    Should Be True     ${status}    msg=Failed to click 'Submission Assets' button. The assets dialog may not open.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SubmissionAssetsDialog}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Submission assets dialog did not appear. Verify that the dialog is displayed for selecting attachments.

    ${asset}=    Set Variable    None
    ${is_list}=    Evaluate    isinstance($email_data['AssetName'], list)
    IF    ${is_list}
        ${asset}=    Get From List    ${email_data['AssetName']}    0
    ELSE
        ${asset}=    Set Variable    ${email_data['AssetName']}
    END

    ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${asset}    ${SelectOriginalDocument_checkbox}
    ${status}    Run Keyword And Return Status    Check Checkbox    ${asset_name}
    Run Keyword And Continue On Failure    Should Be True    ${status}   msg=Failed to check the asset '${asset}' in the submission assets dialog. Verify the checkbox locator and that the asset exists.

    ${status}    Run Keyword And Return Status    Click    ${Attach1AssetButton}
    Run Keyword And Continue On Failure    Should Be True     ${status}    msg=Failed to click 'Attach' button to attach asset '${asset}'. Ensure the button is visible and clickable.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AttachmentText}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Attachment text is not visible after attaching '${asset}'. Verify the attachment was successful.

    ${attachmentText}=    Get Text    ${AttachmentText}
    Run Keyword And Continue On Failure    Should Be Equal    ${asset}    ${attachmentText}    msg=Attachment text mismatch. Expected '${asset}', but got '${attachmentText}'.

    ${status}    Run Keyword And Return Status    Click    ${SendButton}
    Run Keyword And Continue On Failure    Should Be True     ${status}    msg=Failed to click 'Send' button. Ensure the button is visible and enabled.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Email confirmation breadcrumb did not appear. Verify that the email was sent successfully.

# Create New Mail For Upload Multiple Submission Assets
#     [Documentation]    Composes and sends a new email with multiple submission assets as attachments.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details, including a list of 'FileNames' to attach from submission assets.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
    
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     Fill Text    ${SubjectField}    ${email_data['Subject']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#     Click    ${SubmissionAssetsButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Wait for Email_breadcrums to verify that the email was sent.
#     # Wait For Elements State    ${Email_breadcrums}    visible
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         Run Keyword And Continue On Failure    Wait For Element With Message    SubmissionAssetsDialog    ${SubmissionAssetsDialog}    visible    SubmissionAssetsDialog is not avilable while creating the mail
#         # Wait For Elements State    ${SubmissionAssetsDialog}    visible
#         ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
#         Check Checkbox    ${asset_name}
#         END
#         Click    ${Attach1AssetButton}
#         ${counter}=    Set Variable    1
    
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
#         # Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    attachment_text_locator    ${attachment_text_locator}    visible    attachment_text_locator is not avilable while creating the mail
#         ${Textvalue}=    Get Text    ${attachment_text_locator}
#         Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}
#         ${counter}=    Evaluate    ${counter} + 1
#         END
#     # Wait For Elements State    ${SendButton}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    SendButton    ${SendButton}    visible    SendButton is not avilable After creating the mail
#     Click    ${SendButton}
#     # Wait For Elements State    ${Email_breadcrums}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail

Create New Mail For Upload Multiple Submission Assets
    [Documentation]    Composes and sends a new email with multiple submission assets as attachments.
    ...    ${email_data} is a dictionary containing email details, including a list of 'FileNames' to attach from submission assets.
    [Arguments]    ${email_data}

    Switch To Email Tab

    # Open new email
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked_new}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new}    msg=Failed to click 'Create New Message' button.
    ELSE
        ${clicked_new_alt}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new_alt}    msg=Failed to click 'New Email' button.
    END

    # Wait for new message to open
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=New Message title is not present.

    # Verify From field
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}

    # Fill email fields
    Fill Text    ${RecipientsField}    ${email_data['To']}
    Fill Text    ${SubjectField}       ${email_data['Subject']}
    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
    Fill Text    ${EmailBody}          ${email_data['Body']}

    # Attach Submission Assets
    ${clicked_assets}=    Run Keyword And Return Status    Click    ${SubmissionAssetsButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_assets}    msg=Failed to click 'Submission Assets' button.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Email breadcrumbs not visible.

    FOR    ${file}    IN    @{email_data['FileNames']}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${SubmissionAssetsDialog}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Submission Assets dialog is not available.
        ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
        ${checked}=    Run Keyword And Return Status    Check Checkbox    ${asset_name}
        Run Keyword And Continue On Failure    Should Be True    ${checked}    msg=Failed to select submission asset '${file}'.
    END

    ${clicked_attach}=    Run Keyword And Return Status    Click    ${Attach1AssetButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_attach}    msg=Failed to click 'Attach' button.

    # Verify attached files
    ${counter}=    Set Variable    1
    FOR    ${file}    IN    @{email_data['FileNames']}
        ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Attachment '${file}' not visible.
        ${Textvalue}=    Get Text    ${attachment_text_locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}
        ${counter}=    Evaluate    ${counter} + 1
    END

    # Send email
    ${enabled}=    Run Keyword And Return Status    Wait For Elements State    ${SendButton}    enabled    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${enabled}    msg=Send button is not enabled.
    ${clicked_send}=    Run Keyword And Return Status    Click    ${SendButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_send}    msg=Failed to click 'Send' button.

    # Verify email sent
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Email breadcrumbs not visible after sending email.

# Create New Mail For Upload 40 MB File
#     [Documentation]    Composes and sends a new email, attaching a large file (up to 40MB) from the local file system.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details, including the 'FileName' to upload.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     Fill Text    ${SubjectField}    ${email_data['Subject']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#     ${AbsolutePath}=    Normalize Path    ${path}${email_data['FileName']}
#     Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#     # Wait For Elements State    ${AttachmentText}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    AttachmentText    ${AttachmentText}    visible   Wait for AttachmentText to verify that the attachment text is visible.
#     ${Textvalue}=    Get Text    ${AttachmentText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${email_data['FileName']}
#     # Wait For Elements State    ${AttachmentText}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    AttachmentText    ${AttachmentText}    visible   Wait for AttachmentText to verify that the attachment text is visible.
#     Click    ${SendButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail
#     # Wait For Elements State    ${Email_breadcrums}    visible

Create New Mail For Upload 40 MB File
    [Documentation]    Composes and sends a new email, attaching a large file (up to 40MB) from the local file system.
    ...    ${email_data} is a dictionary containing email details, including 'FileName' to upload.
    [Arguments]    ${email_data}

    Switch To Email Tab

    # Open new email
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked_new}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new}    msg=Failed to click 'Create New Message' button.
    ELSE
        ${clicked_alt}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_alt}    msg=Failed to click 'New Email' button.
    END

    # Wait for new message title
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=New message title is not present.

    # Verify From field
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}

    # Fill email fields
    Fill Text    ${RecipientsField}    ${email_data['To']}
    Fill Text    ${SubjectField}       ${email_data['Subject']}
    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
    Fill Text    ${EmailBody}          ${email_data['Body']}

    # Upload large file
    ${AbsolutePath}=    Normalize Path    ${path}${email_data['FileName']}
    Upload File By Selector    ${UploadFile}    ${AbsolutePath}

    # Wait for attachment to appear and verify
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${AttachmentText}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Attachment text not visible after upload.
    ${Textvalue}=    Get Text    ${AttachmentText}
    Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${email_data['FileName']}

    # Send email
    ${clicked_send}=    Run Keyword And Return Status    Click    ${SendButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_send}    msg=Failed to click 'Send' button.

    # Verify email sent
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Email breadcrumbs not visible after sending email.

# Create New Mail For Upload Multiple Files
#     [Documentation]    Composes and sends a new email, attaching multiple files from the local file system.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details, including a list of 'FileNames' to upload.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     Fill Text    ${SubjectField}    ${email_data['Subject']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}   
#     ${counter}=    Set Variable    1
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         ${AbsolutePath}=    Normalize Path    ${path}${file}
#         Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
#         Run Keyword And Continue On Failure    Wait For Element With Message    attachment_text_locator    ${attachment_text_locator}    visible   attachment_text_locator is not present in the NEW Email 
#         # Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
#         ${Textvalue}=    Get Text    ${attachment_text_locator}
#         Should Be Equal    ${Textvalue}    ${file}
#         ${counter}=    Evaluate    ${counter} + 1
#         END
#     # Wait For Elements State    ${SendButton}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    SendButton    ${SendButton}    visible    SendButton is not avilable After creating the mail
#     Click    ${SendButton}
#     # Wait For Elements State    ${Email_breadcrums}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail

Create New Mail For Upload Multiple Files
    [Documentation]    Composes and sends a new email, attaching multiple files from the local file system.
    ...    ${email_data} is a dictionary containing email details, including a list of 'FileNames' to upload.
    [Arguments]    ${email_data}

    Switch To Email Tab

    # Open new email
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked_new}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new}    msg=Failed to click 'Create New Message' button.
    ELSE
        ${clicked_alt}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_alt}    msg=Failed to click 'New Email' button.
    END

    # Wait for new message title
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=New message title is not present.

    # Verify From field
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}

    # Fill email fields
    Fill Text    ${RecipientsField}    ${email_data['To']}
    Fill Text    ${SubjectField}       ${email_data['Subject']}
    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
    Fill Text    ${EmailBody}          ${email_data['Body']}

    # Upload multiple files and verify attachments
    ${counter}=    Set Variable    1
    FOR    ${file}    IN    @{email_data['FileNames']}
        ${AbsolutePath}=    Normalize Path    ${path}${file}
        Upload File By Selector    ${UploadFile}    ${AbsolutePath}

        ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Attachment text for file '${file}' not visible.

        ${Textvalue}=    Get Text    ${attachment_text_locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}

        ${counter}=    Evaluate    ${counter} + 1
    END

    # Send email
    ${clicked_send}=    Run Keyword And Return Status    Click    ${SendButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_send}    msg=Failed to click 'Send' button.

    # Verify email sent
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email_breadcrums}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Email breadcrumbs not visible after sending email.

# Verify Email Sent Successfully
#     [Documentation]    Verifies that the 'Email Sent Successfully' confirmation message appears.
#     Sleep    1s
#     Get Element States    ${EmailSentSuccessfully}    validate    value & visible    'EmailSentSuccessfully should be visible.'
Verify Email Sent Successfully
    [Documentation]    Verifies that the 'Email Sent Successfully' confirmation message appears.
    Sleep    1s
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${EmailSentSuccessfully}    visible    timeout=${element_timeout}
    Should Be True    ${status}    msg=Email Tab : Try Create a New mail - EmailSentSuccessfully confirmation message is not visible after sending the email.

# Verify Sent Email
#     [Documentation]    Opens the most recent sent email and verifies its content.
#     ...
#     ...    *Arguments:*
#     ...    - `@{email_data}`: A list of strings that are expected to be found in the email body or headers.
#     [Arguments]    ${email_data}
#     Click    ${SentEmailCard}
#     FOR    ${data}    IN    @{email_data}
#         ${locator}    Catenate    SEPARATOR=    ${SentEmailContent}    ${data}    ']
#         Get Element States    ${locator}    validate    value & visible    'Element should be visible.'
#     END
Verify Sent Email
    [Documentation]    Opens the most recent sent email and verifies that its content matches the expected values.
    ...
    ...    *Arguments:*
    ...    - `@{email_data}`: A list of strings that are expected to be found in the email body or headers.
    [Arguments]    ${email_data}

    ${Status}    Run Keyword And Return Status    Click    ${SentEmailCard}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Failed to click on the most recent sent email card. Ensure the card is visible and clickable.

    FOR    ${data}    IN    @{email_data}
        ${locator}=    Catenate    SEPARATOR=    ${SentEmailContent}    ${data}    ']
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Expected email content '${data}' is not visible in the sent email. Verify the content exists and the locator is correct.
    END

# Verify Sent Email Data
#     [Documentation]    Opens a specific email card from the list and verifies its content.
#     ...
#     ...    *Arguments:*
#     ...    - `@{email_data}`: A list of strings that are expected to be found in the email body or headers.
#     ...    - `${cardName}`: The identifier for the email card to be clicked.
#     [Arguments]    ${email_data}    ${cardName}
#     ${card}    Catenate    SEPARATOR=    (${EmailCard}    ${cardName}    '])[1]
#     Click    ${card}
#     FOR    ${data}    IN    @{email_data}
#         ${locator}    Catenate    SEPARATOR=    ${SentEmailContent}    ${data}    ']
#         Get Element States    ${locator}    validate    value & visible    'Element should be visible.'
#     END

Verify Sent Email Data
    [Documentation]    Opens a specific email card from the list and verifies its content.
    ...    ${email_data} is a list of expected strings in the email body or headers.
    ...    ${cardName} is the identifier for the email card to be clicked.
    [Arguments]    ${email_data}    ${cardName}

    # Build and click the email card
    ${card}=    Catenate    SEPARATOR=    (${EmailCard}    ${cardName}    '])[1]
    ${clicked_card}=    Run Keyword And Return Status    Click    ${card}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_card}    msg=Failed to click email card '${cardName}'.

    # Verify each expected data element is visible
    FOR    ${data}    IN    @{email_data}
        ${locator}=    Catenate    SEPARATOR=    ${SentEmailContent}    ${data}    ']
        ${status}=    Run Keyword And Return Status    Get Element States    ${locator}    validate    value & visible
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Expected email content '${data}' is not visible.
    END


# Create New Mail With Missing Data
#     [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
#     [Arguments]    ${email_data}    ${Expected_PopUp_Msg}
#     ${Actual_Popup_Msg}    Create List
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Should Be Equal    ${fromText}    ${email_data['From']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Click    ${SendButton}
#     FOR    ${Text}    IN    @{Expected_PopUp_Msg}
#     ${element}    Catenate    SEPARATOR=    ${Missing_PopUp_Loc}    ${Text}']        
#         Run Keyword And Continue On Failure     Get Element States    ${element}    validate    value & visible 
#     END
# Create New Mail With Missing Data
#     [Documentation]    Composes a new email and verifies that missing data popups are displayed.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'Subject', etc.
#     ...    - `${Expected_PopUp_Msg}`: List of expected popup messages for missing fields.
#     [Arguments]    ${email_data}    ${Expected_PopUp_Msg}

#     ${Actual_Popup_Msg}=    Create List

#     Switch To Email Tab

#     ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END

#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    New Message title is not present in the new email compose window.

#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=Sender email field does not match expected value.

#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field does not match expected value.

#     Click    ${SendButton}

#     FOR    ${Text}    IN    @{Expected_PopUp_Msg}
#         ${element}=    Catenate    SEPARATOR=    ${Missing_PopUp_Loc}    ${Text}']
#         ${status}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Should Be True    ${status}    Expected missing data popup '${Text}' is not visible after clicking Send.
#     END

Create New Mail With Missing Data
    [Documentation]    Composes a new email and verifies that missing data popups are displayed.
    ...    ${email_data} is a dictionary containing email details like 'From', 'Subject', etc.
    ...    ${Expected_PopUp_Msg} is a list of expected popup messages for missing fields.
    [Arguments]    ${email_data}    ${Expected_PopUp_Msg}

    Switch To Email Tab

    # Click the appropriate new email button
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Create New Message button.
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click New Email button.
    END

    # Verify new message title is visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=New Message title is not present in the email compose window.

    # Verify 'From' and 'Subject' fields
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=Sender email field does not match expected value.

    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field does not match expected value.

    # Click Send button
    ${clicked_send}=    Run Keyword And Return Status    Click    ${SendButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_send}    msg=Failed to click Send button.

    # Verify missing data popups
    FOR    ${Text}    IN    @{Expected_PopUp_Msg}
        ${element}=    Catenate    SEPARATOR=    ${Missing_PopUp_Loc}    ${Text}']
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Expected missing data popup '${Text}' is not visible after clicking Send.
    END


# Save and verify mail in Draft
#     [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#     Click    ${SubmissionAssetsButton}
#     # Set Viewport Size    2560    1440
#     # Wait For Elements State    ${Email_breadcrums}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         Run Keyword And Continue On Failure    Wait For Element With Message    SubmissionAssetsDialog    ${SubmissionAssetsDialog}    visible    SubmissionAssetsDialog is not avilable while creating the mail
#         # Wait For Elements State    ${SubmissionAssetsDialog}    visible
#         ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
#         Check Checkbox    ${asset_name}
#         END
#         Click    ${Attach1AssetButton}
#         # Set Viewport Size    1280    720
#         ${counter}=    Set Variable    1
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]

#         # Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    attachment_text_locator    ${attachment_text_locator}    visible   attachment_text_locator is not present in the NEW Email 
#         ${Textvalue}=    Get Text    ${attachment_text_locator}
#         Should Be Equal    ${Textvalue}    ${file}
#         ${counter}=    Evaluate    ${counter} + 1
#         END
#     Click    ${Save_Draft}
#     Get Element States    ${Draft_Saved_Msg}    validate    value & visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${ActualText}    Get Text    ${NewMessageTitle}
#     Should Be Equal    ${ActualText}    New Message
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${ActualText}    Get Text    ${NewMessageTitle}
#     Should Be Equal    ${ActualText}    New Message
#     Get Element States    ${Draft_mail_Loc}    validate    value & visible
#     Click    ${Draft_mail_Loc}
#     ${Actual_Reciver_Mail}    Get Text    ${Resiver_Mail}
#     Should Be Equal   ${email_data['To']}    ${Actual_Reciver_Mail}
#     ${Actual_Body_Msg}    Get Text    ${Body_Msg}
#     Should Be Equal    ${email_data['Body']}    ${Actual_Body_Msg}  
#     Get Element States    ${NewEmailButton}    validate    value & visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SendButton    ${SendButton}    visible    SendButton is not avilable After creating the mail
Save and verify mail in Draft
    [Documentation]    Composes a new email, attaches files, saves it to Draft, and verifies all details in the Draft folder.
    [Arguments]    ${email_data}

    Switch To Email Tab

    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Create New Message button.
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click New Email button.
    END

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    New Message title is not present in the new email compose window.

    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=Sender email field does not match expected value.

    Fill Text    ${RecipientsField}    ${email_data['To']}

    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field does not match expected value.

    Fill Text    ${EmailBody}    ${email_data['Body']}

    Click    ${SubmissionAssetsButton}

    FOR    ${file}    IN    @{email_data['FileNames']}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SubmissionAssetsDialog}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    SubmissionAssetsDialog is not visible while creating the mail.

        ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
        ${status}    Run Keyword And Return Status    Check Checkbox    ${asset_name}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to select asset '${file}' in submission assets dialog.
    END

    Click    ${Attach1AssetButton}

    ${counter}=    Set Variable    1
    FOR    ${file}    IN    @{email_data['FileNames']}
        ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Attachment text for file '${file}' is not visible in the new email.

        ${Textvalue}=    Get Text    ${attachment_text_locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}    msg=Attachment name does not match expected file '${file}'.

        ${counter}=    Evaluate    ${counter} + 1
    END

    Click    ${Save_Draft}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Draft_Saved_Msg}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Draft saved confirmation message is not visible.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    New Message title is not visible after saving to draft.

    ${ActualText}=    Get Text    ${NewMessageTitle}
    Run Keyword And Continue On Failure    Should Be Equal    ${ActualText}    New Message    msg=New Message title text does not match expected.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Draft_mail_Loc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Draft mail is not visible in Draft folder.

    Click    ${Draft_mail_Loc}

    ${Actual_Reciver_Mail}=    Get Text    ${Resiver_Mail}
    Run Keyword And Continue On Failure    Should Be Equal    ${email_data['To']}    ${Actual_Reciver_Mail}    msg=Recipient email in draft does not match expected.

    ${Actual_Body_Msg}=    Get Text    ${Body_Msg}
    Run Keyword And Continue On Failure    Should Be Equal    ${email_data['Body']}    ${Actual_Body_Msg}    msg=Email body in draft does not match expected.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SendButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Send button is not visible in the draft email.

# Discard the Created Email
#     [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#       Click    ${SubmissionAssetsButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail
#     # Wait For Elements State    ${Email_breadcrums}    visible
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         Run Keyword And Continue On Failure    Wait For Element With Message    SubmissionAssetsDialog    ${SubmissionAssetsDialog}    visible    SubmissionAssetsDialog is not avilable while creating the mail
#         # Wait For Elements State    ${SubmissionAssetsDialog}    visible
#         ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
#         Check Checkbox    ${asset_name}
#         END
#         Click    ${Attach1AssetButton}
#         ${counter}=    Set Variable    1
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
#         Run Keyword And Continue On Failure    Wait For Element With Message    attachment_text_locator    ${attachment_text_locator}    visible   attachment_text_locator is not present in the NEW Email 
#         # Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
#         ${Textvalue}=    Get Text    ${attachment_text_locator}
#         Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}
#         ${counter}=    Evaluate    ${counter} + 1
#         END
#         Get Element States    ${Discard_Button}    validate    value & visible
#         Click    ${Discard_Button}    
#          ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#          ${is_visible1}=    Run Keyword And Return Status     Wait For Elements State    ${NewEmailButton}    visible    timeout=${element_timeout}
#         ${result}=    Evaluate    ${is_visible} or ${is_visible1} 
#         Run Keyword And Continue On Failure    Should Be True    ${result} 
Discard the Created Email
    [Documentation]    Composes a new email, attaches files, discards it, and verifies it is removed.
    [Arguments]    ${email_data}

    Switch To Email Tab

    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Create New Message button.
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click New Email button.
    END
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    New Message title is not present in the new email compose window.

    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=Sender email field does not match expected value.

    Fill Text    ${RecipientsField}    ${email_data['To']}

    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field does not match expected value.

    Fill Text    ${EmailBody}    ${email_data['Body']}

    Click    ${SubmissionAssetsButton}

    FOR    ${file}    IN    @{email_data['FileNames']}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SubmissionAssetsDialog}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    SubmissionAssetsDialog is not visible while creating the mail.

        ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
        ${status}    Run Keyword And Return Status    Check Checkbox    ${asset_name}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to select asset '${file}' in submission assets dialog.
    END

    Click    ${Attach1AssetButton}

    ${counter}=    Set Variable    1
    FOR    ${file}    IN    @{email_data['FileNames']}
        ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Attachment text for file '${file}' is not visible in the new email.

        ${Textvalue}=    Get Text    ${attachment_text_locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}    msg=Attachment name does not match expected file '${file}'.

        ${counter}=    Evaluate    ${counter} + 1
    END

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Discard_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Discard button is not visible in the email compose window.

    Click    ${Discard_Button}

    # Verify that the email compose window is closed
    ${is_visible_new}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    ${is_visible_old}=    Run Keyword And Return Status    Wait For Elements State    ${NewEmailButton}    visible    timeout=${element_timeout}
    ${result}=    Evaluate    ${is_visible_new} or ${is_visible_old}
    Run Keyword And Continue On Failure    Should Be True    ${result}    New email compose window is still visible after discarding the email.

# Verify Discard Button visible
#     [Documentation]    Composes and sends a new email with a single submission asset as an attachment.
#     ...
#     ...    *Arguments:*
#     ...    - `${email_data}`: A dictionary containing email details like 'From', 'To', 'Subject', 'Body', and 'AssetName'.
#     [Arguments]    ${email_data}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#       Click    ${SubmissionAssetsButton}
#       Set Viewport Size    2560    1440
#     # Wait For Elements State    ${Email_breadcrums}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email_breadcrums    ${Email_breadcrums}    visible    Email_breadcrums is not avilable After Send the mail
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         # Wait For Elements State    ${SubmissionAssetsDialog}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    SubmissionAssetsDialog    ${SubmissionAssetsDialog}    visible    SubmissionAssetsDialog is not avilable while creating the mail
#         ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
#         Check Checkbox    ${asset_name}
#         END
#         Click    ${Attach1AssetButton}
#         Set Viewport Size    1280    720
#         ${counter}=    Set Variable    1
   
#         FOR    ${file}    IN    @{email_data['FileNames']}
#         ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
#         # Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    attachment_text_locator    ${attachment_text_locator}    visible   attachment_text_locator is not present in the NEW Email 
#         ${Textvalue}=    Get Text    ${attachment_text_locator}
#         Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}
#         ${counter}=    Evaluate    ${counter} + 1
#         END
#         Get Element States    ${Discard_Button}    validate    value & visible
#         Click    ${Discard_Button}    
#          ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#          ${is_visible1}=    Run Keyword And Return Status     Wait For Elements State    ${NewEmailButton}    visible    timeout=${element_timeout}
#         ${result}=    Evaluate    ${is_visible} or ${is_visible1}
#         Run Keyword And Continue On Failure    Should Be True    ${result}

Verify Discard Button visible
    [Documentation]    Composes a new email, attaches submission assets, and verifies the Discard button works as expected.
    ...    ${email_data} is a dictionary containing 'From', 'To', 'Subject', 'Body', and 'FileNames'.
    [Arguments]    ${email_data}

    Switch To Email Tab

    # Click appropriate new email button
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    IF    ${is_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Create New Message button.
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click New Email button.
    END

    # Verify new message title is visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=New Message title is not present in the NEW Email.

    # Fill email details
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}
    Fill Text    ${RecipientsField}    ${email_data['To']}
    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}
    Fill Text    ${EmailBody}    ${email_data['Body']}

    # Attach submission assets
    ${clicked}=    Run Keyword And Return Status    Click    ${SubmissionAssetsButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Submission Assets button.
    Set Viewport Size    2560    1440

    FOR    ${file}    IN    @{email_data['FileNames']}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${SubmissionAssetsDialog}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=SubmissionAssetsDialog is not available while creating the mail.
        ${asset_name}=    Catenate    SEPARATOR=    ${SelectOriginalDocument}    ${file}    ${SelectOriginalDocument_checkbox}
        ${clicked}=    Run Keyword And Return Status    Check Checkbox    ${asset_name}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to check checkbox for file ${file}.
    END
    ${clicked}=    Run Keyword And Return Status    Click    ${Attach1AssetButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Attach button.
    Set Viewport Size    1280    720

    ${counter}=    Set Variable    1
    FOR    ${file}    IN    @{email_data['FileNames']}
        ${attachment_text_locator}=    Catenate    SEPARATOR=    ${AttachmentText_MultipleValues}    ${counter}    ]
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${attachment_text_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=attachment_text_locator is not present in the NEW Email.
        ${Textvalue}=    Get Text    ${attachment_text_locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${Textvalue}    ${file}
        ${counter}=    Evaluate    ${counter} + 1
    END

    # Verify Discard button
    Get Element States    ${Discard_Button}    validate    value & visible
    ${clicked_discard}=    Run Keyword And Return Status    Click    ${Discard_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_discard}    msg=Failed to click Discard button.

    # Verify new email buttons reappear
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    ${is_visible1}=    Run Keyword And Return Status    Wait For Elements State    ${NewEmailButton}    visible    timeout=${element_timeout}
    ${result}=    Evaluate    ${is_visible} or ${is_visible1}
    Run Keyword And Continue On Failure    Should Be True    ${result}    msg=Neither Create New Message nor New Email button is visible after discard.


# verify the Sov File Are Available in Email Tab
#     [Documentation]    this method
#     [Arguments]    ${email_data}    ${Expected_Filename}
#     Switch To Email Tab
#     ${is_visible}=    Run Keyword And Return Status     Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
#     IF    ${is_visible}
#         Click    ${CreateNewMessageButton}
#     ELSE
#         Click    ${NewEmailButton}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewMessageTitle    ${NewMessageTitle}    visible    New Meesage tittle is not present in the NEW Email 
#     # Wait For Elements State    ${NewMessageTitle}    visible
#     ${fromText}=    Get Attribute    ${FromField}    value
#     Should Be Equal    ${fromText}    ${email_data['From']}
#     Fill Text    ${RecipientsField}    ${email_data['To']}
#     ${subjectText}=    Get Attribute    ${SubjectField}    value
#     Should Be Equal    ${subjectText}    ${email_data['Subject']}
#     Fill Text    ${EmailBody}    ${email_data['Body']}
#     Click    ${SubmissionAssetsButton}
#     ${Actual_File_Name}    Create List
#     ${elements}    Get Elements    ${Email_Files_Loc}   
#     FOR    ${element}    IN    @{elements}
#         ${Text}    Get Text    ${element}
#         ${File_Name}    Strip String    ${Text}
#         Append To List    ${Actual_File_Name}    ${File_Name}
#     END  
#     # FOR    ${element}    IN    @{Expected_Filename}
#     #      List Should Contain Value    ${Actual_File_Name}    ${element}
#     # END   
#         ${current_tab}=    Get Page Ids
#     ${first_tab}=    Set Variable    ${current_tab}[0]
#     # Open new tab
#     New Page    https://robotframework.org
#     ${all_tabs}=    Get Page Ids
#     ${second_tab}=    Set Variable    ${all_tabs}[1]
#     # Switch to 2nd tab
#     # Switch back to 1st tab
#     Switch Page    ${first_tab}
#     ${Expected_File_Names_Back_CurrentTab}    Create List
#     ${elements}    Get Elements    ${Email_Files_Loc}   
#     FOR    ${element}    IN    @{elements}
#         ${File_Name}    Get Text    ${element}
#         Append To List    ${Expected_File_Names_Back_CurrentTab}    ${File_Name}
#     END  
#     Lists Should Be Equal    ${Actual_File_Name}    ${Expected_File_Names_Back_CurrentTab}
#     Click    ${SubmissionAssets_cancel_Button}
verify the Sov File Are Available in Email Tab
    [Documentation]    Verifies that the SOV files are available in the Email tab.
    [Arguments]    ${email_data}    ${Expected_Filename}

    Switch To Email Tab

    # Wait for new message button
    ${is_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateNewMessageButton}    visible    timeout=${display_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${is_visible}    msg=Neither Create New Message nor New Email button is visible.
    IF    ${is_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewMessageButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Create New Message button.
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${NewEmailButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click New Email button.
    END
    # Verify new message title
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewMessageTitle}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=New Message title is not present in the new email.

    # Verify From field
    ${fromText}=    Get Attribute    ${FromField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${fromText}    ${email_data['From']}    msg=From field value mismatch.

    # Fill To and Subject fields
    Fill Text    ${RecipientsField}    ${email_data['To']}
    ${subjectText}=    Get Attribute    ${SubjectField}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${subjectText}    ${email_data['Subject']}    msg=Subject field value mismatch.

    # Fill email body
    Fill Text    ${EmailBody}    ${email_data['Body']}

    # Click Submission Assets
    Click    ${SubmissionAssetsButton}

    # Capture file names
    ${Actual_File_Name}=    Create List
    ${elements}=    Get Elements    ${Email_Files_Loc}   
    FOR    ${element}    IN    @{elements}
        ${Text}=    Get Text    ${element}
        ${File_Name}=    Strip String    ${Text}
        Append To List    ${Actual_File_Name}    ${File_Name}
    END  

    # Verify file names remain the same when switching tabs
    ${current_tab}=    Get Page Ids
    ${first_tab}=    Set Variable    ${current_tab}[0]

    New Page    https://robotframework.org
    ${all_tabs}=    Get Page Ids
    ${second_tab}=    Set Variable    ${all_tabs}[1]

    Switch Page    ${first_tab}

    ${Expected_File_Names_Back_CurrentTab}=    Create List
    ${elements}=    Get Elements    ${Email_Files_Loc}   
    FOR    ${element}    IN    @{elements}
        ${File_Name}=    Get Text    ${element}
        Append To List    ${Expected_File_Names_Back_CurrentTab}    ${File_Name}
    END  

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_File_Name}    ${Expected_File_Names_Back_CurrentTab}    msg=Mismatch in SOV files between initial capture and current tab.

    Click    ${SubmissionAssets_cancel_Button}

Convert IST time to EST time
    [Documentation]    Convert time from IST to EST
    [Arguments]    ${IST_Time}    # Example: 04:08pm
    ${EST_time}=    Evaluate    (datetime.datetime.strptime("${IST_Time}", "%I:%M %p") - datetime.timedelta(hours=5, minutes=30)).strftime("%I:%M%p")    modules=datetime
    RETURN    ${EST_time} 

verify the time format in email tab after send the mail 
    [Documentation]    this method is used to verify the Ist time format to Est time format

    ${Ist_datetime}    Get Text    ${Email_IST_time}
     ${parsed}=    Convert Date    ${Ist_datetime}    
    ...    date_format=%b %d, %Y, %I:%M %p    
    ...    result_format=%I:%M %p
    ${IST_time}    Convert IST time to EST time    ${parsed}
    ${EST_datetime}    Get Text    ${Email_EST_time}
    ${converted}=    Convert Date    ${EST_datetime}    date_format=%I:%M%p today    result_format=%I:%M%p
    Run Keyword And Continue On Failure    Should Contain    ${converted}    ${IST_time}


    
