*** Settings ***
Library    String
Library    Collections
Variables  ../locators/referral_locators.py
Resource   ../../utils/common_keywords.robot

*** Keywords ***
Verify Referral Button 
    Get Element States    ${ReferralButton}    validate    value & visible    message=Referral Button should visible.

# Create New Refer Submission
#     [Arguments]    ${data}    
#     Click    ${ReferralButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReferSubmission    ${ReferSubmission}    visible    ReferSubmission is not avilable to Referral the Submission
#     # Wait For Elements State    ${ReferSubmission}    visible
#     Click    ${ReferralReasonsDropdown}
#     FOR     ${referralReason}    IN    @{data['Reasons']}
#     ${reason}    Catenate    SEPARATOR=    ${ReferralReason1}    ${referralReason}    ${ReferralReason2}
#     Check Checkbox    ${reason}
#     END
#     Click    ${ReferralReasonsDropdown}
#     Click    ${ReferUserDropdown}
#     Fill Text    ${ReferUserField}    ${data['user']}
#     Clear Text    ${ReferUserField}
#     ${user}    Catenate    SEPARATOR=    ${ReferToUser}    ${data['user']}']
#     Click    ${user}
#     Fill Text    ${ReferDetails}    ${data['details']}
#     Get Element States    ${ReferButton}    validate    value & enabled
#     Click    ${ReferButton}

# Create New Refer Submission
#     [Arguments]    ${data}    
#     Click    ${ReferralButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReferSubmission    ${ReferSubmission}    visible    ReferSubmission is not avilable to Referral the Submission
#     # Wait For Elements State    ${ReferSubmission}    visible
#     Click    ${ReferralReasonsDropdown}
#     FOR     ${referralReason}    IN    @{data['Reasons']}
#     ${reason}    Catenate    SEPARATOR=    ${ReferralReason1}    ${referralReason}    ${ReferralReason2}
#     Check Checkbox    ${reason}
#     END
#     Click    ${ReferralReasonsDropdown}
#     Click    ${ReferUserDropdown}
#     Fill Text    ${ReferUserField}    ${data['user']}
#     Clear Text    ${ReferUserField}
#     ${user}    Catenate    SEPARATOR=    ${ReferToUser}    ${data['user']}']
#     Click    ${user}
#     Fill Text    ${ReferDetails}    ${data['details']}    
#         ${AbsolutePath}=    Normalize Path    ${path}${data['FileName']}
#         Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         ${Actual_filenmae}    Get Text    ${Attached_filename}
#         Run Keyword And Continue On Failure    Should Be Equal    ${Actual_filenmae}    ${data['FileName']}
#     Get Element States    ${ReferButton}    validate    value & enabled
#     Click    ${ReferButton}

Create New Refer Submission
    [Arguments]    ${data}

    # Click Referral Button
    ${status}=    Run Keyword And Return Status    Click    ${ReferralButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferralButton is not visible or clickable.'
    
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ReferSubmission}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferSubmission popup did not appear.'

    # Select Referral Reasons
    ${status}=    Run Keyword And Return Status    Click    ${ReferralReasonsDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferralReasonsDropdown is not visible or clickable.'
    
    FOR    ${referralReason}    IN    @{data['Reasons']}
        ${reason}=    Catenate    SEPARATOR=    ${ReferralReason1}    ${referralReason}    ${ReferralReason2}
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${reason}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Referral reason ${referralReason} checkbox not selectable.'
    END
    
    ${status}=    Run Keyword And Return Status    Click    ${ReferralReasonsDropdown}  # Close dropdown
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferralReasonsDropdown could not be closed.'

    # Select User to Refer
    ${status}=    Run Keyword And Return Status    Click    ${ReferUserDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferUserDropdown is not visible or clickable.'
    
    ${status}=    Run Keyword And Return Status    Fill Text    ${ReferUserField}    ${data['user']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferUserField text could not be entered.'
    
    ${status}=    Run Keyword And Return Status    Clear Text    ${ReferUserField}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferUserField could not be cleared.'
    
    ${user}=    Catenate    SEPARATOR=    ${ReferToUser}    ${data['user']}']
    ${status}=    Run Keyword And Return Status    Click    ${user}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Refer user option ${data["user"]} could not be selected.'

    # Fill Details and Upload File
    ${status}=    Run Keyword And Return Status    Fill Text    ${ReferDetails}    ${data['details']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferDetails text could not be entered.'

    ${AbsolutePath}=    Normalize Path    ${path}${data['FileName']}
    ${status}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'File ${data["FileName"]} could not be uploaded.'

    ${Actual_filename}=    Get Text    ${Attached_filename}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_filename}    ${data['FileName']}

    # Submit Referral
    ${status}=    Run Keyword And Return Status    Get Element States    ${ReferButton}    validate    value & enabled
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferButton is not enabled or visible.'
    
    ${status}=    Run Keyword And Return Status    Click    ${ReferButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferButton could not be clicked.'


# Verify the Refer Submission data
#     [Arguments]    ${expectedText}
#     ${actualText}    Get Text    ${ReferredDetails}
#     Log    ${actualText}    console=True
#     FOR    ${text}    IN    @{expectedText}
#         Should Contain    ${actualText}    ${text}
#     END
Verify the Refer Submission data
    [Arguments]    ${expectedText}

    ${status}=    Run Keyword And Return Status    Get Text    ${ReferredDetails}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReferredDetails element is not visible or accessible.'
    ${actualText}=    Get Text    ${ReferredDetails}
    Log    ${actualText}    console=True

    FOR    ${text}    IN    @{expectedText}
        ${status}=    Run Keyword And Return Status    Should Contain    ${actualText}    ${text}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Expected text "${text}" not found in referred details.'
    END


# Verify Referral Pending 
#     Get Element States    ${RferralPending}    validate    value & visible    message=Referral Pending should visible.
Verify Referral Pending
    ${status}=    Run Keyword And Return Status    Get Element States    ${RferralPending}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Referral Pending should be visible.'

# Decline New Refer Submission From Pending Using Referral User
#     [Arguments]    ${data_submissionID}    @{submission_column_names}
#     Click Answers Tab
#     Click    ${ProfileInfobutton}
#     Click    ${LogoutButton}
#     Login with username and password After Logout    ${Login['username']}    ${Login['password']}
#     Click    ${SideBarConvrButton}
#     Create User If the User is not present    ${ReferralUser}
#     Select Impersonate option from the actions    ${ReferralUser['email']}    ${ReferralUser['search_user']}
#     Select Submission using submission id    ${data_submissionID}    @{submission_column_names}
#     Click Answers Tab
#     Run Keyword And Continue On Failure    Wait For Element With Message    RferralPending    ${RferralPending}    visible    RferralPending is not avilable After Referral the Submission
#     # Wait For Elements State    ${RferralPending}    visible
#     Click    ${RferralPending}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReferralDecline    ${ReferralDecline}    visible    ReferralDecline is not avilable After Referral the Submission
#     # Wait For Elements State    ${ReferralDecline}    visible
#     Click    ${ReferralDecline}
#     # FOR     ${referralReason}    IN    @{data['Reasons']}
#     # ${reason}    Catenate    SEPARATOR=    ${ReferralReason1}    ${referralReason}    ${ReferralReason2}
#     # Check Checkbox    ${reason}
#     # END
#     # Click    ${ReferralReasonsDropdown}
#     # Click    ${ReferUserDropdown}
#     # ${user}    Catenate    SEPARATOR=    ${ReferToUser}    ${data['user']}']
#     # Click    ${user}
#     # Fill Text    ${ReferDetails}    ${data['details']}
#     # Get Element States    ${ReferButton}    validate    value & enabled
#     # Click    ${ReferButton}

Decline New Refer Submission From Pending Using Referral User
    [Arguments]    ${data_submissionID}    @{submission_column_names}
    Click Answers Tab
    ${status}=    Run Keyword And Return Status    Click    ${ProfileInfobutton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Profile Info button click failed.'

    ${status}=    Run Keyword And Return Status    Click    ${LogoutButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Logout button click failed.'

    Login with username and password After Logout    ${Login['username']}    ${Login['password']}

    ${status}=    Run Keyword And Return Status    Click    ${SideBarConvrButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Sidebar Conversation button click failed.'

    Create User If the User is not present    ${ReferralUser}
    Select Impersonate option from the actions    ${ReferralUser['email']}    ${ReferralUser['search_user']}
    Select Submission using submission id    ${data_submissionID}    @{submission_column_names}

    Switch To Documents
    ${status}=    Run Keyword And Return Status    Click    ${RferralPending}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Referral Pending is not available after referral the submission'

    ${status}=    Run Keyword And Return Status    Click    ${ReferralDecline}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Referral Decline button is not available after referral the submission'

    