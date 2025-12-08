*** Settings ***
Library    String
Library    Collections
Variables  ../locators/all_submissions.py
Resource   ../../utils/common_keywords.robot
Library    OperatingSystem

*** Variables ***
${FilePath}        ${CURDIR}/../../uploads/ACORD-MSIG.pdf
${path}             ${CURDIR}/../../uploads/
# ${processing_stage_timeout}    1200s
# ${upload_procesing_timeout}    1800s
# ${element_timeout}    3s

*** Keywords ***
# Search Submission by Submission ID
#     [Documentation]    Searches for a submission using the provided submission ID.
#     ...    It first checks if the search input field is visible. If not, it clicks the search button to reveal it.
#     ...    Finally, it types the submission ID into the search field.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submissionID}`: The ID of the submission to search for.
#     [Arguments]    ${data_submissionID}
#     ${fieldStatus}    Run Keyword And Return Status    Wait For Elements State    ${SearchSubmissionField}    visible    timeout=${element_timeout}
#     IF    ${fieldStatus}
#         Log    Search field is visible
#     ELSE
#         # Wait For Elements State    ${SearchSubmissionButton}    visible
#         # Run Keyword And Continue On Failure    Wait For Element With Message    SearchSubmissionButton    ${SearchSubmissionButton}    visible    Search button should be visible to click and open search field
#         Run Keyword And Continue On Failure    Wait For Element With Message    SearchSubmissionButton    ${SearchSubmissionButton}    visible
#         Click    ${SearchSubmissionButton}
#     END
#     # Wait For Elements State    ${SearchSubmissionField}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SearchSubmissionField    ${SearchSubmissionField}    visible    Search field should be visible to enter submission ID
#     Fill Text    ${SearchSubmissionField}    ${data_submissionID}
#     Press Keys    ${SearchSubmissionField}    Enter
Search Submission By Submission ID
    [Documentation]    Searches for a submission using the provided submission ID.
    ...    Checks if the search input field is visible. If not, it clicks the search button to reveal it.
    ...    Finally, it types the submission ID into the search field.
    [Arguments]    ${data_submissionID}

    ${field_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SearchSubmissionField}    visible    timeout=${display_timeout}
    IF    ${field_visible}
        Log Step    "Search Submission: Search field is already visible."
    ELSE
        ${search_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SearchSubmissionButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${search_button_visible}    msg=Search Submission: Search button is not visible to open the search field.

        ${clicked_search_button}=    Run Keyword And Return Status    Click    ${SearchSubmissionButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_search_button}    msg=Search Submission: Failed to click search button to reveal the search field.
    END

    ${field_ready}=    Run Keyword And Return Status    Wait For Elements State    ${SearchSubmissionField}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${field_ready}    msg=Search Submission: Search field did not appear for entering submission ID.

    ${text_filled}=    Run Keyword And Return Status    Fill Text    ${SearchSubmissionField}    ${data_submissionID}
    Run Keyword And Continue On Failure    Should Be True    ${text_filled}    msg=Search Submission: Failed to enter submission ID '${data_submissionID}' in search field.

    ${enter_pressed}=    Run Keyword And Return Status    Press Keys    ${SearchSubmissionField}    Enter
    Run Keyword And Continue On Failure    Should Be True    ${enter_pressed}    msg=Search Submission: Failed to press Enter after entering submission ID '${data_submissionID}'.


# Check the submission for the searched Submission ID
#     [Documentation]    Selects the checkbox corresponding to a given submission ID.
#     ...    It dynamically creates the locator for the checkbox associated with the submission.
#     ...    If the checkbox is already selected, it will be un-checked first before being checked again to ensure a consistent state.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submissionID}`: The submission ID for which to check the checkbox.
#     [Arguments]    ${data_submissionID}
#     ${submission_checkBox}    Catenate    SEPARATOR=    ${SubmissionCheckBox}    ${data_submissionID}    ']
#     # Wait For Elements State    ${submission_checkBox}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    submission_checkBox    ${submission_checkBox}    visible    Submission checkbox is not visible to select the submission
#     ${checkbox_selected}    Run Keyword And Return Status    Get Checkbox State    ${submission_checkBox}
#     IF    ${checkbox_selected}
#         Uncheck Checkbox    ${submission_checkBox}
#     END
#     Check Checkbox    ${submission_checkBox}

Check the submission for the searched Submission ID
    [Documentation]    Selects the checkbox corresponding to a given submission ID.
    ...    It dynamically creates the locator for the checkbox associated with the submission.
    ...    If the checkbox is already selected, it will be un-checked first before being checked again to ensure a consistent state.
    [Arguments]    ${data_submissionID}

    ${submission_checkBox}=    Catenate    SEPARATOR=    ${SubmissionCheckBox}    ${data_submissionID}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${submission_checkBox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission checkbox is not visible to select the submission'

    ${checkbox_selected}=    Run Keyword And Return Status    Get Checkbox State    ${submission_checkBox}
    IF    ${checkbox_selected}
        ${status}=    Run Keyword And Return Status    Uncheck Checkbox    ${submission_checkBox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to uncheck the submission checkbox'
    END

    ${status}=    Run Keyword And Return Status    Check Checkbox    ${submission_checkBox}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to check the submission checkbox'


# Click on the Submission type
#     [Documentation]    Clicks on a specific submission type link.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submission}`: The text of the submission type to be clicked.
#     [Arguments]    ${data_submission}
#     ${locator_submission_type}    Catenate    SEPARATOR=    ${SubmissionType}    ${data_submission}    ']
#     # Wait For Elements State    ${locator_submission_type}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    locator_submission_type    ${locator_submission_type}    visible    Submission Type select is not visible to select the value.
#     Click    ${locator_submission_type}
Click on the Submission type
    [Documentation]    Clicks on a specific submission type link.
    ...    *Arguments:*
    ...    - `${data_submission}`: The text of the submission type to be clicked.
    [Arguments]    ${data_submission}

    ${locator_submission_type}=    Catenate    SEPARATOR=    ${SubmissionType}    ${data_submission}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator_submission_type}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission Type select is not visible to select the value.'

    ${status}=    Run Keyword And Return Status    Click    ${locator_submission_type}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click the submission type link'


Verify Reprocessing Submission Popup
    [Documentation]    Verifies that the reprocessing submission popup appears and then disappears.
    ...    This is useful for ensuring an asynchronous reprocessing action has completed.
    # Wait For Elements State    ${ReprocessingPopup}    visible
    # Wait For Elements State    ${ReprocessingPopup}    detached
    # Run Keyword And Continue On Failure    Wait For Element With Message    ReprocessingPopup    ${ReprocessingPopup}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ReprocessingPopup}    visible    timeout=${element_timeout}
    Should Be True    ${status}    'Reprocessing Submission Popup is not displayed with in '${element_timeout}''
    # Run Keyword And Continue On Failure    Wait For Element With Message    ReprocessingPopup    ${ReprocessingPopup}    detached
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ReprocessingPopup}    detached    timeout=${element_timeout}
    Should Be True    ${status}    'Reprocessing Submission Popup is not detached with in '${element_timeout}''
    
# Click on the Preview Submission - Eye icon
#     [Documentation]    Opens the submission preview by clicking the 'eye' icon.
#     ...    It first hovers over the company name associated with the submission ID to make the preview icon visible.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submissionID}`: The ID of the submission to preview.
#     [Arguments]    ${data_submissionID}
#     ${locator_company_name}    Catenate    SEPARATOR=    ${CompanyName}    ${data_submissionID}    ']
#     # Wait For Elements State    ${locator_company_name}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    locator_company_name    ${locator_company_name}    visible
#     Hover    ${locator_company_name}
#     # Wait For Elements State    ${EyeIcon}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    EyeIcon    ${EyeIcon}    visible
#     Click    ${EyeIcon}

Click on the Preview Submission - Eye icon
    [Documentation]    Opens the submission preview by clicking the 'eye' icon.
    ...    It first hovers over the company name associated with the submission ID to make the preview icon visible.
    ...    *Arguments:*
    ...    - `${data_submissionID}`: The ID of the submission to preview.
    [Arguments]    ${data_submissionID}

    ${locator_company_name}=    Catenate    SEPARATOR=    ${CompanyName}    ${data_submissionID}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Company name element is not visible'

    ${status}=    Run Keyword And Return Status    Hover    ${locator_company_name}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to hover over company name'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${EyeIcon}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Eye icon is not visible'

    ${status}=    Run Keyword And Return Status    Click    ${EyeIcon}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click the eye icon'


# Verify side bar menu is displayed
#     [Documentation]    Verifies that the submission preview side bar menu is displayed.
#     ...    It also retrieves the company name from the preview tab as part of the verification.
#     # Wait For Elements State    ${PreviewSubmissionTab}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PreviewSubmissionTab    ${PreviewSubmissionTab}    visible
#     Get Text    ${CompanyNameInPreviewTab}

Verify side bar menu is displayed
    [Documentation]    Verifies that the submission preview side bar menu is displayed.
    ...    It also retrieves the company name from the preview tab as part of the verification.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PreviewSubmissionTab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Preview submission tab is not visible'

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${CompanyNameInPreviewTab}    attached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=CompanyNameInPreviewTab element is not visible, cannot get company name.

    IF    ${visible}
        ${company_name}=    Get Text    ${CompanyNameInPreviewTab}
        Log    Company name in preview tab: ${company_name}
    END


# 
# Verify Address1 in side menu bar
#     [Documentation]    Verifies the first line of the address in the side menu bar.
#     ...
#     ...    *Arguments:*
#     ...    - `${expectedAddress}`: The expected address line 1.
#     [Arguments]    ${expectedAddress}
#     ${Address}    Get Text    ${Address1}
#     ${actualAddress}    Strip String    ${Address}
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedAddress}    ${actualAddress}    'Address in sidebar should match the expected address.'
Verify Address1 in side menu bar
    [Documentation]    Verifies the first line of the address in the side menu bar.
    ...    *Arguments:*
    ...    - `${expectedAddress}`: The expected address line 1.

    [Arguments]    ${expectedAddress}

    # Check if Address1 element is visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Address1}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Address1 in sidebar is not visible'

    # Get and strip the actual address text
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Address1}    attached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Address1 element is not visible in sidebar.

    IF    ${visible}
        ${Address}=    Get Text    ${Address1}
        ${actualAddress}=    Strip String    ${Address}

        ${verifyStatus}=    Run Keyword And Return Status    Should Be Equal    ${expectedAddress}    ${actualAddress}    msg=Address in sidebar should match expected.
        Run Keyword And Continue On Failure    Should Be True    ${verifyStatus}    msg=Mismatch in Address1 in sidebar.
    END

# Verify Address2 in side menu bar
#     [Documentation]    Verifies that all parts of the second address line are visible in the side menu bar.
#     ...
#     ...    *Arguments:*
#     ...    - `@{expectedAddress2}`: A list of strings that make up the second address line.
#     [Arguments]    @{expectedAddress2}
#     FOR    ${address2}    IN    @{expectedAddress2}
#         ${address}    Catenate    SEPARATOR=    ${AddressText}    ${address2}    ')]
#         # Wait For Elements State    ${address}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    address    ${address}    visible
#     END
Verify Address2 in side menu bar
    [Documentation]    Verifies that all parts of the second address line are visible in the side menu bar.
    ...    *Arguments:*
    ...    - `@{expectedAddress2}`: A list of strings that make up the second address line.

    [Arguments]    @{expectedAddress2}

    FOR    ${address2}    IN    @{expectedAddress2}
        ${address}=    Catenate    SEPARATOR=    ${AddressText}    ${address2}    ')]'
        
        # Check if each address part is visible using return status
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${address}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Address2 part "${address2}" in sidebar is not visible'
    END


# Close Side bar menu
#     [Documentation]    Closes the submission preview side bar menu.
#     # Wait For Elements State    ${CloseSideBar}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    CloseSideBar    ${CloseSideBar}    visible
#     Click    ${CloseSideBar}
Close Side bar menu
    [Documentation]    Closes the submission preview side bar menu.

    # Check if the Close button is visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CloseSideBar}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Close side bar button is not visible.'

    # Click the Close button
    Click    ${CloseSideBar}

# Verify Submission Id is available
#     [Documentation]    Checks if a submission with the given ID is present in the 'All Submissions' list.
#     ...    It performs a search and checks if the 'No Submissions' message is displayed.
#     ...
#     ...    *Arguments:*
#     ...    - `${submission_id}`: The submission ID to verify.
#     ...
#     ...    *Returns:*
#     ...    - `${submission_id_status}`: `True` if the submission does *not* exist (i.e., 'No Submissions' message is visible), `False` otherwise.
#     [Arguments]    ${submission_id}
#     # Wait For Elements State    ${AllSubmissions}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AllSubmissions    ${AllSubmissions}    visible
#     Search Submission by Submission ID    ${submission_id}
#     ${submission_id_status}    Run Keyword And Return Status    Wait For Elements State    ${NoSubmissions}    visible    timeout=${element_timeout}
#     Click    ${ClearSearch}
#     RETURN    ${submission_id_status}

Verify Submission Id is Available
    [Documentation]    Checks if a submission with the given ID is present in the 'All Submissions' list.
    ...    It performs a search and checks if the 'No Submissions' message is displayed.
    ...
    ...    *Arguments:*
    ...    - `${submission_id}`: The submission ID to verify.
    ...
    ...    *Returns:*
    ...    - `${submission_id_status}`: `True` if the submission does *not* exist (i.e., 'No Submissions' message is visible), `False` otherwise.

    [Arguments]    ${submission_id}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AllSubmissions}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'All Submission is not vissible in submission page'

    Search Submission by Submission ID    ${submission_id}

    ${submission_id_status}=    Run Keyword And Return Status    Wait For Elements State    ${NoSubmissions}    visible    timeout=${element_timeout}

    ${clear_clicked}=    Run Keyword And Return Status    Click    ${ClearSearch}
    Run Keyword And Continue On Failure    Should Be True    ${clear_clicked}    msg=Clear Search button could not be clicked

    RETURN    ${submission_id_status}


# Create new submission if the submission not exists
#     [Documentation]    Creates a new submission if one with the given ID does not already exist.
#     ...    It uses `Verify Submission Id is available` to check for existence.
#     ...    If the submission doesn't exist, it navigates to the new submission page, uploads a default PDF file, and creates the submission.
#     ...
#     ...    *Arguments:*
#     ...    - `${submission_id}`: The submission ID to check for and potentially use for the new submission.
#     ...
#     ...    *Returns:*
#     ...    - The new submission ID if one was created, otherwise the existing `${submission_id}`.
#     [Arguments]    ${submission_id}
#     ${AbsolutePath}=    Normalize Path    ${FilePath}
#     ${submission}    Verify Submission Id is available    ${submission_id}
#     IF    ${submission}
#         Log Step    'Creating New Submission!'
#         # Wait For Elements State    ${NewButton}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    NewButton    ${NewButton}    visible
#         Click    ${NewButton}
#         # Wait For Elements State    ${CreateSubmissionTab}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
#         Click    ${UploadSupportingDocuments}
#         # Wait For Elements State    ${BrowseFile}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
#         Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         Sleep    2s
#         Scroll To Element    ${CreateSubmissionButton}
#         # Wait For Elements State    ${CreateSubmissionButton}    enabled
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    enabled
#         Click    ${CreateSubmissionButton}
#         Sleep    5s
#         # Wait For Elements State    ${Processing}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
#         # Wait For Elements State    ${ProcessingStatus}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible
#         ${retrive_submission_id}    Get Text    ${Locator_SubmissionId}
#         ${get_submission_id}    Strip String    ${retrive_submission_id}
#         # Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
#         Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    detached    The submission is still processing even after timeout=${upload_procesing_timeout}seconds. Aborting test.    timeout=${upload_procesing_timeout}
#         Log Step    'New Submission ID -> ${get_submission_id}'
#         RETURN    ${get_submission_id}
#     ELSE
#         Log Step    '${submission_id} is exists no need to create new one!'
#         RETURN    ${submission_id}
#     END
Create new submission if the submission not exists
    [Documentation]    Creates a new submission if one with the given ID does not already exist.
    ...    Uses `Verify Submission Id is available` to check for existence.
    ...    If the submission doesn't exist, navigates to the new submission page, uploads a default PDF file, and creates the submission.
    ...
    ...    *Arguments:*
    ...    - `${submission_id}`: The submission ID to check for and potentially use for the new submission.
    ...
    ...    *Returns:*
    ...    - The new submission ID if one was created, otherwise the existing `${submission_id}`.

    [Arguments]    ${submission_id}

    ${AbsolutePath}=    Normalize Path    ${FilePath}
    ${submission}=    Verify Submission Id is Available    ${submission_id}

    IF    ${submission}
        Log Step    Creating New Submission!

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'while Creating New Submission the submission new button is not available'
        ${clicked}=    Run Keyword And Return Status    Click    ${NewButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click New button in submission page

        # Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionTab}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'CreateSubmission is not available in new submission page'
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateSubmissionTab}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Create Submission tab

        # Run Keyword And Continue On Failure    Wait For Element With Message    UploadSupportingDocuments    ${UploadSupportingDocuments}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UploadSupportingDocuments}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Upload Supporting Documents is not available in new submission page'
        ${clicked}=    Run Keyword And Return Status    Click    ${UploadSupportingDocuments}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Upload Supporting Documents

        # Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${BrowseFile}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Browse File option is not available in new submission page'
        Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Sleep    2s

        Scroll To Element    ${CreateSubmissionButton}
        # Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    enabled
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Create Submission Button is not available in new submission page'
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateSubmissionButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Create Submission button

        Sleep    5s
        # Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Processing}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Processing is not available in submission page'
        # Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'ProcessingStatus is not available in submission page'
        
        # ${retrieved_submission_id}=    Get Text    ${Locator_SubmissionId}
        # ${get_submission_id}=    Strip String    ${retrieved_submission_id}

        # # Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    detached    The submission is still processing even after timeout=${upload_procesing_timeout} seconds. Aborting test.    timeout=${upload_procesing_timeout}
        # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
        # Run Keyword And Continue On Failure    Should Be True    ${status}    The submission is still processing even after timeout=${upload_procesing_timeout} seconds. Aborting test.
        
        # Log Step    New Submission ID -> ${get_submission_id}
        # RETURN    ${get_submission_id}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Locator_SubmissionId}    attached    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Submission ID element '${Locator_SubmissionId}' is not visible. Cannot retrieve submission ID.

        IF    ${visible}
            ${retrieved_submission_id}=    Get Text    ${Locator_SubmissionId}
            ${get_submission_id}=    Strip String    ${retrieved_submission_id}
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    The submission is still processing even after timeout=${upload_procesing_timeout} seconds. Aborting test.
            Log Step    New Submission ID -> ${get_submission_id}
            RETURN    ${get_submission_id}
        END

    ELSE
        Log Step    ${submission_id} exists; no need to create a new one!
        RETURN    ${submission_id}
    END


# Create new submission
#     [Documentation]    Creates a new submission by uploading a specified file.
#     ...    This keyword handles the full UI flow for creating a submission: setting filters, rearranging columns, clicking 'New', uploading the file, and waiting for processing to complete.
#     ...
#     ...    *Arguments:*
#     ...    - `${file_name}`: The name of the file to upload from the `uploads` directory.
#     ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
#     ...
#     ...    *Returns:*
#     ...    - The ID of the newly created submission.
#     [Arguments]    ${file_name}    @{submission_column_names}
#     ${AbsolutePath}=    Normalize Path    ${path}${file_name}
#     Log    ${AbsolutePath}
#         Select Date Filter option    Today
#         Click All submissions option
#         Rearrange Submission Page Columns    @{submission_column_names}
#         Log Step    'Creating New Submission!'
#         # Wait For Elements State    ${NewButton}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    NewButton    ${NewButton}    visible
#         Click    ${NewButton}
#         Sleep    3s
#         ${status}    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible    'SelectPage should be visible.'
#         IF    ${status}  
#         Select Options By    ${SelectPage}    text    100
#         END
#         Sleep    2s
#         # ${existingSubmissionCount1}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount1}
#         # Wait For Elements State    ${CreateSubmissionTab}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
#         Click    ${UploadSupportingDocuments}
#         # Wait For Elements State    ${BrowseFile}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
#         Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         Sleep    2s
#         Scroll To Element    ${CreateSubmissionButton}
#         # Wait For Elements State    ${CreateSubmissionButton}    enabled
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    visible
#         Click    ${CreateSubmissionButton}
#         Sleep    5s
#         # Wait For Elements State    ${Processing}    visible 
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
#         # Click My submissions option
#         # Sleep    2s
#         # Click All submissions option
#         # Wait For Elements State    ${ProcessingStatus}    visible
#         #  ${existingSubmissionCount2}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount2}
#         # IF    ${existingSubmissionCount2} == ${existingSubmissionCount1}
#         #    ${index}    Evaluate    ${existingSubmissionCount2} + 1
#         #    ${locator}    Catenate    SEPARATOR=    ${ExistingProcessingStatus}    ${index}    ]  
#         #     Wait For Elements State    ${locator}    visible
#         # END
#         Sleep    15s
#         # Wait For Elements State    ${ProcessingStatus}    visible    timeout=120s  
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible
#         Set Viewport Size    2560    1440  
#         ${retrive_submission_id}    Get Text    ${Locator_SubmissionId}
#         ${get_submission_id}    Strip String    ${retrive_submission_id}
#         Set Viewport Size    1280    720
#         # ${Processing_status}    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
#         # IF    '${Processing_status}' == 'False'
#         #    Log    The submission is still in processing after ${upload_procesing_timeout} seconds
#         #    Fail   The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.
#         # END
#         # Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    detached    The submission is still processing even after timeout=${upload_procesing_timeout} seconds. Aborting test.    timeout=${upload_procesing_timeout}
#         # Wait For Elements State    ${CloseSubmissionPreview}    visible    timeout=${element_timeout}
#         # Click    ${CloseSubmissionPreview}
#         ${status}    Run Keyword And Return Status    Wait For Elements State   ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
#         IF    ${status}    # success
#             Log Step    'New Submission ID -> ${get_submission_id}'
#             RETURN    ${get_submission_id}
#         ELSE
#             RETURN    False
#         END

Create New Submission
    [Documentation]    Creates a new submission by uploading a specified file.
    ...    Handles the full UI flow: setting filters, rearranging columns, clicking 'New', uploading file, and waiting for processing to complete.
    [Arguments]    ${file_name}    @{submission_column_names}

    ${AbsolutePath}=    Normalize Path    ${path}${file_name}
    Log Step    'Normalized file path: ${AbsolutePath}'

    Select Date Filter option    Today

    Click All submissions option

    Log Step    'Creating new submission...'
    
    ${new_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewButton}    visible    timeout=${element_timeout}
    #    Run Keyword And Continue On Failure    Should Be True    ${new_button_visible}    msg=Create New Submission: 'New' button is not visible.
    Should Be True    ${new_button_visible}    msg=Create New Submission: 'New' button is not visible.
    
    ${clicked_new}=    Run Keyword And Return Status    Click    ${NewButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_new}    msg=Create New Submission: Failed to click 'New' button.

    Sleep    3s

    ${select_page_visible}=    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible
    IF    ${select_page_visible}
        ${selected}=    Run Keyword And Return Status    Select Options By    ${SelectPage}    text    100
        Run Keyword And Continue On Failure    Should Be True    ${selected}    msg=Create New Submission: Failed to select '100' in page size dropdown.
    END
    Sleep    2s

    ${create_tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionTab}    visible
    Run Keyword And Continue On Failure    Should Be True    ${create_tab_visible}    msg=Create New Submission: Create Submission tab not visible.
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${UploadSupportingDocuments}    visible    ${display_timeout}
    IF    "${Status}" == "True"
        ${clicked_upload}=    Run Keyword And Return Status    Click    ${UploadSupportingDocuments}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_upload}    msg=Create New Submission: Failed to click 'Upload Supporting Documents' button.
    END
    ${browse_file_visible}=    Run Keyword And Return Status    Wait For Elements State    ${BrowseFile}    visible
    Should Be True    ${browse_file_visible}    msg=Create New Submission: Browse file element not visible.

    ${uploaded}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
    Run Keyword And Continue On Failure    Should Be True    ${uploaded}    msg=Create New Submission: Failed to upload file '${AbsolutePath}'.

    Sleep    2s

    Scroll To Element    ${CreateSubmissionButton}
    
    ${create_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionButton}    visible
    Should Be True    ${create_button_visible}    msg=Create New Submission: 'Create Submission' button not visible.

    ${clicked_create}=    Run Keyword And Return Status    Click    ${CreateSubmissionButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_create}    msg=Create New Submission: Failed to click 'Create Submission' button.

    Sleep    15s
    Reload
    Rearrange Submission Page Columns    @{submission_column_names}

    ${processing_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Processing}    visible
    Run Keyword And Continue On Failure    Should Be True    ${processing_visible}    msg=Create New Submission: 'Processing' indicator not visible after submission.
    Set Viewport Size    2560    1440 
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Locator_SubmissionId}    attached    timeout=${element_timeout}
    Should Be True    ${status}    'Create New Submission: Submission ID not visible.'
    ${retrieved_submission_id}=    Get Text    ${Locator_SubmissionId}
    ${get_submission_id}=    Strip String    ${retrieved_submission_id}
    Set Viewport Size    1280    720
    # FOR    ${index}    IN RANGE    6
    #     Log    Refresh number: ${index + 1}
    #     Reload
    #     Sleep    1 minutes
    # END
    # ${status}=    Run Keyword And Return Status    Wait For Elements State   ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
    # IF    ${status}
    #     Log Step    'New Submission ID -> ${get_submission_id}'
    #     RETURN    ${get_submission_id}
    # ELSE
    #     Log Step    'Submission still processing after ${upload_procesing_timeout} seconds. Returning False.'
    #     RETURN    False
    # END
    ${timeout_stripped}=    Replace String    ${upload_procesing_timeout}    s    ${EMPTY}
    ${end_time}=    Evaluate    time.time() + ${timeout_stripped}    modules=time
    ${status}=    Set Variable    False

    WHILE    time.time() < ${end_time}
        Reload
        Rearrange Submission Page Columns    @{submission_column_names}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=10s
        IF    ${status}
            Log Step    New Submission ID -> ${get_submission_id}
            ${locator_company_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${get_submission_id}    ${BalanceCompanyName})[1]
            ${company_visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${display_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${company_visible}    msg=Select Submission: Company name for submission ID '${get_submission_id}' not visible.
            ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    attached    timeout=${element_timeout}
            Should Be True    ${visible}    msg=Company name locator '${locator_company_name}' is not visible. Cannot retrieve product/company name.
            ${product}=    Get Text    ${locator_company_name}
            Log    Extracted Company Name text: ${product}

            IF    ${{"${product.strip()}" == "Submitted by MSIG TEST"}}
                Fail    Submission unexpectedly displays as 'Submitted by MSIG TEST' for ID: ${get_submission_id}. Possible it could be a extraction issue.
                RETURN    False
            END
            RETURN    ${get_submission_id}
        ELSE
            Log Step    Processing still ongoing... reloading the page and retrying in 2 minute.
            Sleep    120s
        END
    END

    Log Step    Submission still processing even after ${upload_procesing_timeout} seconds. Returning False.
    RETURN    False

# Select Submission using submission id
#     [Documentation]    Selects a specific submission from the 'All Submissions' list by its ID.
#     ...    It configures the view, searches for the submission, and then clicks on the company name to open it.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submissionID}`: The ID of the submission to select.
#     ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
#     [Arguments]    ${data_submissionID}    @{submission_column_names}
#     Click All submissions option
#     Rearrange Submission Page Columns    @{submission_column_names}
#     Search Submission By Submission ID    ${data_submissionID}
#     ${locator_company_name}    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${BalanceCompanyName})[1]
#     # Wait For Elements State    ${locator_company_name}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    locator_company_name    ${locator_company_name}    visible
#     ${locator_product_name}    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${Loc_ProductName})[1]
#     ${product}    Get Text    ${locator_product_name}
#     Click    ${locator_company_name}
#     Sleep    2s
#     ${visible}    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${element_timeout}
#     IF    ${visible}
#          Click    ${locator_company_name}
#     END
#     RETURN    ${product}
Select Submission using submission id
    [Documentation]    Selects a specific submission from the 'All Submissions' list by its ID.
    ...    Configures the view, searches for the submission, and clicks on the company name to open it.
    [Arguments]    ${data_submissionID}    @{submission_column_names}    ${Transaction_type}=''

    Click All submissions option
    Sleep    2s
    Search Submission By Submission ID    ${data_submissionID}
    Sleep    10s
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${transaction_type_value}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Transaction type is not present in the submission page 
    ${actual_transaction_type}    Get Text    ${transaction_type_value}
    Strip String    ${actual_transaction_type}
    IF    ${Transaction_type} == ''
        Run Keyword And Continue On Failure    Should Be Equal    ${actual_transaction_type}    New Business    Expected transaction type is 'New Business' but actual value is '${actual_transaction_type}'
    ELSE
        Run Keyword And Continue On Failure    Should Be Equal    ${actual_transaction_type}    ${Transaction_type}    Expected transaction type is '${Transaction_type}' but actual value is '${actual_transaction_type}'
    END
    Rearrange Submission Page Columns    @{submission_column_names}
    Set Viewport Size    2560    1440

    ${locator_company_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${BalanceCompanyName})[1]
    ${company_visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${company_visible}    msg=Select Submission: Company name for submission ID '${data_submissionID}' not visible.

    ${locator_product_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${Loc_ProductName})[1]
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_product_name}    attached    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Product name locator '${locator_product_name}' is not visible. Cannot retrieve product name.
    ${product}=    Get Text    ${locator_product_name}

    ${clicked}=    Run Keyword And Return Status    Click    ${locator_company_name}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Select Submission: Failed to click company name for submission ID '${data_submissionID}'.
    
    Sleep    2s
    ${still_visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    attached    timeout=${display_timeout}
    IF    ${still_visible}
        ${clicked_again}=    Run Keyword And Return Status    Click    ${locator_company_name}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_again}    msg=Select Submission: Failed to click company name again for submission ID '${data_submissionID}'.
    END
    Set Viewport Size    1280    720
    RETURN    ${product}


# Verify Submission page is displayed
#     [Documentation]    Verifies that the submission details page is displayed correctly after opening a submission.
#     ...    It does this by waiting for the 'Answers' tab and the 'Schema' button to be visible.
#     Run Keyword And Continue On Failure    Wait For Element With Message    AnswerTab    ${Answers}    visible    Waiting for Answer tab option present in Side bar    timeout=${element_timeout}
#     Click    ${Answers}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Schema    ${SchemaButton}    visible    Waiting for Schema button to verify the Answer page is opened    timeout=${element_timeout}
#     Get Element States    ${SchemaButton}    validate    value & visible    'SchemaButton should be visible.'
Verify Submission page is displayed
    [Documentation]    Verifies that the submission details page is displayed correctly after opening a submission.
    ...    It does this by waiting for the 'Answers' tab and the 'Schema' button to be visible.

    ${answers_tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers}    visible    timeout=${element_timeout}
    Should Be True    ${answers_tab_visible}    msg=Verify Submission Page: 'Answers' tab is not visible in the sidebar.

    ${clicked_answers}=    Run Keyword And Return Status    Click    ${Answers}
    Should Be True    ${clicked_answers}    msg=Verify Submission Page: Failed to click on 'Answers' tab.

    ${schema_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SchemaButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${schema_button_visible}    msg=Verify Submission Page: 'Schema' button in Answer Tab is not visible, page may not be loaded correctly.

    # ${schema_button_state}=    Run Keyword And Return Status    Get Element States    ${SchemaButton}    validate    value & visible
    # Run Keyword And Continue On Failure    Should Be True    ${schema_button_state}    msg=Verify Submission Page: 'Schema' button in Answer Tab is not in the expected visible/active state.

# Click Edit Submission
#     [Documentation]    Clicks the 'Edit Submission' button to enable editing fields on the submission page.
#     ...    Then waits for the 'Save Submission' button to become visible.
#     # Check if Save Submission is already visible
#     ${status}    Run Keyword And Return Status    Get Element States    ${SaveSubmission}    validate    value & visible
#     IF    ${status} == False
#         # Wait for Edit Submission button and click
#         Run Keyword And Continue On Failure    Wait For Element With Message    EditSubmission    ${EditSubmission}    visible    Waiting for EditSubmission button to become visible
#         Click    ${EditSubmission}
#         # Wait for Save Submission button to appear
#         Run Keyword And Continue On Failure    Wait For Element With Message    SaveSubmission    ${SaveSubmission}    visible    Waiting for SaveSubmission button after clicking Edit Submission
#     END
Click Edit Submission
    [Documentation]    Clicks the 'Edit Submission' button to enable editing fields on the submission page.
    ...    Then waits for the 'Save Submission' button to become visible.

    # Check if Save Submission is already visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${display_timeout}
    IF    ${status} == False
        ${edit_visible}=    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${display_timeout}
        Should Be True    ${edit_visible}    msg=Click Edit Submission: 'Edit Submission' button is not visible in the submission page. Cannot proceed to click it.

        ${clicked}=    Run Keyword And Return Status    Click    ${EditSubmission}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Click Edit Submission: Failed to click the 'Edit Submission' button. Ensure it is enabled and not obscured.

        ${save_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${element_timeout}
        Should Be True    ${save_visible}    msg=Click Edit Submission: 'Save Submission' button did not appear after clicking 'Edit Submission'. Verify the page loaded correctly.
        sleep    5s
    END

# Click and verify Clearance tab
#     [Documentation]    Navigates to the 'Clearance' tab within a submission and verifies it is displayed.
#     Run Keyword And Continue On Failure    Wait For Element With Message    Clearance    ${Clearance}    visible    Waiting for Clearance tab option present in side bar    
#     Click    ${Clearance}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearanceHeader    ${ClearanceTab}    visible    waiting for clearance header to verify clearance page is opened     
Click And Verify Clearance Tab
    [Documentation]    Navigates to the 'Clearance' tab within a submission and verifies that the tab content is displayed successfully.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Clearance}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Click And Verify Clearance Tab: 'Clearance' tab is not visible in the side menu. Cannot proceed to open it.

    ${clicked}=    Run Keyword And Return Status    Click    ${Clearance}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Click And Verify Clearance Tab: Failed to click the 'Clearance' tab. Ensure it is enabled and not obscured.

    ${header_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceTab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${header_visible}    msg=Click And Verify Clearance Tab: 'Clearance Header' did not appear after clicking the tab. Verify the tab content loaded successfully.

# Click Insured Tab
#     [Documentation]    Navigates to the 'Insured' tab within a submission.
#     # Wait For Elements State    ${Insured}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Insured    ${Insured}    visible
#     Click    ${Insured}
Click Insured Tab
    [Documentation]    Navigates to the 'Insured' tab within a submission.
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Insured}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Insured tab is not visible.
    ${clicked}=    Run Keyword And Return Status    Click    ${Insured}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click the Insured tab.


Verify PDF Data in Insured Tab
    [Documentation]    Verifies that the text of specific fields in the 'Insured' tab matches the expected data.
    ...    The fields checked are hardcoded within the keyword.
    ...
    ...    *Arguments:*
    ...    - ${ExpectedPDFText}`: A list of strings containing the expected text for each verified field.
    [Arguments]    ${ExpectedPDFText}
    ${locators}     Create List    ${InsuredName}    ${InsuredAddress}    ${InsuredAddressStreet}    ${InsuredAddressCity}    ${InsuredAddressState}    ${InsuredAddressPostalCode}    ${InsuredAddressCounty}    ${InsuredAddressCountry}
    ${ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        Scroll To Element    ${locator}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Locator '${locator}' is not visible. Cannot capture text.
        ${text}    Get Text    ${locator}
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ActualPDFText}
    Log    ${ExpectedPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}    'PDF text content should match the expected values.'

Fill the data for issue fields
    [Documentation]    Fills in the SIC Code, SIC Description, and NAICS code fields in the 'Insured' tab.
    ...    It handles clicking to enable the input fields before typing.
    ...
    ...    *Arguments:*
    ...    - `${data_sic_code}`: The SIC code to enter.
    ...    - `${data_sic_description}`: The SIC description to enter.
    ...    - `${data_naisc_code}`: The NAICS code to enter.
    [Arguments]    ${data_sic_code}    ${data_sic_description}    ${data_naisc_code}
    Get Element States    ${Insured_code_button}    validate    value & visible    'Insured_code_button should be visible.'
    Click With Options    ${Insured_code_button}    clickCount=2
    Click    ${Insured_code_button}
    ${status}    Run Keyword And Return Status    Get Element States    ${Insured_code_button}    validate    value & visible 
    IF    ${status}    
    Click    ${Insured_code_button}
    END
    # Wait For Elements State    ${Insured_code_input}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Wait For Element With Message    Insured_code_input    ${Insured_code_input}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Insured_code_input}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Insured code input filed is not visible to in clearance tab'
    Clear Text    ${Insured_code_input}
    Sleep    2s
    Type Text    ${Insured_code_input}    ${data_sic_code}
    Get Element States    ${InsuredDescriptionButton}    validate    value & visible    'InsuredDescriptionButton should be visible.'
    Click With Options    ${InsuredDescriptionButton}    clickCount=2 
    Click    ${InsuredDescriptionButton}
    ${status1}    Run Keyword And Return Status    Get Element States    ${InsuredDescriptionButton}    validate    value & visible 
    IF    ${status1}    
    Click    ${InsuredDescriptionButton}
    END
    Sleep    2s
    # Wait For Elements State    ${InsuredDescriptionInput}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Wait For Element With Message    InsuredDescriptionInput    ${InsuredDescriptionInput}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${InsuredDescriptionInput}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Insured Description Input filed is not visible in clearance tab'
    Type Text     ${InsuredDescriptionInput}    ${data_sic_description}
    Scroll To    ${InsuredNAICSCode}    top
    Get Element States    ${InsuredNAICSCode}    validate    value & visible    'InsuredNAICSCode should be visible.'
    Click With Options    ${InsuredNAICSCode}    clickCount=2
    Sleep    2s
    Type Text    ${InsuredNAICSInput}    ${data_naisc_code}
  
Verify User Mod is message for updated fields
    [Documentation]    Verifies that the 'User Modified' indicator is visible for the SIC and NAICS code fields after they have been edited.
    @{locators}    Create List    ${UserModeForCode}    ${UserModeForDescription}    ${UserModeInNAICS}
    FOR    ${locator}    IN    @{locators}
        Get Element States    ${locator}    validate    value & visible    'Locator should be visible.'
    END

# Click Processing Tab
#     [Documentation]    Navigates to the 'Processing' tab within a submission.
#     Hover    ${Insured_code_button}
#     Scroll To Element    ${processingInSubmission}
#     # Wait For Elements State    ${processingInSubmission}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    processingInSubmission    ${processingInSubmission}    visible
#     Click    ${processingInSubmission}
Click Processing Tab
    [Documentation]    Navigates to the 'Processing' tab within a submission.

    Hover    ${Insured_code_button}
    Scroll To Element    ${processingInSubmission}

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${processingInSubmission}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Processing tab is not visible

    ${clicked}=    Run Keyword And Return Status    Click    ${processingInSubmission}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Processing tab


Fill the data for issue fields in processing
    [Documentation]    Fills in the Underwriter and Operations contact information in the 'Processing' tab.
    ...
    ...    *Arguments:*
    ...    - `${data_UnderwriterName}`: The name of the underwriter.
    ...    - `${data_UnderWriterEmail}`: The email of the underwriter.
    ...    - `${data_OperationsName}`: The name of the operations contact.
    ...    - `${data_OperationsEmail}`: The email of the operations contact.
    [Arguments]    ${data_UnderwriterName}    ${data_UnderWriterEmail}    ${data_OperationsName}     ${data_OperationsEmail}    ${data_UnderwrittingOffice}    ${data_Channel}
    # Wait For Elements State    ${UnderwriterName}    visible    timeout=${element_timeout}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${UnderwriterName}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=UnderwriterName is not visible
   
    Click    ${UnderwriterName}
    Type Text    ${UnderwriterInput}    ${data_UnderwriterName}
    Click    ${UnderwriterEmail}
    Type Text    ${UnderwriterEmailInput}    ${data_UnderWriterEmail}
    Get Element States    ${UnderwrittingOffice}    validate    value & visible    'UnderwrittingOffice should be visible.'
    Click    ${UnderwrittingOffice}
    Type Text    ${UnderwrittingOfficeInput}    ${data_UnderwrittingOffice}
    Get Element States    ${OperationsName}    validate    value & visible    'OperationsName should be visible.'
    Click    ${OperationsName}
    Type Text    ${OperationsNameInput}    ${data_OperationsName}
    Get Element States    ${OperationsEmail}    validate    value & visible    'OperationsEmail should be visible.'
    Click    ${OperationsEmail}
    Type Text    ${OperationsEmailInput}    ${data_OperationsEmail}
    Get Element States    ${Channel}    validate    value & visible    'Channel should be visible.'
    Click    ${Channel}
    Type Text    ${ChannelInput}    ${data_Channel}

Click Producer Tab
    [Documentation]    Navigates to the 'Producer' tab within a submission.
    Scroll To Element    ${producer}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${producer}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Producer tab is not visible on the screen.
    ${clicked}=    Run Keyword And Return Status    Click    ${producer}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on Producer tab.


Verify PDF Data in Producer Tab
    [Documentation]    Verifies that the text of specific fields in the 'Producer' tab matches the expected data.
    ...    The fields checked are hardcoded within the keyword.
    ...
    ...    *Arguments:*
    ...    - `@{ExpectedPDFText}`: A list of strings containing the expected text for each verified field.
    [Arguments]    @{ExpectedPDFText}
    @{locators}     Create List    ${Agency}    ${ProducerAddress}    ${ProducerAddressStreet}    ${ProducerAddress2}    ${ProducerAddressCity}    ${ProducerAddressState}    ${ProducerPostalCode}    ${ProducerCountry}
    @{ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        Scroll To Element    ${locator}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Locator '${locator}' is not visible. Cannot capture text.
        ${text}    Get Text    ${locator}
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}

Fill the data for issues field in Producer
    [Documentation]    Fills in the Producer's name, email, and optionally their code in the 'Producer' tab.
    ...
    ...    *Arguments:*
    ...    - `${data_producer_name}`: The name of the producer.
    ...    - `${data_producer_email}`: The email of the producer.
    ...    - `${data_producer_code}`: (Optional) The code for the producer.
    [Arguments]    ${data_producer_name}    ${data_producer_email}    ${data_producer_code}=None
    Scroll To Element    ${ProducerName}
    Click    ${ProducerName}
    Type Text    ${ProducerNameInput}    ${data_producer_name}
    Get Element States    ${UserModForProducerName}    validate    value & visible    'UserModForProducerName should be visible.'
    Scroll To Element    ${ProducerEmailButton}
    Click    ${ProducerEmailButton}
    Type Text    ${ProducerEmailInput}    ${data_producer_email}
    Get Element States    ${UserModForProducerEmail}    validate    value & visible    'UserModForProducerEmail should be visible.'
    IF    '${data_producer_code}' != 'None'
        Scroll To Element    ${ProducerCodeButton}
        Click    ${ProducerCodeButton}
        Type Text    ${ProducerCodeInput}    ${data_producer_code}
        Get Element States    ${UserModForProducerCode}    validate    value & visible    'UserModForProducerCode should be visible.'
    END

Click Coverage Tab
    [Documentation]    Navigates to the 'Coverage' tab within a submission.
    Scroll To Element    ${Coverage}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Coverage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage tab is not visible.
    ${clicked}=    Run Keyword And Return Status    Click    ${Coverage}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Coverage tab.

    
Verify the Coverage data
    [Documentation]    Verifies the effective date, expiration date, and product type in the 'Coverage' tab.
    ...
    ...    *Arguments:*
    ...    - `${data_expected_eff_date}`: The expected effective date.
    ...    - `${data_expected_expiry_date}`: The expected expiration date.
    ...    - `${data_expected_product}`: The expected product type.
    [Arguments]    ${data_expected_eff_date}    ${data_expected_expiry_date}    ${data_expected_product}
    # Wait For Elements State    ${EffectiveDate}    visible    timeout=${element_timeout}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${EffectiveDate}    attached    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Effective Date field is not visible.
    ${actualEffectiveDate}    Get Text    ${EffectiveDate}
    ${trimEffectiveDate}    Strip String    ${actualEffectiveDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${data_expected_eff_date}    ${trimEffectiveDate}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ExpirationDate}    attached    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Expiration Date Date field is not visible.
    ${actualExpirationDate}    Get Text    ${ExpirationDate}
    ${trimExpirationDate}    Strip String    ${actualExpirationDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${data_expected_expiry_date}    ${trimExpirationDate}

# Fill the data for issues field in Coverage
#     [Arguments]    ${data}
#         Add LOB if not present    ${data['Product']}
#         Click    ${ProductSegment}
#         Click    ${ProductSegmentDropdown}
#         ${value}    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${data['ProductSegment']}    '])[1]
#         # Wait For Elements State    ${value}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    value    ${value}    visible
#         Click    ${value}
Fill the data for issues field in Coverage
    [Arguments]    ${data}

    Add LOB if not present    ${data['Product']}

    # Click Product Segment field
    ${status}=    Run Keyword And Return Status    Click    ${ProductSegment}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Product Segment field.

    # Open Product Segment dropdown
    ${status}=    Run Keyword And Return Status    Click    ${ProductSegmentDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to open Product Segment dropdown.

    # Build option locator
    ${value}=    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${data['ProductSegment']}    '])[1]'

    # Wait for option to be visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage Product Segment option '${data['ProductSegment']}' is not visible in dropdown.

    # Click option
    ${clicked}=    Run Keyword And Return Status    Click    ${value}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select Product Segment option '${data['ProductSegment']}' from dropdown.



# Click Issues Tab
#     [Documentation]    Navigates to the 'Issues' tab within a submission.
#     Scroll To Element    ${Issues_tab}
#     # Wait For Elements State    ${Issues_tab}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Issues_tab    ${Issues_tab}    visible
#     Click    ${Issues_tab}
Click Issues Tab
    [Documentation]    Navigates to the 'Issues' tab within a submission.
    Scroll To Element    ${Issues_tab}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Issues_tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Issues tab is not visible in the submission.
    ${clicked}=    Run Keyword And Return Status    Click    ${Issues_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click the Issues tab.


Verify updated datas in Issues Tab
    [Documentation]    Verifies that data updated in other tabs (Insured, Processing, Producer) is correctly reflected in the 'Issues' tab.
    ...
    ...    *Arguments:*
    ...    - `@{ExpectedPDFText}`: A list of strings containing the expected text for each verified field.
    [Arguments]    @{ExpectedPDFText}
    @{locators}     Create List    ${Issues_sic_code}    ${Issues_description}    ${Issues_naics_code}    ${Issues_underwriter_name}    ${Issues_underwriter_email}    ${Issues_underwritting_office}    ${Issues_operations_name}    ${Issues_operations_email}    ${Issues_channel}    ${Issues_producer_name}
    @{ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Locator '${locator}' is not visible. Cannot capture text.
        Scroll To Element    ${locator}
        ${text}    Get Text    ${locator}
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}

# Click Finish Tab
#     [Documentation]    Navigates to the 'Finish' tab within a submission.
#     Scroll To Element    ${Finish_tab}
#     # Wait For Elements State    ${Finish_tab}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Finish_tab    ${Finish_tab}    visible
#     Click    ${Finish_tab}
Click Finish Tab
    [Documentation]    Navigates to the 'Finish' tab within a submission.
    Scroll To Element    ${Finish_tab}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Finish_tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Finish tab is not visible in the submission.
    ${clicked}=    Run Keyword And Return Status    Click    ${Finish_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click the Finish tab.


# Verify and click the save and close button
#     [Documentation]    Verifies the 'Finish' tab is correctly displayed and then clicks the 'Save and Close' button.
#     # Wait For Elements State    ${All_Done}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    All_Done    ${All_Done}    visible
#     Get Element States    ${Please_Review_Msg}    validate    value & visible    'Please_Review_Msg should be visible.'
#     Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
#     Click    ${SaveAndClose}    
#     ${error_Message}    Run Keyword And Return Status    Wait For Elements State    ${Error_Saving_popup}    visible    'Error_Saving_popup should not be visible.'
#     # Wait For Elements State    ${Error_Saving_popup}    hidden    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Error_Saving_popup    ${Error_Saving_popup}    hidden
#     IF    ${error_Message} == True
#         Run Keyword And Continue On Failure    Fail    Error popup occurred while saving changes!
#         Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
#         Wait For Elements State    ${SaveAndClose}    enabled    timeout=${element_timeout}
#         Click    ${SaveAndClose}
#     END
#     # Wait For Elements State    ${processingStage1}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    processingStage1    ${processingStage1}    visible
#     # Wait For Elements State    ${processingStage1}    hidden    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    processingStage1    ${processingStage1}    hidden
Verify and click the save and close button
    [Documentation]    Verifies the 'Finish' tab is correctly displayed and then clicks the 'Save and Close' button.

    ${done_visible}=    Run Keyword And Return Status    Wait For Elements State    ${All_Done}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${done_visible}    msg='All_Done message is not visible on Finish tab.'

    Get Element States    ${Please_Review_Msg}    validate    value & visible    'Please review message should be visible.'
    Get Element States    ${SaveAndClose}        validate    value & visible    'Save and Close button should be visible.'

    ${clicked}=    Run Keyword And Return Status    Click    ${SaveAndClose}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg='Failed to click Save and Close button.'

    ${error_popup}=    Run Keyword And Return Status    Wait For Elements State    ${Error_Saving_popup}    visible    timeout=3s
    ${hidden_status}=    Run Keyword And Return Status    Wait For Elements State    ${Error_Saving_popup}    hidden    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${hidden_status}    msg='Error Saving popup did not hide. Something went wrong during form save.'

    IF    ${error_popup}
        Run Keyword And Continue On Failure    Fail    Error popup occurred while saving changes!

        ${visible_again}=    Run Keyword And Return Status    Wait For Elements State    ${SaveAndClose}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible_again}    msg='Save and Close button not visible after error popup.'

        ${enabled}=    Run Keyword And Return Status    Wait For Elements State    ${SaveAndClose}    enabled    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${enabled}    msg='Save and Close button still disabled after error popup.'

        ${clicked2}=    Run Keyword And Return Status    Click    ${SaveAndClose}
        Run Keyword And Continue On Failure    Should Be True    ${clicked2}    msg='Failed to click Save and Close button after error popup.'
    END

    ${stage_visible}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${stage_visible}    msg='Processing Stage 1 is not visible after saving the form.'

    ${stage_hidden}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    hidden    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${stage_hidden}    msg='Processing Stage 1 did not hide after saving the form.'

# Verify Error popup is exists
#      ${error_Message}    Run Keyword And Return Status    Get Element States    ${Error_Saving_popup}
#     IF    ${error_Message} == True
#     Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
#     # Wait For Elements State    ${SaveAndClose}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    SaveAndClose    ${SaveAndClose}    visible
#     # Sleep    60s
#     Click    ${SaveAndClose}
#     END
Verify Error popup is exists
    ${error_Message}=    Run Keyword And Return Status    Get Element States    ${Error_Saving_popup}    validate    value & visible

    IF    ${error_Message}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${SaveAndClose}    visible    timeout=5s
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Save and Close button is not visible after error popup.'

        ${clicked}=    Run Keyword And Return Status    Click    ${SaveAndClose}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg='Failed to click Save and Close button after error popup.'
    END


# Switch to Documents
#     [Documentation]    Switches the view to the 'Documents' section for the current submission.
#     Run Keyword And Continue On Failure    Wait For Element With Message    Document    ${Documents}    visible    Wait for document tab should be visible in the side bar    timeout=${element_timeout}
#     # ${promise} =         Promise To    Wait For Alert    action=accept
#     # Handle Future Dialogs    action=accept    
#     Click    ${Documents}
    # Run Keyword And Ignore Error    Wait For      ${promise}
    # Click    ${Documents}
Switch To Documents
    [Documentation]    Switches the view to the 'Documents' section for the current submission.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Documents}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Switch To Documents: The 'Documents' tab is not visible in the side menu. Cannot proceed to click it.

    ${clicked}=    Run Keyword And Return Status    Click    ${Documents}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Switch To Documents: Failed to click the 'Documents' tab. Ensure the element is enabled, not obscured, and clickable.

# Verify datas in UserModification file
#     [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
#     ...    It compares a list of expected text values with the actual values found in the document.
#     ...
#     ...    *Arguments:*
#     ...    - `@{expectedText}`: A list of strings with the expected values.
#     [Arguments]    @{expectedText}
#     # Wait For Elements State    ${Document_options}    visible 
#     Run Keyword And Continue On Failure    Wait For Element With Message    Document_options    ${Document_options}    visible
#     Click    ${Document_options}
#     Click    ${Show_Documents}
#     Scroll To Element    ${UserModification}
#     # Wait For Elements State    ${UserModification}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    UserModification    ${UserModification}    visible
#     Click    ${UserModification}
#     @{variables}    Get Elements    ${UserModificationVariable}
#     @{values}    Get Elements    ${UserModificationValue}
#     @{actualText}    Create List    
#     FOR    ${value}    IN    @{values}
#         ${text}    Get Text    ${value}
#         ${trimValue}    Strip String    ${text}
#         Append To List    ${actualText}    ${trimValue}
#     END
#     Log    ${expectedText}
#     Log    ${actualText}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}
Verify datas in UserModification file
    [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
    ...    Compares a list of expected text values with the actual values found in the document.
    [Arguments]    @{expectedText}

    # Wait for Document options to be visible
    ${doc_options_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Document_options}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${doc_options_visible}    msg=UserModification Verification: 'Document options' is not visible. Cannot proceed.

    Click    ${Document_options}
    ${clicked_show}=    Run Keyword And Return Status    Click    ${Show_Documents}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_show}    msg=UserModification Verification: Failed to click 'Show Documents' button.

    Scroll To Element    ${UserModification}

    ${doc_visible}=    Run Keyword And Return Status    Wait For Elements State    ${UserModification}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${doc_visible}    msg=UserModification Verification: 'UserModification' document is not visible in Documents section.

    Click    ${UserModification}

    ${variables}=    Get Elements    ${UserModificationVariable}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${variables}    msg=UserModification Verification: No variable elements found in 'UserModification' document.

    ${values}=    Get Elements    ${UserModificationValue}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${values}    msg=UserModification Verification: No value elements found in 'UserModification' document.

    @{actualText}=    Create List
    FOR    ${value}    IN    @{values}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Locator '${value}' is not visible. Cannot capture text.

        ${text}=    Get Text    ${value}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=UserModification Verification: Failed to get text from an element in 'UserModification' document.
        ${trimValue}=    Strip String    ${text}
        Append To List    ${actualText}    ${trimValue}
    END

    Log    ${expectedText}
    Log    ${actualText}

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}    msg=UserModification Verification: Actual values in the document do not match expected values.
    
# Save Submission
#     [Documentation]    Clicks the 'Save Submission' button.
#     # Wait For Elements State    ${SaveSubmission}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SaveSubmission    ${SaveSubmission}    visible
#     Click    ${SaveSubmission}
Save Submission
    [Documentation]    Clicks the 'Save Submission' button and verifies it is visible before clicking.
    
    # Wait for Save Submission button to be visible
    ${saveVisible}=    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${display_timeout}
    Should Be True    ${saveVisible}    msg=Save Submission button is not visible; cannot proceed to click.

    # Click the Save Submission button
    ${status}=    Run Keyword And Return Status    Click    ${SaveSubmission}
    Should Be True    ${status}    msg=Failed to click Save Submission button.


# Verify Save Submission Popup
#     [Documentation]    Verifies that the 'Are you sure?' popup is displayed after clicking 'Save Submission'.
#     Get Element States    ${AreYouSurePopup}    validate    value & visible    'AreYouSurePopup should be visible.'
#     Get Element States    ${CancelButtonInSave}    validate    value & visible    'CancelButtonInSave should be visible.'
#     Get Element States    ${ContinueButtonInSave}    validate    value & visible    'ContinueButtonInSave should be visible.'
Verify Save Submission Popup
    [Documentation]    Verifies that the 'Are you sure?' popup is displayed after clicking 'Save Submission' and all relevant buttons are visible.
    
    # Verify Are You Sure popup is visible
    ${popupVisible}=    Run Keyword And Return Status    Wait For Elements State    ${AreYouSurePopup}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${popupVisible}    msg=Are You Sure popup is not visible after clicking Save Submission.
    
    # Verify Cancel button is visible
    ${cancelVisible}=    Run Keyword And Return Status    Wait For Elements State    ${CancelButtonInSave}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${cancelVisible}    msg=Cancel button is not visible in Save Submission popup.
    
    # Verify Continue button is visible
    ${continueVisible}=    Run Keyword And Return Status    Wait For Elements State    ${ContinueButtonInSave}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${continueVisible}    msg=Continue button is not visible in Save Submission popup.

# Click Continue Button
#     [Documentation]    Clicks the 'Continue' button on the 'Save Submission' confirmation popup.
#     Click    ${ContinueButtonInSave}
Click Continue Button
    [Documentation]    Clicks the 'Continue' button on the 'Save Submission' confirmation popup.
    
    # Wait for the Continue button to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ContinueButtonInSave}    visible    timeout=${display_timeout}
    Should Be True    ${status}    msg=Continue button is not visible; cannot click Continue in after click on Save Submission
    
    # Attempt to click the Continue button with failure message
    ${status}=    Run Keyword And Return Status    Click    ${ContinueButtonInSave}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Continue button in Save Submission popup.


# Save Submission And verify popup
#     [Documentation]    A comprehensive keyword that handles saving a submission, including dealing with a potential 'Reactive' button popup.
#     ...    It will save, verify the confirmation, and click continue. It includes logic to handle a 'Reactive' state if it appears.
#     ${reactiveButtonStatus}    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
#     IF    ${reactiveButtonStatus}
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#         Click    ${Reactive}
#         Click    ${AcceptButtonInReactive}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    detached    Wait for reactive should be detached    timeout=${element_timeout}
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#         Sleep    3s
#         ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${processing_stage_timeout}
#         IF     ${status}
#             Click    ${Side_Bar_Risk360_Button}
#             Switch to Documents
#             Run Keyword And Continue On Failure    Wait For Element With Message    Processing Stage    ${processingStageInLeftMenu}    detached    Wait for processing stage to be detached to verify that processing is completed    timeout=${element_timeout}
#         END
#     ELSE
#        Log    Reactive button is hidden
#     END
#     Sleep    5s
#     Save Submission
#     Run Keyword And Continue On Failure    Verify Save Submission Popup
#     Sleep    5s
#     Click Continue Button
#     Sleep    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Continue button    ${ContinueButtonInSave}    hidden    wait for continue button verify that save submission is clicked 
#     # Sleep    5s
#     Switch to Summary
#     # Wait For Elements State    ${Summary_Processing}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Summary_Processing    ${Summary_Processing}    visible
#     ${ActualValue}    Get text    ${Summary_Processing}
#     Run Keyword And Continue On Failure    Should Be Equal    Read-only while processing    ${ActualValue}
    
#     ${saveSubmissionStatus}    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${element_timeout}
#     IF    ${saveSubmissionStatus}
#     Run Keyword And Continue On Failure    Fail    Error occured while saving Submission,its not saved in first click
#          Save Submission
#         Verify Save Submission Popup
#         Click Continue Button
#         Run Keyword And Continue On Failure    Wait For Element With Message    Continue Button    ${ContinueButtonInSave}    hidden    wait for continue button to be hidden to verfy continue button is clicked
#     END
Save Submission And verify popup
    [Documentation]    Handles saving a submission, including dealing with a potential 'Reactive' button popup.
    ...    Verifies save confirmation and clicks continue. Includes logic to handle a 'Reactive' state if it appears.

    # Check if Reactive button is visible
    ${reactiveButtonStatus}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${display_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${reactiveButtonStatus}    msg=Reactive button not visible; skipping reactive workflow.

    IF    ${reactiveButtonStatus}
        Switch to Documents

        ${status}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Side Bar Risk360 button during Reactive workflow.

        ${status}=    Run Keyword And Return Status    Click    ${Reactive}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Reactive button.

        ${status}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Accept button in Reactive workflow.

        ${reactiveDetached}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    detached    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${reactiveDetached}    msg=Reactive button did not detach after accepting.

        Switch to Documents
        ${status}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Side Bar Risk360 button after Reactive workflow.
        Sleep    3s

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Processing stage in left menu is not visible.

        IF    ${status}
            ${status}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Side Bar Risk360 button for processing stage.
            Switch to Documents

            ${processingDetached}=    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    detached    timeout=${processing_stage_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${processingDetached}    msg=Processing stage did not detach; processing might not be complete.
        END
    ELSE
        Log    Reactive button is hidden; skipping reactive workflow handling.
    END

    Sleep    5s

    # Save Submission
    Run Keyword And Continue On Failure    Save Submission
    Run Keyword And Continue On Failure    Verify Save Submission Popup

    Sleep    5s
    Run Keyword And Continue On Failure    Click Continue Button
    # Sleep    5s
    ${continueHidden}=    Run Keyword And Return Status    Wait For Elements State    ${ContinueButtonInSave}    hidden    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${continueHidden}    msg=Continue button did not hide after clicking; verify save submission clicked.
    
    # Retry Save Submission if not saved
    Sleep    5s
    ${saveSubmissionStatus}=    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${display_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${saveSubmissionStatus}    msg=Save Submission did not appear; first click may have failed.

    IF    ${saveSubmissionStatus}
        # Run Keyword And Continue On Failure    Fail    msg=Error occurred while saving Submission; not saved on first click.
        Run Keyword And Continue On Failure    Save Submission
        Run Keyword And Continue On Failure    Verify Save Submission Popup
        Run Keyword And Continue On Failure    Click Continue Button
        
        ${continueHiddenRetry}=    Run Keyword And Return Status    Wait For Elements State    ${ContinueButtonInSave}    hidden    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${continueHiddenRetry}    msg=Continue button did not hide after retry; verify save submission clicked.
    END
    # Wait For Processing Stage
    # Sleep    5s
    # Verify Summary processing message
    # Switch to Summary
    # ${summaryVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Processing}    visible    timeout=${display_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${summaryVisible}    msg=Summary processing message not visible.

    # ${ActualValue}=    Get Text    ${Summary_Processing}
    # Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Read-only while processing    msg=Summary processing message text mismatch.

# Verify Submission updated
#     [Documentation]    Verifies that the submission has been successfully updated after saving.
#     ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.
#     Click Answers Tab
#     Switch to Documents
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    hidden    timeout=${element_timeout}
#     IF    ${status}
#         Log    'Processing Stage 1 is hidden'
#     ELSE
#         Click Answers Tab
#         Click   ${Side_Bar_Risk360_Button}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing stage    ${processingStage1}    hidden    Wait for processing stage to be hidden to verify Save Submission is completed    timeout=${upload_procesing_timeout}
#     END
#     Switch to Documents
#     Click    ${Side_Bar_Risk360_Button}
#     ${updateSubmissionStatus}    Run Keyword And Return Status    Get Element States    ${UpdatedSubmission}    validate    value & visible    'UpdatedSubmission should be visible.'
#     IF    ${updateSubmissionStatus}
#         Log    Submission Updated is displayed
#     ELSE
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#         Run Keyword And Continue On Failure    Wait For Element With Message    UpdatedSubmission    ${UpdatedSubmission}    visible    Wait for updated submission button to verify that the the submission is updated    timeout=${element_timeout}
#     END
Verify Submission updated
    [Documentation]    Verifies that the submission has been successfully updated after saving.
    ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.

    Click Answers Tab
    Switch to Documents
    # Wait for Processing Stage 1 to be hidden
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    hidden    timeout=${element_timeout}
    IF    ${status}
        Log    Processing Stage 1 is hidden.
    ELSE
        # Retry clicking elements to hide processing stage
        ${clickAnswersRetry}=    Run Keyword And Return Status    Click    ${AnswersTab}
        Run Keyword And Continue On Failure    Should Be True    ${clickAnswersRetry}    msg=Failed to click Answers Tab on retry.

        ${clickSideBar}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clickSideBar}    msg=Failed to click Side Bar Risk360 button on retry.

        ${waitHidden}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    hidden    timeout=${upload_procesing_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${waitHidden}    msg=Processing stage did not hide; Save Submission might not be complete.
    END

    # Ensure we are back in Documents
    Switch to Documents
    # Click Side Bar Risk360 button
    ${clickSideBar2}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clickSideBar2}    msg=Failed to click Side Bar Risk360 button before checking updated submission.

    # Verify Updated Submission is visible
    ${updateSubmissionStatus}=    Run Keyword And Return Status    Get Element States    ${UpdatedSubmission}    validate    value & visible
    IF    ${updateSubmissionStatus}
        Log    Submission Updated is displayed.
    ELSE
        # Retry steps if Updated Submission is not visible
        ${clickSideBar3}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clickSideBar3}    msg=Failed to click Side Bar Risk360 button on retry for updated submission.

        ${waitUpdated}=    Run Keyword And Return Status    Wait For Elements State    ${UpdatedSubmission}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${waitUpdated}    msg=Updated Submission did not appear; submission may not be updated.
    END

# Verify WorkFlow Options Advance Stage and Reject
#     [Documentation]    Verifies that the 'Advance Stage' and 'Reject' buttons are visible in the workflow options.
#     Get Element States    ${Workflow_Advance_Stage}    validate    value & visible    'Workflow_Advance_Stage should be visible.'
#     Get Element States    ${Workflow_Reject}    validate    value & visible    'Workflow_Reject should be visible.'
Verify WorkFlow Options Advance Stage and Reject
    [Documentation]    Verifies that the 'Advance Stage' and 'Reject' buttons are visible in the workflow options.

    # Wait and verify Advance Stage button
    ${advanceVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Advance_Stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${advanceVisible}    msg=Workflow 'Advance Stage' button is not visible.

    # Wait and verify Reject button
    ${rejectVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Reject}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${rejectVisible}    msg=Workflow 'Reject' button is not visible.

# Advance Stage 2
#     [Documentation]    Clicks the 'Advance Stage' button and waits for the submission to move to the next stage.
#     Run Keyword And Continue On Failure    Wait For Element With Message    Advance Stage    ${Workflow_Advance_Stage}    visible    Waiting for Advance Stage Button for switch to next stage     
#     Click    ${Workflow_Advance_Stage}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Processing stage    ${processingStage2}    visible    waiting for processing stage should be completed within ${processing_stage_timeout}    timeout=${processing_stage_timeout}
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${processing_stage_timeout}
#     IF    ${status}
#         Log Step    Processing Stage 2 hidden
#     ELSE
#         Click    ${Side_Bar_Risk360_Button}
#         Switch to Documents
#         ${checkEditSubmission}    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
#         IF    ${checkEditSubmission} 
#             Log    Processing Stage 2 hidden
#         ELSE
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing stage    ${processingStage2}    hidden    waiting for processing stage should be completed within ${processing_stage_timeout}    timeout=${processing_stage_timeout}
#         END
#     END 
Advance Stage 2
    [Documentation]    Clicks the 'Advance Stage' button and waits for the submission to move to the next stage.
    ...    Waits for the processing stage to start, monitors it until hidden, and handles cases where the stage is not immediately hidden.

    # Wait for 'Advance Stage' button to be visible
    switch to Documents
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Advance_Stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to find 'Advance Stage' button within ${element_timeout} seconds.
    # Click 'Advance Stage' button
    ${status}=    Run Keyword And Return Status    Click    ${Workflow_Advance_Stage}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on 'Advance Stage' button.

    # Wait for processing stage to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible    timeout=${processing_stage_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Processing stage did not become visible within ${processing_stage_timeout} seconds.

    # Wait for processing stage to be hidden
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${processing_stage_timeout}
    IF    ${status}
        Log Step    Processing Stage 2 is hidden
    ELSE
        # Navigate back to Risk360 side menu if processing stage is not hidden
        ${status}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Risk360 Side Bar button.

        Switch to Documents

        # Check if Edit Submission is visible
        ${checkEditSubmission}=    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
        IF    ${checkEditSubmission}
            Log    Processing Stage 2 is hidden after navigating to Documents
        ELSE
            # Wait again for processing stage to be hidden
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${processing_stage_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Processing stage did not hide even after navigating to Documents within ${processing_stage_timeout} seconds.
        END
    END

Verify WorkFlow History is Empty For Draft stage
    [Documentation]    Verifies that the workflow history is empty when the submission is in the 'Draft' stage.
    Switch to Documents
    Click    ${WorkFLow_History}
    # Wait For Elements State    ${WorkFlow_History_Empty}    visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    WorkFlow_History_Empty    ${WorkFlow_History_Empty}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${WorkFlow_History_Empty}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'WorkFlow History Empty is not visible to select the submission'
    # Get Element States    ${WorkFlow_History_Empty}    validate    value & visible

# Reject Submission and Verify the Tag name
#     [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
#     ...
#     ...    *Arguments:*
#     ...    - `${FailureReasons}`: A list of reasons for the rejection.
#     ...    - `${data_details}`: A text description of the rejection details.
#     ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.
#     [Arguments]    ${FailureReasons}    ${data_details}    ${action}
#     Click    ${Workflow_Reject}
#     # Wait For Elements State    ${UpdateWorkflowStage}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
#     Get Element States    ${SelectReason}    validate    value & visible    'SelectReason should be visible.'
#     FOR     ${failureReason}    IN    @{FailureReasons}
#     ${reason}    Catenate    SEPARATOR=    ${ReasonForReject1}    ${failureReason}    ${ReasonForReject2}
#     Check Checkbox    ${reason}
#     END
#     Type Text    ${Details}    ${data_details}
#     IF    '${action}' == 'Cancel'
#         Get Element States    ${SelectReason}    validate    value & enabled    'SelectReason should be enabled.'
#         Click    ${CancelButtonInReject}
#         Verify WorkFlow Options Advance Stage and Reject
#         Get Element States    ${InDraftTag}    validate    value & visible    'InDraftTag should be visible.'
#     ELSE
#          Get Element States    ${AcceptButton}    validate    value & enabled    'AcceptButton should be enabled.'
#          Click    ${AcceptButton}
#          Wait For Processing Stage    ""
#          Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
#          Get Element States    ${RejectedTag}    validate    value & visible    'RejectedTag should be visible.'
#     END
Reject Submission and Verify the Tag Name
    [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
    ...
    ...    *Arguments:*
    ...    - `${FailureReasons}`: A list of reasons for the rejection.
    ...    - `${data_details}`: A text description of the rejection details.
    ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.

    [Arguments]    ${FailureReasons}    ${data_details}    ${action}

    ${clicked}=    Run Keyword And Return Status    Click    ${Workflow_Reject}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Workflow Reject button

    # Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UpdateWorkflowStage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Update Workflow Stage is not visible with in '${element_timeout}''
    Get Element States    ${SelectReason}    validate    value & visible    'SelectReason should be visible.'

    FOR    ${failureReason}    IN    @{FailureReasons}
        ${reason}=    Catenate    SEPARATOR=    ${ReasonForReject1}    ${failureReason}    ${ReasonForReject2}
        ${checked}=    Run Keyword And Return Status    Check Checkbox    ${reason}
        Run Keyword And Continue On Failure    Should Be True    ${checked}    msg=Could not check reason: ${failureReason}
    END

    ${filled}=    Run Keyword And Return Status    Type Text    ${Details}    ${data_details}
    Run Keyword And Continue On Failure    Should Be True    ${filled}    msg=Could not fill rejection details

    IF    '${action}' == 'Cancel'
        Get Element States    ${SelectReason}    validate    value & enabled    'SelectReason should be enabled.'
        ${clicked}=    Run Keyword And Return Status    Click    ${CancelButtonInReject}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Cancel button in Reject could not be clicked

        Verify WorkFlow Options Advance Stage and Reject
        Get Element States    ${InDraftTag}    validate    value & visible    'InDraftTag should be visible.'
    ELSE
        Get Element States    ${AcceptButton}    validate    value & enabled    'AcceptButton should be enabled.'
        ${clicked}=    Run Keyword And Return Status    Click    ${AcceptButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Accept button could not be clicked

        Wait For Processing Stage    ""
        Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
        Get Element States    ${RejectedTag}    validate    value & visible    'RejectedTag should be visible.'
    END


# Verify WorkFlow History for Rejection
#     [Documentation]    Verifies that the workflow history correctly logs the details of a rejection.
#     ...
#     ...    *Arguments:*
#     ...    - `${expectedList}`: A list of expected values to find in the history log (e.g., user, stage, details). The current date is prepended automatically.
#     [Arguments]    ${expectedList}
#     ${date}    Get Formatted Current Date
#     Insert Into List    ${expectedList}    0    ${date}
#     Switch to Documents
#     Click    ${WorkFLow_History}
#     ${tableData}    Get Elements    //td[not(ul)]
#     @{actualText}    Create List  
#     FOR    ${data}    IN    @{tableData}
#         ${text}    Get Text    ${data}
#         ${trimValue}    Strip String    ${text}
#         Append To List    ${actualText}    ${trimValue}
#     END
#     ${length}    Get Length    ${expectedList}
#     Log       ${length}
#     FOR     ${index}    IN RANGE    0    ${length} - 1
#         ${expectedTextValue}=     Set Variable    ${expectedList[${index}]}
#         ${actualTextValue}=    Set Variable    ${actualText[${index}]}
#         IF    ${index} == 0
#             Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    
#         ELSE
#             Run Keyword And Continue On Failure    Should Be Equal    ${expectedTextValue}    ${actualTextValue}
#         END
#     END
#     ${rejectionReasons}    Get Elements    //tbody[@test-id='assets-workflow-history']//tr[1]//td//li
#     @{actualReasons}    Create List    
#     FOR    ${reason}    IN    @{rejectionReasons}
#         ${reasonText}    Get Text    ${reason}
#         ${trimText}    Strip String    ${reasonText}
#         Append To List    ${actualReasons}    ${reasonText}
#     END
#     Log    'Actual Text -> @{actualText}'

Verify WorkFlow History for Rejection
    [Documentation]    Verifies that the workflow history correctly logs the details of a rejection.
    ...
    ...    *Arguments:*
    ...    - `${expectedList}`: A list of expected values to find in the history log (e.g., user, stage, details). The current date is prepended automatically.

    [Arguments]    ${expectedList}

    ${date}=    Get Formatted Current Date
    Insert Into List    ${expectedList}    0    ${date}

    Switch to Documents

    ${clicked}=    Run Keyword And Return Status    Click    ${WorkFLow_History}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Workflow History tab

    ${tableData}=    Get Elements    //td[not(ul)]
    @{actualText}=    Create List

    FOR    ${data}    IN    @{tableData}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${data}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Locator '${data}' is not visible. Cannot capture text.

        ${text}=    Get Text    ${data}
        ${trimValue}=    Strip String    ${text}
        Append To List    ${actualText}    ${trimValue}
    END

    ${length}=    Get Length    ${expectedList}

    FOR    ${index}    IN RANGE    0    ${length}
        ${expectedTextValue}=    Set Variable    ${expectedList[${index}]}
        ${actualTextValue}=      Set Variable    ${actualText[${index}]}
        IF    ${index} == 0
            Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}
        ELSE
            Run Keyword And Continue On Failure    Should Be Equal    ${actualTextValue}    ${expectedTextValue}
        END
    END

    ${rejectionReasons}=    Get Elements    //tbody[@test-id='assets-workflow-history']//tr[1]//td//li
    @{actualReasons}=       Create List

    FOR    ${reason}    IN    @{rejectionReasons}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${reason}    attached    timeout=${element_timeout}
        Should Be True    ${visible}    msg=reason is not visible. Cannot capture text.

        ${reasonText}=    Get Text    ${reason}
        ${trimText}=      Strip String    ${reasonText}
        Append To List    ${actualReasons}    ${trimText}
    END

    Log    Actual Workflow History Text -> @{actualText}
    Log    Actual Rejection Reasons -> @{actualReasons}


# Reactive the Rejected Submission
#     [Documentation]    Activates a submission that was previously rejected.
#     ...    It handles clicking the 'Reactive' button and any confirmation dialogs, waiting for the submission to leave the rejected state.
#     Sleep    3s
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${element_timeout}
#     ${rejectStatus}    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${element_timeout}
#     IF    ${status} == True or ${rejectStatus} == True
#         Log    'Processing Stage is visible'
#         Wait For Processing Stage    ""
#     END
#     Click    ${Reactive}
#     # Wait For Elements State    ${ReactivatePopup}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReactivatePopup    ${ReactivatePopup}    visible
#     ${acceptButton}    Run Keyword and Return Status    Wait For Elements State    ${AcceptButtonInReactive}    visible    timeout=${element_timeout}
#     IF    ${acceptButton}
#         Click    ${AcceptButtonInReactive}
#     ELSE
#         Click    ${Reactive}
#         Click    ${AcceptButtonInReactive}
#     END
#     Click    ${Side_Bar_Risk360_Button}
#     Switch to Documents
#     Sleep    3s
#     ${reactiveButtonStatus}    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
#     IF    ${reactiveButtonStatus}
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#         Click    ${Reactive}
#         Click    ${AcceptButtonInReactive}
#         # Wait For Elements State    ${Reactive}    detached    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    detached
#     ELSE
#        Log    Reactive button is hidden
#     END
#     Click Answers Tab
#     # Wait For Elements State    ${InDraftTag}    visible    timeout=300s
#     ${status1}    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    visible    timeout=${element_timeout}
#     IF    ${status1}
#         # Wait For Elements State    ${processingStage1}    hidden    timeout=${upload_procesing_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    processingStage1    ${processingStage1}    hidden    The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.    timeout=${upload_procesing_timeout}
#     ELSE
#         ${status2}        Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible    timeout=${element_timeout}
#         IF    ${status2}
#             # Wait For Elements State    ${processingStage2}    hidden    timeout=${upload_procesing_timeout}
#             Run Keyword And Continue On Failure    Wait For Element With Message    processingStage2    ${processingStage2}    hidden    The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.    timeout=${upload_procesing_timeout}
#         END
#     END
#     Wait For Processing Stage
#     Switch to Documents

Reactive the Rejected Submission
    [Documentation]    Activates a submission that was previously rejected.
    ...    Handles clicking the 'Reactive' button, confirmation dialogs, and waits for the submission to leave the rejected state.

    Sleep    3s

    ${status}=        Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${display_timeout}
    ${rejectStatus}=  Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}             visible    timeout=${display_timeout}

    IF    ${status} or ${rejectStatus}
        Log    Processing Stage is visible
        Wait For Processing Stage    ""
    END

    ${clicked}=    Run Keyword And Return Status    Click    ${Reactive}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Reactive button could not be clicked

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ReactivatePopup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Reactivate popup is not visible

    ${accept_visible}=    Run Keyword And Return Status    Wait For Elements State    ${AcceptButtonInReactive}    visible    timeout=${display_timeout}

    IF    ${accept_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Accept button in Reactive could not be clicked
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${Reactive}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Reactive button could not be clicked

        ${clicked}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Accept button in Reactive could not be clicked
    END

    ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Risk360 sidebar button

    Switch to Documents
    Sleep    3s

    ${reactiveButtonStatus}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${display_timeout}

    IF    ${reactiveButtonStatus}
        Switch to Documents
        ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Risk360 sidebar button

        ${clicked}=    Run Keyword And Return Status    Click    ${Reactive}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Reactive button could not be clicked

        ${clicked}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Accept button in Reactive could not be clicked

        ${detached}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    detached    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${detached}    msg=Reactive element did not detach as expected
    ELSE
        Log    Reactive button is hidden
    END

    Click Answers Tab

    ${status1}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    visible    timeout=${display_timeout}

    IF    ${status1}
        ${hidden1}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage1}    hidden    timeout=${upload_procesing_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${hidden1}    msg=The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.
    ELSE
        ${status2}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible    timeout=${element_timeout}
        IF    ${status2}
            ${hidden2}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${upload_procesing_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${hidden2}    msg=The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.
        END
    END

    Wait For Processing Stage
    Switch to Documents


# Create new submission with SOV and Loss run
#     [Documentation]    Creates a new submission by uploading multiple files, specifically an SOV and a Loss Run.
#     ...
#     ...    *Arguments:*
#     ...    - `${FileName}`: A list of file names to upload from the `uploads` directory.
#     ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
#     ...
#     ...    *Returns:*
#     ...    - The ID of the newly created submission.
#     [Arguments]    ${FileName}    @{submission_column_names}
#         Select Date Filter option    Today
#         Click All submissions option
#         Rearrange Submission Page Columns    @{submission_column_names}
#         Log Step    'Creating New Submission!'
#         # Wait For Elements State    ${NewButton}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    NewButton    ${NewButton}    visible
#         Click    ${NewButton}
#         Sleep    3s
#         ${status}    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible    'SelectPage should be visible.'
#         IF    ${status}  
#         Select Options By    ${SelectPage}    text    100
#         END
#         Sleep    2s
#         # ${existingSubmissionCount1}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount1}
#         # Wait For Elements State    ${CreateSubmissionTab}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
#         Click    ${UploadSupportingDocuments}
#         # Wait For Elements State    ${BrowseFile}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
#         FOR    ${file}    IN    @{FileName}
#             ${AbsolutePath}=    Normalize Path    ${path}${file}
#             Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         END
#         Sleep    2s
#         Scroll To Element    ${CreateSubmissionButton}
#         # Wait For Elements State    ${CreateSubmissionButton}    enabled
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    enabled
#         Click    ${CreateSubmissionButton}
#         Sleep    5s
#         # Wait For Elements State    ${Processing}    visible    timeout=180s
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
#         #  Click My submissions option
#         # Sleep    2s
#         # Click All submissions option
#         # Wait For Elements State    ${ProcessingStatus}    visible
#         #  ${existingSubmissionCount2}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount2}
#         # IF    ${existingSubmissionCount2} == ${existingSubmissionCount1}
#         #    ${index}    Evaluate    ${existingSubmissionCount2} + 1
#         #    ${locator}    Catenate    SEPARATOR=    ${ExistingProcessingStatus}    ${index}    ]  
#         #     Wait For Elements State    ${locator}    visible
#         # END
#         Sleep    15s
#         # Wait For Elements State    ${ProcessingStatus}    visible    timeout=120s    
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible
#         ${retrive_submission_id}    Get Text    ${Locator_SubmissionId}
#         ${get_submission_id}    Strip String    ${retrive_submission_id}
#         # Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
#         #  ${Processing_status}    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
#         # IF    '${Processing_status}' == 'False'
#         #    Log    The submission is still in processing after ${upload_procesing_timeout} seconds
#         #    Fail   The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test.
#         # END
#         Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    detached    The submission is still processing even after timeout=${upload_procesing_timeout} seconds. Aborting test.    timeout=${upload_procesing_timeout}
#         # Wait For Elements State    ${CloseSubmissionPreview}    visible    timeout=${element_timeout}
#         # Click    ${CloseSubmissionPreview}
#         Log Step    'New Submission ID -> ${get_submission_id}'
#         RETURN    ${get_submission_id}

Create new submission with SOV and Loss run
    [Documentation]    Creates a new submission by uploading multiple files, specifically an SOV and a Loss Run.
    ...
    ...    *Arguments:*
    ...    - `${FileName}`: A list of file names to upload from the `uploads` directory.
    ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
    ...
    ...    *Returns:*
    ...    - The ID of the newly created submission.
    [Arguments]    ${FileName}    @{submission_column_names}

    Select Date Filter option    Today
    Click All submissions option
    Rearrange Submission Page Columns    @{submission_column_names}
    Log Step    'Creating New Submission!'

    ${new_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewButton}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${new_visible}    msg=Create New Submission: 'New' button is not visible on the submissions page.
    ${new_clicked}=    Run Keyword And Return Status    Click    ${NewButton}
    Run Keyword And Continue On Failure    Should Be True    ${new_clicked}    msg=Create New Submission: Failed to click the 'New' button.

    ${select_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectPage}    visible    timeout=${display_timeout}
    IF    ${select_visible}
        ${dropdown_selected}=    Run Keyword And Return Status    Select Options By    ${SelectPage}    text    100
        Run Keyword And Continue On Failure    Should Be True    ${dropdown_selected}    msg=Create New Submission: Failed to select '100' in SelectPage dropdown.
    END

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionTab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Create New Submission: Create Submission tab not visible after clicking 'New'.
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${UploadSupportingDocuments}    visible    ${display_timeout}
    IF    "${Status}" == "True"
        ${clicked_upload}=    Run Keyword And Return Status    Click    ${UploadSupportingDocuments}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_upload}    msg=Create New Submission: Failed to click 'Upload Supporting Documents' button.
    END
    ${browse_visible}=    Run Keyword And Return Status    Wait For Elements State    ${BrowseFile}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${browse_visible}    msg=Create New Submission: Browse file option not visible.

    FOR    ${file}    IN    @{FileName}
        ${AbsolutePath}=    Normalize Path    ${path}${file}
        ${upload_status}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Run Keyword And Continue On Failure    Should Be True    ${upload_status}    msg=Create New Submission: Failed to upload file '${file}'.
    END

    ${create_enabled}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionButton}    enabled    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${create_enabled}    msg=Create New Submission: Create Submission button is not enabled.
    ${create_clicked}=    Run Keyword And Return Status    Click    ${CreateSubmissionButton}
    Run Keyword And Continue On Failure    Should Be True    ${create_clicked}    msg=Create New Submission: Failed to click 'Create Submission' button.

    # ${processing_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Processing}    visible    timeout=120s
    # Run Keyword And Continue On Failure    Should Be True    ${processing_visible}    msg=Create New Submission: Submission did not enter processing state.

    # ${processing_status_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    visible    timeout=120s
    # Run Keyword And Continue On Failure    Should Be True    ${processing_status_visible}    msg=Create New Submission: Processing status element not visible.

    # ${retrieve_submission_id}=    Get Text    ${Locator_SubmissionId}
    # ${get_submission_id}=    Strip String    ${retrieve_submission_id}

    # ${processing_detached}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${processing_detached}    msg=Create New Submission: The submission is still processing after timeout=${upload_procesing_timeout} seconds.

    # Log Step    'New Submission ID -> ${get_submission_id}'
    # RETURN    ${get_submission_id}
    Sleep    15s
    Reload
    Rearrange Submission Page Columns    @{submission_column_names}

    ${processing_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Processing}    visible
    Run Keyword And Continue On Failure    Should Be True    ${processing_visible}    msg=Create New Submission: 'Processing' indicator not visible after submission.
    Set Viewport Size    2560    1440 
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Locator_SubmissionId}    attached    timeout=${element_timeout}
    Should Be True    ${status}    'Create New Submission: Submission ID not visible.'
    ${retrieved_submission_id}=    Get Text    ${Locator_SubmissionId}
    ${get_submission_id}=    Strip String    ${retrieved_submission_id}
    Set Viewport Size    1280    720
    # FOR    ${index}    IN RANGE    6
    #     Log    Refresh number: ${index + 1}
    #     Reload
    #     Sleep    1 minutes
    # END
    # ${status}=    Run Keyword And Return Status    Wait For Elements State   ${ProcessingStatus}    detached    timeout=${upload_procesing_timeout}
    # IF    ${status}
    #     Log Step    'New Submission ID -> ${get_submission_id}'
    #     RETURN    ${get_submission_id}
    # ELSE
    #     Log Step    'Submission still processing after ${upload_procesing_timeout} seconds. Returning False.'
    #     RETURN    False
    # END
    ${timeout_stripped}=    Replace String    ${upload_procesing_timeout}    s    ${EMPTY}
    ${end_time}=    Evaluate    time.time() + ${timeout_stripped}    modules=time
    ${status}=    Set Variable    False

    WHILE    time.time() < ${end_time}
        Reload
        Rearrange Submission Page Columns    @{submission_column_names}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    detached    timeout=10s
        IF    ${status}
            Log Step    New Submission ID -> ${get_submission_id}
            ${locator_company_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${get_submission_id}    ${BalanceCompanyName})[1]
            ${company_visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${display_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${company_visible}    msg=Select Submission: Company name for submission ID '${get_submission_id}' not visible.
            ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    attached    timeout=${element_timeout}
            Should Be True    ${visible}    msg=Company name locator '${locator_company_name}' is not visible. Cannot retrieve product/company name.
            ${product}=    Get Text    ${locator_company_name}
            Log    Extracted Company Name text: ${product}

            IF    ${{"${product.strip()}" == "Submitted by MSIG TEST"}}
                Fail    Submission unexpectedly displays as 'Submitted by MSIG TEST' for ID: ${get_submission_id}. Possible it could be a extraction issue.
                RETURN    False
            END
            RETURN    ${get_submission_id}
        ELSE
            Log Step    Processing still ongoing... reloading the page and retrying in 2 minute.
            Sleep    120s
        END
    END

    Log Step    Submission still processing even after ${upload_procesing_timeout} seconds. Returning False.
    RETURN    False


# Open uploaded SOV File
#     [Documentation]    Navigates to the 'Documents' section and opens the uploaded SOV file for viewing.
#      Switch to Documents
#      Run Keyword And Continue On Failure    Wait For Element With Message    Files    ${Files}    visible    Wait for the files to appear and verify that the files are displayed.
#      Get Element States    ${SOV}    validate    value & visible    'SOV should be visible.'
#      Click    ${SOV}
#      Run Keyword And Continue On Failure    Wait For Element With Message    FileOption    ${FileOption}    visible    Wait for the file option and verify that it is displayed
#      Click    ${FileOption}
Open uploaded SOV File
    [Documentation]    Navigates to the 'Documents' section and opens the uploaded SOV file for viewing.

    Switch to Documents

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Files}    visible    timeout=${element_timeout}
    Should Be True    ${status}    Files are not visible in the Documents section.

    ${status}=    Run Keyword And Return Status    Get Element States    ${SOV}    validate    value & visible
    Should Be True    ${status}    SOV file is not visible in the Documents section.

    ${status}=    Run Keyword And Return Status    Click    ${SOV}
    Should Be True    ${status}    Failed to click on the SOV file in the Documents section.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FileOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    File options are not visible for the selected SOV file.

    ${status}=    Run Keyword And Return Status    Click    ${FileOption}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on the FileOption for the SOV file.


# Verify datas are matching for the uploaded SOV file
#     [Documentation]    Compares the data visible in the SOV file viewer with the contents of the original Excel file.
#     ...
#     ...    *Arguments:*
#     ...    - `${file}`: The name of the Excel file in the `uploads` directory to compare against.
#     [Arguments]    ${file}
#     ${AbsolutePath}=    Normalize Path    ${path}${file}
#      Set Viewport Size    1920    1080
#      Wait For Elements State    xpath=//iframe[@class='spreadsheet-viewer-iframe']    visible
#      ${tableValues}    Get Elements    xpath=//iframe[@class='spreadsheet-viewer-iframe'] >>> xpath=//tr//td//div[normalize-space() and contains(@class,'value')]
#      ${actualText}    Create List
#      FOR    ${value}    IN    @{tableValues}
#          ${getText}    Get Text    ${value}
#          ${trimText}    Strip String    ${getText}
#          Append To List    ${actualText}    ${trimText}
#      END
#      Log    ${actualText}
#      Set Viewport Size    1280    720
#      Compare Excel With Ui List    ${AbsolutePath}    ${actualText}
Verify datas are matching for the uploaded SOV file
    [Documentation]    Compares the data visible in the SOV file viewer with the contents of the original Excel file.

    [Arguments]    ${file}

    ${AbsolutePath}=    Normalize Path    ${path}${file}

    Set Viewport Size    1920    1080

    ${status}=    Run Keyword And Return Status    Wait For Elements State    xpath=//iframe[@class='spreadsheet-viewer-iframe']    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Spreadsheet viewer iframe is not visible.

    ${tableValues}=    Get Elements    xpath=//iframe[@class='spreadsheet-viewer-iframe'] >>> xpath=//tr//td//div[normalize-space() and contains(@class,'value')]
    Run Keyword And Continue On Failure    Should Not Be Empty   ${tableValues}    No table values found in the spreadsheet viewer.

    ${actualText}=    Create List
    FOR    ${value}    IN    @{tableValues}
        ${present}=    Run Keyword And Return Status    Wait For Elements State    ${value}    attached    timeout=${element_timeout}
        Should Be True    ${present}    msg=Element 'value' is not present.
        ${text_status}=    Get Text    ${value}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text_status}    Failed to get text from cell: ${value}
        ${trimText}=    Strip String    ${text_status}
        Append To List    ${actualText}    ${trimText}
    END

    Log    ${actualText}

    Set Viewport Size    1280    720

    ${status}=    Run Keyword And Return Status    Compare Excel With Ui List    ${AbsolutePath}    ${actualText}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Data in the SOV viewer does not match the Excel file: ${file}.

     
# Verify Loss run file is pending for stage 2
#     [Documentation]    Verifies that the uploaded Loss Run file is marked as 'Pending Stage 2'.
#     Switch To Documents
#     Scroll To Element    ${LossRunFile}
#     Get Element States    ${LossRunFile}    validate    enabled    'LossRunFile should be enabled.'
#     Get Element States    ${PendingStage2}    validate    value & visible    'PendingStage2 should be visible.'

Verify Loss run file is pending for stage 2
    [Documentation]    Verifies that the uploaded Loss Run file is marked as 'Pending Stage 2'.

    Switch To Documents
    
    ${scroll_status}=    Run Keyword And Return Status    Scroll To Element    ${LossRunFile}
    Run Keyword And Continue On Failure    Should Be True    ${scroll_status}    msg=Verify Loss Run: Unable to scroll to Loss Run file element in document tab to "Verify Loss run file is pending for stage 2".

    ${lossrun_enabled}=    Run Keyword And Return Status    Get Element States    ${LossRunFile}    validate    enabled
    Run Keyword And Continue On Failure    Should Be True    ${lossrun_enabled}    msg=Verify Loss Run: Loss Run file element is not enabled or not found to "Verify Loss run file is pending for stage 2.

    ${pending_visible}=    Run Keyword And Return Status    Get Element States    ${PendingStage2}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${pending_visible}    msg=Verify Loss Run: 'Pending Stage 2' status is not visible for Loss Run file to 'Verify Loss run file is pending for stage 2'.

# Verify Properties datas matching for applied columns given in the uploaded SOV file
#     [Documentation]    Verifies that the data in the 'Properties' table (from the SOV) matches expected values for a given set of selected columns.
#     ...    It includes complex formulas in the documentation to explain how totals are calculated, which is critical for maintaining tests.
#     ...
#     ...    *Arguments:*
#     ...    - `${options}`: A list of column names to select from the column dropdown.
#     ...    - `${expectedValues}`: A list of expected numerical values from the visible table data.
#     [Arguments]    ${options}    ${expectedValues}
#     Click    ${SOV_Properties}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PropertiesTable    ${PropertiesTable}    visible    Wait for the propertiesTable element to appear and confirm that the SOV files table is displayed  
#     Click    ${Column_Dropdown}
#     FOR    ${option}    IN    @{options}
#         ${option}    Catenate    SEPARATOR=    ${SelectOption1}    ${option}    ${SelectOption2}
#         Scroll To Element    ${option}
#         Check Checkbox    ${option}
#     END
#     Click    ${Column_Dropdown}
#     ${rows}    Get Elements    ${Properties_Row}
#     ${length}    Get Length    ${rows}
#     ${index}    Set Variable    0
#     ${actualListOfValues}    Create List   
#     FOR    ${i}    IN RANGE     ${index}      ${length}
#         ${tableData}    Catenate    SEPARATOR=    ${Properties_Data1}    ${i+1}    ${Properties_Data2}
#         ${listOfData}    Get Elements    ${tableData} 
#         FOR    ${data}    IN    @{listOfData}
#             ${text}    Get Text    ${data}
#             ${trimValue}    Strip String    ${text}
#             IF    "${trimValue}" != ""
#                 ${has_dollar}=    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Contain    ${trimValue}    $
#                 Run Keyword And Continue On Failure    Should Be True    ${has_dollar}
#                 ${actualtrimValue}=    Replace String    ${trimValue}    $    ${EMPTY}
#                 ${actualtrimValue}=    Replace String    ${actualtrimValue}    ,    ${EMPTY}
#                 ${clean}    Strip String    ${actualtrimValue}
#                 ${value}    Convert To Number    ${clean}
#                 Append To List    ${actualListOfValues}    ${value}
#             END
#         END
#     END
#     Log    ${actualListOfValues}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedValues}    ${actualListOfValues}
#     Click    ${Column_Dropdown}
#     # Wait For Elements State    ${ClearAll}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearAll    ${ClearAll}    visible
#     Click    ${ClearAll}
Verify Properties datas matching for applied columns given in the uploaded SOV file
    [Documentation]    Verifies that the data in the 'Properties' table (from the SOV) matches expected values for a given set of selected columns.
    ...    It includes complex formulas in the documentation to explain how totals are calculated, which is critical for maintaining tests.
    [Arguments]    ${options}    ${expectedValues}

    ${status}=    Run Keyword And Return Status    Click    ${SOV_Properties}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on SOV Properties.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PropertiesTable}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Properties Table is not visible.

    ${status}=    Run Keyword And Return Status    Click    ${Column_Dropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Column Dropdown.

    FOR    ${option}    IN    @{options}
        ${option_locator}=    Catenate    SEPARATOR=    ${SelectOption1}    ${option}    ${SelectOption2}
        Clear Text    ${DocPropertiesColumnSearch}
        Type Text    ${DocPropertiesColumnSearch}    ${option}
        # ${status}=    Run Keyword And Return Status    Scroll To Element    ${option_locator}
        # Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to column option '${options}'.
        ${status}=    Run Keyword And Return Status    Uncheck Checkbox    ${option_locator}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to un check column option '${options}'.
    
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${option_locator}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to check column option '${options}'.
    END

    ${status}=    Run Keyword And Return Status    Click    ${Column_Dropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Column Dropdown to close it.

    ${rows}=    Get Elements    ${Properties_Row}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${rows}    Failed to get rows from Properties Table.

    ${length}=    Get Length    ${rows}
    ${index}=    Set Variable    0
    ${actualListOfValues}=    Create List

    FOR    ${i}    IN RANGE    ${index}    ${length}
        ${tableData}=    Catenate    SEPARATOR=    ${Properties_Data1}    ${i+1}    ${Properties_Data2}
        
        ${listOfData}=    Get Elements    ${tableData}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${listOfData}    Failed to get data cells for row ${i+1}.
        
        FOR    ${data}    IN    @{listOfData}
        ${present}=    Run Keyword And Return Status    Wait For Elements State    ${data}    attached    timeout=${element_timeout}
        Should Be True    ${present}    msg=Element data is not present.
            ${text}=    Get Text    ${data}
            Run Keyword And Continue On Failure    Should Not Be Empty     ${text}    Failed to get text from cell in row ${i+1}.
        
            ${trimValue}=    Strip String    ${text}
            # Run Keyword And Continue On Failure    Should Be True    ${trimValue}    Failed to strip string for cell text in row ${i+1}.

            IF    "${trimValue}" != ""
                ${has_dollar}=    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Contain    ${trimValue}    $
                Run Keyword And Continue On Failure    Should Be True    ${has_dollar}    The value '${trimValue}' in row ${i+1} does not contain '$'.

                ${actualtrimValue}=    Replace String    ${trimValue}    $    ${EMPTY}
                # Run Keyword And Continue On Failure    Should Be True    ${actualtrimValue}    Failed to remove '$' from '${trimValue}'.

                ${actualtrimValue}=    Replace String    ${actualtrimValue}    ,    ${EMPTY}
                # Run Keyword And Continue On Failure    Should Be True    ${actualtrimValue}    Failed to remove ',' from '${trimValue}'.

                ${clean}=    Strip String    ${actualtrimValue}
                # Run Keyword And Continue On Failure    Should Be True    ${clean}    Failed to strip string after removing symbols in row ${i+1}.

                ${value}=    Convert To Number    ${clean}
                # Run Keyword And Continue On Failure    Should Be True    ${value}    Failed to convert '${clean}' to number in row ${i+1}.

                Append To List    ${actualListOfValues}    ${value}
            END
        END
    END

    Log    ${actualListOfValues}

    ${status}=    Run Keyword And Return Status    Lists Should Be Equal    ${expectedValues}    ${actualListOfValues}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Expected values and actual values from SOV Properties Table do not match.

    ${status}=    Run Keyword And Return Status    Click    ${Column_Dropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Column Dropdown to reset.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ClearAll}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Clear All button is not visible.

    ${status}=    Run Keyword And Return Status    Click    ${ClearAll}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Clear All button.


# Verify Properties datas for the given dropdown options
#     [Documentation]    A data-driven keyword that iterates through multiple sets of dropdown options and expected values to verify the 'Properties' table.
#     ...    It calls `Verify Properties datas matching for applied columns given in the uploaded SOV file` repeatedly.
#     ...
#     ...    *Arguments:*
#     ...    - `${length}`: The number of option/value sets to test. This is used to loop through a dictionary defined in a variable file.
#     [Arguments]    ${length}
#     FOR    ${index}    IN RANGE    0    ${length}
#         ${dropdownOptions}    Get From List    ${TC_E2E_003['dropdownOptions']}    ${index}
#         ${values}    Get From List    ${TC_E2E_003['values']}    ${index}
#         Verify Properties datas matching for applied columns given in the uploaded SOV file    ${TC_E2E_003['${dropdownOptions}']}      ${TC_E2E_003['${values}']}
#    END
Verify Properties datas for the given dropdown options
    [Documentation]    A data-driven keyword that iterates through multiple sets of dropdown options and expected values to verify the 'Properties' table.
    ...    It calls `Verify Properties datas matching for applied columns given in the uploaded SOV file` repeatedly.
    [Arguments]    ${length}

    FOR    ${index}    IN RANGE    0    ${length}
        ${dropdownOptions}=    Get From List    ${TC_E2E_003['dropdownOptions']}    ${index}
        # ${dropdownOptions}=    Set Variable    ${dropdownOptions}

        ${values}=    Get From List    ${TC_E2E_003['values']}    ${index}
        # ${values}=    Set Variable    ${values}

        Verify Properties datas matching for applied columns given in the uploaded SOV file    ${TC_E2E_003['${dropdownOptions}']}      ${TC_E2E_003['${values}']}
    END

# Verify Sanction Screening Flagged is visible in the submission
#     [Documentation]    Verifies that the 'Sanction Screening Flagged' indicator is visible on the submission.
#     Get Element States    ${SanctionScreeningFlagged}    validate    value & visible    'SanctionScreeningFlagged should be visible.'
Verify Sanction Screening Flagged Is Visible In The Submission
    [Documentation]    Verifies that the 'Sanction Screening Flagged' indicator is visible on the submission.

    ${visible}=    Run Keyword And Return Status    Get Element States    ${SanctionScreeningFlagged}    validate    value & visible
    Should Be True    ${visible}    msg=Sanction Screening Flagged indicator is not visible

Verify Task Number In The Submission
    [Documentation]    Verifies that the task number displayed on the submission matches the expected number.
    ...
    ...    *Arguments:*
    ...    - `${expected_taskNumber}`: The expected task number.

    [Arguments]    ${expected_taskNumber}

    # Run Keyword And Continue On Failure    Wait For Element With Message    TaskNumber    ${TaskNumber}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskNumber}    visible    timeout=${element_timeout}
    Should Be True    ${status}    'Task Number is not visiblein side bar menu Task is not generated'

    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${TaskNumber}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=TaskNumber element is not attached to the DOM to get a text value.

    ${get_taskNumber}=    Get Text    ${TaskNumber}

    ${actual_taskNumber}=    Strip String    ${get_taskNumber}

    Run Keyword And Continue On Failure    Should Be Equal    ${actual_taskNumber}    ${expected_taskNumber}    msg=Task number does not match the expected value

# Verify and click the Task In Submission
#     [Documentation]    Verifies the task link is visible within the submission and then clicks it to open the task details.
#     Get Element States    ${TaskInSubmission}    validate    value & visible    'TaskInSubmission should be visible.'
#     Click    ${TaskInSubmission}
Verify And Click The Task In Submission
    [Documentation]    Verifies the task link is visible within the submission and then clicks it to open the task details.

    ${visible}=    Run Keyword And Return Status    Get Element States    ${TaskInSubmission}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Task in submission is not visible

    ${clicked}=    Run Keyword And Return Status    Click    ${TaskInSubmission}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click the task in submission

# Verify the auto generated task details
#     [Documentation]    Verifies the details of the automatically generated Sanction Screening task.
#     ...
#     ...    *Arguments:*
#     ...    - `${expected_taskDetails}`: A list of expected string values for the task details. The current date is appended for comparison.
#     [Arguments]    ${expected_taskDetails}
#     ${CreatedDate}    Get Formatted Current Date
#     Append To List    ${expected_taskDetails}    ${CreatedDate}
#     ${actual_taskDetails}    Create List
#     FOR    ${taskDetail}    IN    @{AutoGeneratedTaskDetails}
#         ${text}    Get Text    ${AutoGeneratedTaskDetails['${taskDetail}']}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actual_taskDetails}    ${trimText}
#     END
#     ${length}    Get Length    ${expected_taskDetails}
#     FOR    ${index}    IN RANGE    0    ${length}
#         ${expectedTextValue}=     Set Variable    ${expected_taskDetails[${index}]}
#         ${actualTextValue}=    Set Variable    ${actual_taskDetails[${index}]}
#         IF    ${index} == ${length-1}
#             Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    
#         ELSE
#             Run Keyword And Continue On Failure    Should Be Equal    ${expectedTextValue}    ${actualTextValue}
#         END
#     END
Verify The Auto Generated Task Details
    [Documentation]    Verifies the details of the automatically generated Sanction Screening task.
    ...
    ...    *Arguments:*
    ...    - `${expected_taskDetails}`: A list of expected string values for the task details. The current date is appended for comparison.

    [Arguments]    ${expected_taskDetails}
    Switch To Summary
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}

    ${CreatedDate}=    Get Formatted Current Date
    Append To List    ${expected_taskDetails}    ${CreatedDate}

    @{actual_taskDetails}=    Create List

    FOR    ${taskDetail}    IN    @{AutoGeneratedTaskDetails}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${AutoGeneratedTaskDetails['${taskDetail}']}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Task detail '${taskDetail}' locator is not present to get a text value.

        ${text}=    Get Text    ${AutoGeneratedTaskDetails['${taskDetail}']}
        ${trimText}=    Strip String    ${text}
        Append To List    @{actual_taskDetails}    ${trimText}
    END

    ${length}=    Get Length    ${expected_taskDetails}

    FOR    ${index}    IN RANGE    0    ${length}
        ${expectedTextValue}=    Set Variable    ${expected_taskDetails[${index}]}
        ${actualTextValue}=      Set Variable    ${actual_taskDetails[${index}]}

        IF    ${index} == ${length} - 1
            Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    msg=Last task detail (date) does not match
        ELSE
            Run Keyword And Continue On Failure    Should Be Equal    ${actualTextValue}    ${expectedTextValue}    msg=Task detail at index ${index} does not match
        END
    END


# Verify the auto generated task details sanction screening
#     [Documentation]    Verifies the details of the automatically generated Sanction Screening task.
#     ...
#     ...    *Arguments:*
#     ...    - `${expected_taskDetails}`: A list of expected string values for the task details. The current date is appended for comparison.
#     [Arguments]    ${expected_taskDetails}
#     ${CreatedDate}    Get Formatted Current Date
#     Append To List    ${expected_taskDetails}    ${CreatedDate}
#     ${actual_taskDetails}    Create List
#     FOR    ${taskDetail}    IN    @{SanctionScreeningTaskDetails}
#         ${text}    Get Text    ${SanctionScreeningTaskDetails['${taskDetail}']}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actual_taskDetails}    ${trimText}
#     END
#     ${length}    Get Length    ${expected_taskDetails}
#     FOR    ${index}    IN RANGE    0    ${length}
#         ${expectedTextValue}=     Set Variable    ${expected_taskDetails[${index}]}
#         ${actualTextValue}=    Set Variable    ${actual_taskDetails[${index}]}
#         IF    ${index} == ${length-1}
#             Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    
#         ELSE
#             Run Keyword And Continue On Failure    Should Be Equal    ${expectedTextValue}    ${actualTextValue}
#         END
#     END
Verify The Auto Generated Task Details Sanction Screening
    [Documentation]    Verifies the details of the automatically generated Sanction Screening task.
    ...
    ...    *Arguments:*
    ...    - `${expected_taskDetails}`: A list of expected string values for the task details. The current date is appended for comparison.

    [Arguments]    ${expected_taskDetails}

    ${CreatedDate}=    Get Formatted Current Date
    Append To List    ${expected_taskDetails}    ${CreatedDate}

    @{actual_taskDetails}=    Create List

    FOR    ${taskDetail}    IN    @{SanctionScreeningTaskDetails}
        ${status}    Run Keyword And Return Status    Wait For Elements State    ${SanctionScreeningTaskDetails['${taskDetail}']}    visible    timeout=${element_timeout}
        Should Be True    ${status}    msg='Auto generated task is not created in sanction screening'
        ${text}=    Get Text    ${SanctionScreeningTaskDetails['${taskDetail}']}
        ${trimText}=    Strip String    ${text}
        Append To List    @{actual_taskDetails}    ${trimText}
    END

    ${length}=    Get Length    ${expected_taskDetails}

    FOR    ${index}    IN RANGE    0    ${length}
        ${expectedTextValue}=    Set Variable    ${expected_taskDetails[${index}]}
        ${actualTextValue}=      Set Variable    ${actual_taskDetails[${index}]}

        IF    ${index} == ${length} - 1
            Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    msg=Last task detail (date) does not match
        ELSE
            Run Keyword And Continue On Failure    Should Be Equal    ${actualTextValue}    ${expectedTextValue}    msg=Task detail at index ${index} does not match
        END
    END

   
# Complete Task with the given reason
#     [Documentation]    Completes the open task with a specified reason.
#     ...
#     ...    *Arguments:*
#     ...    - `${reason}`: The reason for completing the task (e.g., 'False Positive'). This must match one of the checkbox labels in the completion dialog.
#     [Arguments]    ${reason}
#     Run Keyword And Continue On Failure    Wait For Element With Message    CompleteTaskButton    ${CompleteTaskButton}    visible    Wait for the completeTaskButton and verify that the Complete Task button is visible.
#     Click    ${CompleteTaskButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    visible    Wait for the taskCompleteDialog and verify that the False Positive, No Hit, and True Hit indicators are visible.
#     ${reason}    Catenate    SEPARATOR=    ${SanctionScreeningSelectReason}    ${reason}']
#     Check Checkbox    ${reason}
#     Get Element States    ${reason}    validate    value & enabled    'Reason should be enabled.'
#     Click    ${CompleteTaskButtonInDialog}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    detached    Wait for the taskCompleteDialog to be detached and verify that the task is completed.
Complete Task with the given reason
    [Documentation]    Completes the open task with a specified reason.
    ...
    ...    *Arguments:*
    ...    - `${reason}`: The reason for completing the task (e.g., 'False Positive'). Must match one of the checkbox labels in the completion dialog.

    [Arguments]    ${reason}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CompleteTaskButton}    visible
    Should Be True    ${status}    Complete Task button is not visible — possible loading issue or the auto-generated task was not created for Sanction Screening.

    ${clicked}=    Run Keyword And Return Status    Click    ${CompleteTaskButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click CompleteTaskButton

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Wait for the taskCompleteDialog and verify that the completion indicators are visible

    ${reason_locator}=    Catenate    SEPARATOR=    ${SanctionScreeningSelectReason}    ${reason}']
    Run Keyword And Continue On Failure    Check Checkbox    ${reason_locator}

    Run Keyword And Continue On Failure    Get Element States    ${reason_locator}    validate    value & enabled    msg=Reason should be enabled

    ${clicked}=    Run Keyword And Return Status    Click    ${CompleteTaskButtonInDialog}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click CompleteTaskButtonInDialog

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    detached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Wait for the taskCompleteDialog to be detached and verify that the task is completed

# Verify the task is completed and sanction label is appears as per the reason
#     [Documentation]    Verifies that the task shows as completed and that the correct sanction label ('False Positive', 'Sanction Screening Flagged', or 'Sanction Screening Clear') is displayed based on the completion reason.
#     ...
#     ...    *Arguments:*
#     ...    - `${reason}`: The reason the task was completed with, used to determine which label should be visible.
#     [Arguments]    ${reason}
#     Scroll To Element    ${TaskCompletedMessage}
#     # Wait For Elements State    ${TaskCompletedMessage}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompletedMessage    ${TaskCompletedMessage}    visible
#     ${CompletedReason}    Catenate    SEPARATOR=    ${TaskCompletedReason}    ${reason}']
#     Get Element States    ${CompletedReason}    validate    value & visible    'CompletedReason should be visible.'
#     IF    '${reason}' == 'False Positive'
#         Get Element States    ${FalsePositiveLabel}    validate    value & visible    'FalsePositiveLabel should be visible.'
#     ELSE IF    '${reason}' == 'Confirmed – TRUE HIT'
#         Get Element States    ${SanctionScreeningFlagged}    validate    value & visible    'SanctionScreeningFlagged should be visible.'
#     ELSE
#         Get Element States    ${SanctionScreeningClear}    validate    value & visible    'SanctionScreeningClear should be visible.'
#     END

Verify the task is completed and sanction label is appears as per the reason
    [Documentation]    Verifies that the task shows as completed and that the correct sanction label
    ...    ('False Positive', 'Sanction Screening Flagged', or 'Sanction Screening Clear') is displayed based on the completion reason.
    ...
    ...    *Arguments:*
    ...    - `${reason}`: The reason the task was completed with, used to determine which label should be visible.

    [Arguments]    ${reason}

    # Scroll To Element    ${TaskCompletedMessage}
    ${visible}=    Run Keyword And Return Status    Scroll To Element    ${TaskCompletedMessage}
    Should Be True    ${visible}    msg=Task completed message is not visible to scroll

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompletedMessage}    visible
    Should Be True    ${visible}    msg=Task completed message is not visible

    ${CompletedReason}=    Catenate    SEPARATOR=    ${TaskCompletedReason}    ${reason}']

    ${visible}=    Run Keyword And Return Status    Get Element States    ${CompletedReason}    validate    value & visible
    Run Keyword And Continue On Failure     Should Be True    ${visible}    msg=Completed reason '${reason}' is not visible

    IF    '${reason}' == 'False Positive'
        ${visible}=    Run Keyword And Return Status    Get Element States    ${FalsePositiveLabel}    validate    value & visible
        Run Keyword And Continue On Failure     Should Be True    ${visible}    msg=False Positive label is not visible
    ELSE IF    '${reason}' == 'Confirmed – TRUE HIT'
        ${visible}=    Run Keyword And Return Status    Get Element States    ${SanctionScreeningFlagged}    validate    value & visible
        Run Keyword And Continue On Failure     Should Be True    ${visible}    msg=Sanction Screening Flagged label is not visible
    ELSE
        ${visible}=    Run Keyword And Return Status    Get Element States    ${SanctionScreeningClear}    validate    value & visible
        Run Keyword And Continue On Failure     Should Be True    ${visible}    msg=Sanction Screening Clear label is not visible
    END


# Verify Sanction Screening Flagged is not visible 
#     [Documentation]    Verifies that the 'Sanction Screening Flagged' indicator is *not* visible on the submission.
#     Sleep    2s
#     ${is_hidden}    Run Keyword And Return Status  Get Element States    ${SanctionScreeningFlagged}    validate    hidden
#     Run Keyword And Continue On Failure     Run Keyword And Continue On Failure    Should Be True    ${is_hidden}    Sanction Screening Flagged should be hidden
Verify Sanction Screening Flagged Is Not Visible
    [Documentation]    Verifies that the 'Sanction Screening Flagged' indicator is *not* visible on the submission.

    Sleep    2s

    ${is_hidden}=    Run Keyword And Return Status    Get Element States    ${SanctionScreeningFlagged}    validate    hidden
    Run Keyword And Continue On Failure     Should Be True    ${is_hidden}    msg=Sanction Screening Flagged should be hidden

# Navigate To All Submissions page from submissions
#     [Documentation]    Navigates to the main 'All Submissions' page from within a submission.
#     ${visible}    Run Keyword And Return Status    Wait For Elements State    ${Home}    visible    timeout=${element_timeout}
#     IF    ${visible}
#         Click    ${Home}
#         Sleep    3s
#         Run Keyword And Continue On Failure    Wait For Element With Message    SearchSubmissionButton    ${SearchSubmissionButton}    visible    Wait for the Search Submission button to appear and Verify that the All Submissions page is displayed.
#         Click All submissions option
#     END
Navigate To All Submissions page from submissions
    [Documentation]    Navigates to the main 'All Submissions' page from within a submission.

    # Wait for Home button to be visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Home}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Home button is not visible; cannot navigate to All Submissions page.

    IF    ${visible}
        # Click Home button
        ${clickHome}=    Run Keyword And Return Status    Click    ${Home}
        Run Keyword And Continue On Failure    Should Be True    ${clickHome}    msg=Failed to click Home button.

        Sleep    3s

        # Wait for Search Submission button to appear
        ${searchBtnVisible}=    Run Keyword And Return Status    Wait For Elements State    ${SearchSubmissionButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${searchBtnVisible}    msg=Search Submission button did not appear; All Submissions page may not be displayed.

        # Click All Submissions option
        Click All submissions option
    END


# Verify Stage is updated in the submission
#     [Documentation]    Verifies that the stage of the submission is updated correctly.
#     ...    It checks for the visibility of the stage indicator and compares it with the expected stage.
#     ...
#     ...    *Arguments:*
#     ...    - `${expected_stage}`: The expected stage of the submission.
#     [Arguments]    ${expected_stage}
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
#     IF    ${status}
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#     END
#     ${stage}    Catenate    SEPARATOR=    ${StageLocator1}    ${expected_stage}    ${StageLocator2} 
#     ${status}    Run Keyword And Return Status    Get Element States    ${stage}    validate    value & visible    
#     Run Keyword And Continue On Failure    Should Be True    ${status}

Verify Stage is updated in the submission
    [Documentation]    Verifies that the stage of the submission is updated correctly.
    ...    It checks for the visibility of the stage indicator and compares it with the expected stage.
    ...
    ...    *Arguments:*
    ...    - `${expected_stage}`: The expected stage of the submission.
    [Arguments]    ${expected_stage}

    ${edit_visible}=    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
    IF    ${edit_visible}
        Switch To Documents
        ${click_risk360}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${click_risk360}    msg=Verify Stage: Failed to click 'Risk 360' button in sidebar.
    END

    ${stage_locator}=    Catenate    SEPARATOR=    ${StageLocator1}    ${expected_stage}    ${StageLocator2}
    ${stage_status}=    Run Keyword And Return Status    Get Element States    ${stage_locator}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${stage_status}    msg=Verify Stage: Expected stage '${expected_stage}' is not visible or not matching.


# Verify Submission updated in Stage 2
#     [Documentation]    Verifies that a submission has been updated after advancing to Stage 2.
#     ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.
#     Click Answers Tab
#     Switch to Documents
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${element_timeout}
#     IF    ${status}
#         Log    'Processing Stage 2 is hidden'
#     ELSE
#         Click Answers Tab
#         Click   ${Side_Bar_Risk360_Button}
#        Wait Until Element Is Hidden With Polling    ${processingStage2}
#     END
#     Switch to Documents
#     Click    ${Side_Bar_Risk360_Button}
#      ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible
#     IF    ${status}
#         Wait Until Element Is Hidden With Polling    ${processingStage2}
#         Log    'Processing Stage 2 is hidden'
#         Get Element States    ${UpdatedSubmission}    validate    value & visible    'UpdatedSubmission should be visible.'
#     ELSE
#     Sleep    2s
#         Get Element States    ${UpdatedSubmission}    validate    value & visible    'UpdatedSubmission should be visible.'
#     END

Verify Submission Updated In Stage 2
    [Documentation]    Verifies that a submission has been updated after advancing to Stage 2.
    ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.

    ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Answers Tab

    Run Keyword And Continue On Failure    Switch To Documents

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=${element_timeout}
    IF    ${status}
        Run Keyword And Continue On Failure    Log    Processing Stage 2 is hidden
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Answers Tab

        ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Side Bar Risk360 Button

        Run Keyword And Continue On Failure    Wait Until Element Is Hidden With Polling    ${processingStage2}
    END

    Run Keyword And Continue On Failure    Switch To Documents

    ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Side Bar Risk360 Button

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible
    IF    ${status}
        Run Keyword And Continue On Failure    Wait Until Element Is Hidden With Polling    ${processingStage2}
        Run Keyword And Continue On Failure    Log    Processing Stage 2 is hidden

        Run Keyword And Continue On Failure    Get Element States    ${UpdatedSubmission}    validate    value & visible    msg=UpdatedSubmission should be visible
    ELSE
        Run Keyword And Continue On Failure    Sleep    2s
        Run Keyword And Continue On Failure    Get Element States    ${UpdatedSubmission}    validate    value & visible    msg=UpdatedSubmission should be visible
    END

# Verify Submission updated in the Current Stage
#     [Documentation]    Verifies that a submission has been updated after advancing to Stage 2.
#     ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.
#     [Arguments]    ${stageNo}
#     Click Answers Tab
#     Switch to Documents
#     ${stage}    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${element_timeout}
#     IF    ${status}
#         Log    'Processing Stage ${stageNo} is hidden'
#     ELSE
#         Click Answers Tab
#         Click   ${Side_Bar_Risk360_Button}
#         # Wait For Elements State    ${stage}    hidden    timeout=${upload_procesing_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    stage    ${stage}    visible
#     END
#     Switch to Documents
#     Click    ${Side_Bar_Risk360_Button}
#      ${status1}    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}    
#     IF    ${status1}
#         Log    'Processing Stage ${stageNo} is hidden'
#         # Wait For Elements State    ${stage}    hidden    timeout=${upload_procesing_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    stage    ${stage}    visible
#     END

# Verify Submission updated in the Current Stage
#     [Documentation]    Verifies that a submission has been updated after advancing to Stage ${stageNo}.
#     ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.
#     ...
#     ...    *Arguments:*
#     ...    - `${stageNo}`: The current stage number to verify.
#     [Arguments]    ${stageNo}

#     Click Answers Tab
#     Switch To Documents
   
#     ${stage_locator}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]'

#     ${stage_hidden}=    Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    hidden    timeout=${element_timeout}
#     IF    ${stage_hidden}
#         Log    'Processing Stage ${stageNo} is hidden.'
#     ELSE
#         Click Answers Tab
#         ${click_risk360}=    Run Keyword And Return Status    Click ${Side_Bar_Risk360_Button}
#         Run Keyword And Continue On Failure    Should Be True    ${click_risk360}    msg=Verify Submission: Failed to click 'Risk 360' button.

#         Run Keyword And Continue On Failure    Wait For Element With Message    stage    ${stage_locator}    visible
#     END

#        Switch To Documents
#     ${click_risk3602}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
#     Run Keyword And Continue On Failure    Should Be True    ${click_risk3602}    msg=Verify Submission: Failed to click 'Risk 360' button second time.

#     ${stage_visible}=    Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    visible    timeout=${element_timeout}
#     IF    ${stage_visible}
#         Log    'Processing Stage ${stageNo} is visible after update.'
#         Run Keyword And Continue On Failure    Wait For Element With Message    stage    ${stage_locator}    visible
#     END

Verify Submission updated in the Current Stage
    [Documentation]    Verifies that a submission has been updated after advancing to Stage ${stageNo}.
    ...    It checks for the disappearance of processing indicators and the appearance of an 'Updated' message.
    ...
    ...    *Arguments:*
    ...    - `${stageNo}`: The current stage number to verify.

    [Arguments]    ${stageNo}

    ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Answers Tab

    Run Keyword And Continue On Failure    Switch To Documents

    ${stage_locator}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]

    ${stage_hidden}=    Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    hidden    timeout=${processing_stage_timeout}
    IF    ${stage_hidden}
        Run Keyword And Continue On Failure    Log    Processing Stage ${stageNo} is hidden
    ELSE
        ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Answers Tab

        ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Risk 360' button

        Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    hidden    timeout=${processing_stage_timeout}
    END

    Run Keyword And Continue On Failure    Switch To Documents

    ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Risk 360' button second time

    ${stage_visible}=    Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    visible    timeout=${element_timeout}
    IF    ${stage_visible}
        Run Keyword And Continue On Failure    Log    Processing Stage ${stageNo} is visible after update
        Run Keyword And Return Status    Wait For Elements State    ${stage_locator}    hidden    timeout=${processing_stage_timeout}
    END
    

# Advance Stage
#     [Documentation]    Clicks the 'Advance Stage' button and waits for the submission to move to the next stage.
#     [Arguments]    ${stageNo}
#     ${saveSubmissionStatus}    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${element_timeout}
#     IF    ${saveSubmissionStatus}
#         Run Keyword And Continue On Failure    Save Submission And verify popup
#     END
#     # Wait For Elements State    ${Workflow_Advance_Stage}    visible    
#     Run Keyword And Continue On Failure    Wait For Element With Message    Workflow_Advance_Stage    ${Workflow_Advance_Stage}    visible
#     Click    ${Workflow_Advance_Stage}
#     ${stage}    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]
#     Run Keyword And Continue On Failure    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
#     IF    ${status}
#         Log Step    Processing Stage ${stageNo} hidden
#     ELSE
#         Click    ${Side_Bar_Risk360_Button}
#         Switch to Documents
#         ${checkEditSubmission}    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
#         IF    ${checkEditSubmission} 
#             Log    Processing Stage ${stageNo} hidden
#         ELSE
#         # Wait For Elements State   ${stage}   hidden    timeout=120s
#         Run Keyword And Continue On Failure    Wait For Element With Message    stage    ${stage}    visible
#         END
#     END 
Advance Stage
    [Documentation]    Clicks the 'Advance Stage' button and waits for the submission to move to the next stage.
    [Arguments]    ${stageNo}

    ${saveSubmissionStatus}=    Run Keyword And Return Status    Wait For Elements State    ${SaveSubmission}    visible    timeout=${display_timeout}
    IF    ${saveSubmissionStatus}
        Run Keyword And Continue On Failure    Save Submission And verify popup
    END
    Click Answers Tab
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Advance_Stage}    visible    timeout=${element_timeout}
    IF    not ${status}
        Fatal Error    'Advance Stage' button is not visible. Stopping entire suite execution.
    END

    ${status}=    Run Keyword And Return Status    Click    ${Workflow_Advance_Stage}
    IF    not ${status}
        Fatal Error    Failed to click on 'Advance Stage' button. Stopping entire suite execution.
    END
    ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Stage ${stageNo} is not visible or failed to load after clicking 'Advance Stage'.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
    IF    ${status}
        Log Step    Processing Stage ${stageNo} is successfully hidden after completion.
    ELSE
        ${sidebarStatus}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${sidebarStatus}    Failed to click on 'Risk 360' sidebar button.

        Switch To Documents

        ${checkEditSubmission}=    Run Keyword And Return Status    Wait For Elements State    ${EditSubmission}    visible    timeout=${element_timeout}
        IF    ${checkEditSubmission}
            Log    Processing Stage ${stageNo} is hidden, Edit Submission is visible.
        ELSE
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Stage ${stageNo} did not hide even after extended wait time ${processing_stage_timeout}.
        END
    END

Save And Close for Child Submission
     [Documentation]    Verifies the 'Finish' tab is correctly displayed and then clicks the 'Save and Close' button.
    # Wait For Elements State    ${All_Done}    visible   
    # Run Keyword And Continue On Failure    Wait For Element With Message    All_Done    ${All_Done}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${All_Done}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'All_Done is not visible with in '${element_timeout}
    Get Element States    ${Please_Review_Msg}    validate    value & visible    'Please_Review_Msg should be visible.'
    Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
    Click    ${SaveAndClose}

# Create Child Submission  
#     [Arguments]    ${product}
#     Click Coverage Tab   
#     Wait For Elements State    ${CoverageProductButton}    visible
#     Click    ${CoverageProductButton} 
#     Wait For Elements State    ${AddValueButton}    visible
#     Click    ${AddValueButton} 
#     Wait For Elements State    ${CoverageProductDropdown}    visible
#     Click    ${CoverageProductDropdown}
#     ${value}    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${product}    '])[2]
#     Wait For Elements State    ${value}    visible
#     Click    ${value}
#     Get Element States    ${CoverageUserMod}    validate    value & visible    
#     Click Finish Tab
#     Save And Close for Child Submission

# Create Child Submission  
#     [Arguments]    ${data}
#     Click Edit Submission
#     Scroll To Element    ${CoverageProduct}
#     Click    ${CoverageProduct}
#     ${value}    Catenate    SEPARATOR=    ${SelectNewValue}    ${data['productName']}    ']
#     # Wait For Elements State    ${value}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    value    ${value}    visible
#     Click    ${value}
#     Press Keys    ${CoverageProduct}    Escape
#     # ${text}    Get Text    ${ProductSegmentValue}
#     # ${trimText}    Strip String    ${text}
#     # Run Keyword And Continue On Failure    Should Be Equal    ${data['ProductSegment']}    ${trimText}
#     Scroll To Element    ${ClearanceCompleteButton}
#     # Wait For Elements State    ${ClearanceCompleteButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearanceCompleteButton    ${ClearanceCompleteButton}    visible
#     Click    ${ClearanceCompleteButton}
#     # Wait For Elements State    ${ClearanceCompleteButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearanceCompleteButton    ${ClearanceCompleteButton}    visible
#     ${text}    Get Text    ${ClearanceSavedPopup}
#     ${trimText}    Strip String    ${text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${data['ClearanceSavedPopupText']}    ${trimText}
Create Child Submission
    [Documentation]    Creates a child submission by selecting the product and completing clearance. Verifies the clearance saved popup text.
    [Arguments]    ${data}

    Click Edit Submission
    ${Status}=    Run Keyword And Return Status    Scroll To Element    ${CoverageProduct}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to Scroll To Element Coverage Product in clearance tab
    ${status}=    Run Keyword And Return Status    Click    ${CoverageProduct}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Coverage Product dropdown.

    ${value}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${data['productName']}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    Product value "${data['productName']}" is not visible in Coverage Product dropdown.

    ${status}=    Run Keyword And Return Status    Click    ${value}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to select product "${data['productName']}" from Coverage Product dropdown.

    Press Keys    ${CoverageProduct}    Escape

    ${Status}=    Run Keyword And Return Status    Scroll To Element    ${ClearanceCompleteButton}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to Scroll To Element Clearance Complete Button

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceCompleteButton}    visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    Clearance Complete button is not visible.

    ${status}=    Run Keyword And Return Status    Click    ${ClearanceCompleteButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Clearance Complete button.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceCompleteButton}    visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    Clearance Complete button did not reappear after clicking.

    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceSavedPopup}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=ClearanceSavedPopup element is not present to get a text value.
    ${text}=    Get Text    ${ClearanceSavedPopup}

    ${trimText}=    Strip String    ${text}

    Run Keyword And Continue On Failure    Should Be Equal    ${data['ClearanceSavedPopupText']}    ${trimText}    Clearance saved popup text does not match expected value.

# Wait For Processing Stage
#     [Arguments]    ${stageNo}=''
#     switch to Documents
#     IF    ${stageNo} == ''
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ')]
#     ELSE
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]
#     END
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
#     ${rejectStatus}    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${element_timeout}
#     IF    ${status}
#         ${status}    Run Keyword And Return Status    Wait For Element With Message    Processing Stage    ${stage}    hidden    wait for processing stage should be hidden within the time.The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test.    timeout=${processing_stage_timeout}
#         IF    ${status}
#             RETURN    False
#         END
#     ELSE IF    ${rejectStatus}
#         ${status}    Run Keyword And Return Status    Wait For Element With Message    Reject processing Stage    ${RejectProcessing}    hidden    wait for reject processing stage should be hidden within the time.The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test.    timeout=${processing_stage_timeout}      
#         IF    ${status}
#             RETURN    False
#         END
#     END
# Wait For Processing Stage
#     [Arguments]    ${stageNo}=''
#     switch to Documents
#     IF    ${stageNo} == ''
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ')]
#     ELSE
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]
#     END
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
#     ${rejectStatus}    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${element_timeout}
#     IF    ${status}
#         ${status}    Run Keyword And Return Status    Wait For Element With Message    Processing Stage    ${stage}    hidden    wait for processing stage should be hidden within the time.The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test.    timeout=${processing_stage_timeout}
#         IF    ${status}
#             RETURN    False
#         END
#     ELSE IF    ${rejectStatus}
#         ${status}    Run Keyword And Return Status    Wait For Element With Message    Reject processing Stage    ${RejectProcessing}    hidden    wait for reject processing stage should be hidden within the time.The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test.    timeout=${processing_stage_timeout}      
#         IF    ${status}
#             RETURN    False
#         END
#     END
Wait For Processing Stage
    [Documentation]    Waits for the processing stage (or rejection stage) to be completed and hidden.
    ...    This keyword checks whether the submission is still processing and waits until it completes or times out.
    ...
    ...    *Arguments:*
    ...    - `${stageNo}`: Optional. The specific stage number to wait for. If not provided, waits for the default processing stage.
    [Arguments]    ${stageNo}=''
    Click Answers Tab
    Switch To Documents
    Sleep    5s
    IF    ${stageNo} == ''
        ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ')]

    ELSE
        ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]

    END

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${display_timeout}
    ${rejectStatus}=    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${display_timeout}

    IF    ${status}
        Switch to Summary
        ${summaryVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Processing}    attached    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${summaryVisible}    msg=Summary processing message not visible.

        ${ActualValue}=    Get Text    ${Summary_Processing}
        Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Read-only while processing    msg=Summary processing message text mismatch.
        Switch To Documents
        Sleep    10s
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Processing stage ${stageNo} did not complete within ${processing_stage_timeout} seconds. The submission is still processing.
        IF    not ${status}
            Log    ❌ Processing stage ${stageNo} is still visible after timeout. Aborting test.
            RETURN    False
        ELSE
            Log Step    ✅ Processing stage ${stageNo} completed successfully.
        END

    ELSE IF    ${rejectStatus}
        Switch to Summary
        ${summaryVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Processing}    visible    timeout=${display_timeout}
        Should Be True    ${summaryVisible}    msg=Summary processing message not visible.

        ${ActualValue}=    Get Text    ${Summary_Processing}
        Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Read-only while processing    msg=Summary processing message text mismatch.
        Switch To Documents
        Sleep    10s
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    hidden    timeout=${processing_stage_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Rejected processing stage did not complete within ${processing_stage_timeout} seconds. The submission is still processing.
        IF    not ${status}
            Log    ❌ Reject processing stage is still visible after timeout. Aborting test.
            RETURN    False
        ELSE
            Log Step    ✅ Reject processing stage completed successfully.
        END

    ELSE
        Log    ⚠️ Neither processing stage nor reject processing stage was Not found visible.

    END


# Verify Summary Menu is displayed
#     Run Keyword And Continue On Failure    Wait For Element With Message    SummaryTab    ${SummaryTab}    visible    wait for Summarytab And verify that Summary tab is present in the Side menu 
#     Scroll To Element    ${SummaryTab}

Verify Summary Menu is displayed
    [Documentation]    Verifies that the Summary tab is present and visible in the side menu.
    ...    Scrolls to the tab after verifying visibility.
    
    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SummaryTab}        visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Verify Summary Menu: Summary tab is not visible in the side menu.

    ${scroll_status}=    Run Keyword And Return Status    Scroll To Element    ${SummaryTab}
    Run Keyword And Continue On Failure    Should Be True    ${scroll_status}    msg=Verify Summary Menu: Failed to scroll to Summary tab.


# Switch To Summary Tab
#     [Arguments]    ${expectedHeader}
#     Scroll To Element    ${SummaryTab}
#     Run Keyword And Continue On Failure    Wait For Element With Message    SummaryTab    ${SummaryTab}    visible    wait for Summarytab And verify that Summary tab is present in the Side menu
#     Click    ${SummaryTab}
#     ${actualHeader}    Get Text    ${SummaryHeader}
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualHeader}    ${expectedHeader}
Switch To Summary Tab
    [Documentation]    Scrolls to and clicks the 'Summary' tab, then verifies the header matches the expected value.
    [Arguments]    ${expectedHeader}

    # Scroll to the Summary tab element
    ${scrolled}=    Run Keyword And Return Status    Scroll To Element    ${SummaryTab}
    Run Keyword And Continue On Failure    Should Be True    ${scrolled}    msg=Switch To Summary Tab: Failed to scroll to the 'Summary' tab element.

    # Wait for the Summary tab to be visible
    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SummaryTab}    visible
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Switch To Summary Tab: 'Summary' tab is not visible in the side menu.

    # Click the Summary tab
    ${clicked}=    Run Keyword And Return Status    Click    ${SummaryTab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Switch To Summary Tab: Failed to click the 'Summary' tab.

    # Verify the header text
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${SummaryHeader}    visible    timeout=${element_timeout}
	Should Be True    ${Status}    msg=Summary page is not opened after clicking Summary tab.
    ${actualHeader}=    Get Text    ${SummaryHeader}
    Run Keyword And Continue On Failure    Should Be Equal    ${actualHeader}    ${expectedHeader}    msg=Switch To Summary Tab: Header text '${actualHeader}' does not match expected '${expectedHeader}'.

Verify Premium Amount 
    # Wait For Elements State    ${PremiumAmount}    visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    PremiumAmount    ${PremiumAmount}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PremiumAmount}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Premium Amount is not available in summary page'
    # ${actualAmount}    Get Text    ${PremiumAmount}
    # ${premiumValue}    Convert To Number    ${actualAmount}
    # Run Keyword And Continue On Failure    Should Be True    ${premiumValue} >= 0
    

# Verify Policy Information In Summary Tab
#     [Arguments]    ${data}
#     ${PolicyTexts}    Get Elements    ${FieldsInPolicyInfromation}
#     ${actualPolicyFields}    Create List
#     FOR    ${fields}    IN    @{PolicyTexts}
#         ${text}    Get Text    ${fields}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actualPolicyFields}    ${trimText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${data['PolicyFields']}    ${actualPolicyFields}
#     Click    ${permium_Btn_Loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    premium_field_loc    ${premium_field_loc}    visible    Wait for premium field and verify that the 5s
#     Fill Text    ${premium_field_loc}    ${data['premium']}
#     #verify Attachment point
#     Get Element States    ${AttachmentPoint}    validate    value & visible
#     Click    ${AttachmentPoint}
#     # Wait For Elements State    ${AttachmentPointInput}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AttachmentPointInput    ${AttachmentPointInput}    visible
#     Fill Text    ${AttachmentPointInput}    ${data['AttachmentPoint']}
#     #policy number
#     ${checkPolicyNumber}    Get Text    ${PolicyNumberInInfo}
#     ${isPolicyEmpty}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Be Equal    ${checkPolicyNumber}     Edit
#     IF    ${isPolicyEmpty}
#         Click    ${PolicyNumberInInfo}
#         # Wait For Elements State    ${PolicyNumberInput}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    PolicyNumberInput    ${PolicyNumberInput}    visible
#         Fill Text    ${PolicyNumberInput}    ${data['PolicyNumber']}
#     END
#     #Class of business
#     Get Element States    ${ClassOfBuisness}    validate    value & visible
#     Click    ${ClassOfBuisness}
#     ${ClassOfBusinessdropdownValue}    Catenate    SEPARATOR=    ${ClassOfBuisnessDropdown}    ${data['ClassOfBusiness']}']
#     Get Element States    ${ClassOfBusinessdropdownValue}    validate    value & visible
#     Click    ${ClassOfBusinessdropdownValue}
#     #placement type
#     Get Element States    ${PlacementType}    validate    value & visible
#     Click    ${PlacementType}
#     ${PlacementTypedropdownValue}    Catenate    SEPARATOR=    ${PlacementTypeOption}    ${data['PlacementType']}']
#     Get Element States    ${PlacementTypedropdownValue}    validate    value & visible
#     Click    ${PlacementTypedropdownValue}
#     #verify mailed date is not displayed
#     ${date}    Get Text    ${MailedDate}
#     Run Keyword And Continue On Failure    Should Be Equal    ${data['MailedDate']}    ${date}
Verify Policy Information In Summary Tab
    [Documentation]    Verifies policy information fields in the Summary tab and updates premium, attachment point, policy number, class of business, and placement type.
    [Arguments]    ${data}

    ${PolicyTexts}=    Get Elements    ${FieldsInPolicyInfromation}
    ${actualPolicyFields}=    Create List
    FOR    ${fields}    IN    @{PolicyTexts}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${fields}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Policy field element is not present to get a text value.
        ${text}=    Get Text    ${fields}
        ${trimText}=    Strip String    ${text}
        Append To List    ${actualPolicyFields}    ${trimText}
    END

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${data['PolicyFields']}    ${actualPolicyFields}    msg=Policy fields do not match expected data.

    # ${click_premium}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    # Run Keyword And Continue On Failure    Should Be True    ${click_premium}    msg=Failed to click on Premium button.

    # # Run Keyword And Continue On Failure    Wait For Element With Message    premium_field_loc    ${premium_field_loc}    visible    Wait for premium field to appear.

    # ${fill_premium}=    Run Keyword And Return Status    Fill Text    ${premium_field_loc}    ${data['premium']}
    # Run Keyword And Continue On Failure    Should Be True    ${fill_premium}    msg=Failed to fill Premium field.

    # # Verify Attachment Point
    # # Run Keyword And Continue On Failure    Get Element States    ${AttachmentPoint}    validate    value & visible    msg=Attachment Point should be visible.
    # ${click_attachment}=    Run Keyword And Return Status    Click    ${AttachmentPoint}
    # Run Keyword And Continue On Failure    Should Be True    ${click_attachment}    msg=Failed to click Attachment Point field.

    # # Run Keyword And Continue On Failure    Wait For Element With Message    AttachmentPointInput    ${AttachmentPointInput}    visible
    # ${fill_attachment}=    Run Keyword And Return Status    Fill Text    ${AttachmentPointInput}    ${data['AttachmentPoint']}
    # Run Keyword And Continue On Failure    Should Be True    ${fill_attachment}    msg=Failed to fill Attachment Point input.

    # # Verify and Update Policy Number if editable
    # ${checkPolicyNumber}=    Get Text    ${PolicyNumberInInfo}
    # ${isPolicyEmpty}=    Run Keyword And Return Status    Should Be Equal    ${checkPolicyNumber}    Edit
    # IF    ${isPolicyEmpty}
    #     ${click_policy}=    Run Keyword And Return Status    Click    ${PolicyNumberInInfo}
    #     Run Keyword And Continue On Failure    Should Be True    ${click_policy}    msg=Failed to click Policy Number field.
    #     # Run Keyword And Continue On Failure    Wait For Element With Message    PolicyNumberInput    ${PolicyNumberInput}    visible
    #     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PolicyNumberInput}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    'Policy Number Input is not visible to select the submission'
    #     ${fill_policy}=    Run Keyword And Return Status    Fill Text    ${PolicyNumberInput}    ${data['PolicyNumber']}
    #     Run Keyword And Continue On Failure    Should Be True    ${fill_policy}    msg=Failed to fill Policy Number input.
    # END

    # # Class of Business
    # Run Keyword And Continue On Failure    Get Element States    ${ClassOfBuisness}    validate    value & visible    msg=Class of Business dropdown should be visible.
    # ${click_class}=    Run Keyword And Return Status    Click    ${ClassOfBuisness}
    # Run Keyword And Continue On Failure    Should Be True    ${click_class}    msg=Failed to click Class of Business dropdown.

    # ${ClassOfBusinessdropdownValue}=    Catenate    SEPARATOR=    ${ClassOfBuisnessDropdown}    ${data['ClassOfBusiness']}']
    # Run Keyword And Continue On Failure    Get Element States    ${ClassOfBusinessdropdownValue}    validate    value & visible    msg=Expected Class of Business option not visible.
    # ${click_class_option}=    Run Keyword And Return Status    Click    ${ClassOfBusinessdropdownValue}
    # Run Keyword And Continue On Failure    Should Be True    ${click_class_option}    msg=Failed to select Class of Business option.

    # # Placement Type
    # Run Keyword And Continue On Failure    Get Element States    ${PlacementType}    validate    value & visible    msg=Placement Type dropdown should be visible.
    # ${click_placement}=    Run Keyword And Return Status    Click    ${PlacementType}
    # Run Keyword And Continue On Failure    Should Be True    ${click_placement}    msg=Failed to click Placement Type dropdown.

    # ${PlacementTypedropdownValue}=    Catenate    SEPARATOR=    ${PlacementTypeOption}    ${data['PlacementType']}']
    # Run Keyword And Continue On Failure    Get Element States    ${PlacementTypedropdownValue}    validate    value & visible    msg=Expected Placement Type option not visible.
    # ${click_placement_option}=    Run Keyword And Return Status    Click    ${PlacementTypedropdownValue}
    # Run Keyword And Continue On Failure    Should Be True    ${click_placement_option}    msg=Failed to select Placement Type option.

    # # Verify Mailed Date is displayed correctly
    # ${date}=    Get Text    ${MailedDate}
    # Run Keyword And Continue On Failure    Should Be Equal    ${data['MailedDate']}    ${date}    msg=Mailed Date does not match expected value.

# Verify Policy Information Fields In Summary Tab
#     [Arguments]    ${expected_data}
#     ${PolicyTexts}    Get Elements    ${FieldsInPolicyInfromation}
#     ${actualPolicyFields}    Create List
#     FOR    ${fields}    IN    @{PolicyTexts}
#         ${text}    Get Text    ${fields}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actualPolicyFields}    ${trimText}
#     END
#     Run Keyword And Continue On Failure     Lists Should Be Equal    ${expected_data}    ${actualPolicyFields}
Verify Policy Information Fields In Summary Tab
    [Documentation]    Verifies that the Policy Information fields in the Summary tab match the expected data.
    [Arguments]    ${expected_data}
    # ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${FieldsInPolicyInfromation}    visible    timeout=${display_timeout}
	# Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Policy Information: No policy information fields found in the Summary tab. Locator used: '${FieldsInPolicyInfromation}'. The fields may not have loaded or the locator may be incorrect
    ${fields_present}=    Get Elements    ${FieldsInPolicyInfromation}
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${fields_present}    msg=Verify Policy Information: No policy information fields found in the Summary tab. Locator used: '${FieldsInPolicyInfromation}'. The fields may not have loaded or the locator may be incorrect.
    @{PolicyTexts}=    Get Elements    ${FieldsInPolicyInfromation}
    @{actualPolicyFields}=    Create List

    FOR    ${field}    IN    @{PolicyTexts}
        ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${field}    visible    timeout=${display_timeout}
	    Should Be True    ${Status}    msg=Verify Policy Information: Failed to get text for a field element. Ensure the element is visible and accessible.
        ${text}=    Get Text    ${field}
        # Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Policy Information: Failed to get text for a field element. Ensure the element is visible and accessible.
        ${trimText}=    Strip String    ${text}
        Append To List    ${actualPolicyFields}    ${trimText}
    END

    ${fields_match}=    Run Keyword And Return Status    Lists Should Be Equal    ${expected_data}    ${actualPolicyFields}
    Run Keyword And Continue On Failure    Should Be True    ${fields_match}    msg=Verify Policy Information: Policy information fields do not match expected. Actual fields: ${actualPolicyFields}, Expected: ${expected_data}

# Verify Summary Table Data
#     [Arguments]    ${expectedTableHeader}    ${expectedTableData}
#     @{actualTableHeader}    Create List
#     @{actualTableData}    Create List
#     # Wait For Elements State    ${AccountHistoryTable}
#     Run Keyword And Continue On Failure    Wait For Element With Message    AccountHistoryTable    ${AccountHistoryTable}    visible
#     @{header}    Get Elements    ${AccountHistoryTableHeader}
#     @{tableData}    Get Elements    ${AccountHistory} 
#     FOR    ${element}    IN    @{header}
#         ${text}    Get Text    ${element}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actualTableHeader}    ${trimText}    
#     END  
#     FOR    ${data}    IN    @{tableData}
#         ${text}    Get Text    ${data}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${actualTableData}    ${trimText}    
#     END    
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedTableHeader}    ${actualTableHeader}
#     Log    ${actualTableData}
#     FOR    ${data1}    IN    @{actualTableData}
#     Run Keyword And Continue On Failure    List Should Contain Value    ${expectedTableData}    ${data1}
#     END
Verify Summary Table Data
    [Documentation]    Verifies that the summary table headers and data match the expected values.
    [Arguments]    ${expectedTableHeader}    ${expectedTableData}

    @{actualTableHeader}=    Create List
    @{actualTableData}=      Create List

    ${table_visible}=    Run Keyword And Return Status    Wait For Elements State    ${AccountHistoryTable}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${table_visible}    msg=Verify Summary Table Data: Account History table is not visible on the page. Cannot verify headers or data.

    ${header_elements}=    Get Elements    ${AccountHistoryTableHeader}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${header_elements}    msg=Verify Summary Table Data: No header elements were found in the Account History table. Locator used: '${AccountHistoryTableHeader}'. The table might not be loaded, or the locator could be incorrect.

    ${data_elements}=      Get Elements    ${AccountHistory}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${data_elements}    msg=Verify Summary Table Data: No data rows found in the Account History table. Locator used: '${AccountHistory}'. The table might be empty, not rendered yet, or the locator may be incorrect.

    FOR    ${element}    IN    @{header_elements}
        ${text}=    Get Text    ${element}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${element}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Account History Table Header element is not present to get text.
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Summary Table Data: Failed to get text for a header element in the table.
        ${trimText}=    Strip String    ${text}
        Append To List    ${actualTableHeader}    ${trimText}
    END

    FOR    ${data}    IN    @{data_elements}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${data}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Account History Data cell element is not present to get text.
        ${text}=    Get Text    ${data}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Summary Table Data: Failed to get text for a data cell in the table.
        ${trimText}=    Strip String    ${text}
        Append To List    ${actualTableData}    ${trimText}
    END

    ${headers_match}=    Run Keyword And Return Status    Lists Should Be Equal    ${expectedTableHeader}    ${actualTableHeader}
    Run Keyword And Continue On Failure    Should Be True    ${headers_match}    msg=Verify Summary Table Data: Table headers do not match expected. Actual headers: ${actualTableHeader}, Expected: ${expectedTableHeader}

    FOR    ${data1}    IN    @{actualTableData}
        ${data_present}=    Run Keyword And Return Status    List Should Contain Value    ${expectedTableData}    ${data1}
        Run Keyword And Continue On Failure    Should Be True    ${data_present}    msg=Verify Summary Table Data: Data cell '${data1}' is not present in the expected table data: ${expectedTableData}
    END


# Get New Submission ID After Child Submission
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewSubmissionID    ${NewSubmissionID}    visible    Wait for the new submission ID and verify that the child submission ID is created.
#     ${text}    Get Text    ${NewSubmissionID}
#     ${trimText}    Strip String    ${text}
#     ${new_id}    Convert To Lower Case    ${trimText}
#     RETURN    ${new_id}

Get New Submission ID After Child Submission
    [Documentation]    Retrieves the new submission ID generated after creating a child submission.
    ...    Waits for the new submission ID element to become visible, extracts the ID text,
    ...    trims any extra spaces, and converts it to lowercase before returning.
    ...
    ...    *Returns:*
    ...    - `${new_id}`: The new child submission ID in lowercase.

    ${id_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewSubmissionID}    visible    timeout=${element_timeout}

    Should Be True    ${id_visible}    msg=Get New Submission ID: New submission ID element is not visible.

    ${id_text}=    Get Text    ${NewSubmissionID}
    Should Not Be Empty    ${id_text}
    # Run Keyword And Continue On Failure    Should Be True    ${id_text}    msg=Get New Submission ID: Failed to retrieve text of the new submission ID.

    ${trimmed_id}=    Strip String    ${id_text}
    ${new_id}=    Convert To Lower Case    ${trimmed_id}

    Log Step    'New Child Submission ID -> ${new_id}'
    RETURN    ${new_id}


# Wait Until Element Is Hidden With Polling
#     [Documentation]    Waits until the given element is hidden, polling every 60 seconds up to 600 seconds.
#     ...    This keyword checks the element's state every 60 seconds (polling) instead of waiting the full timeout at once.
#     ...    *Arguments:*
#     ...    - `${element}`: The locator of the element to check for hidden state.
#     [Arguments]    ${element}
#     ${max_wait}    Set Variable    600
#     ${interval}    Set Variable    60
#     ${elapsed}     Set Variable    0
#     ${is_hidden}   Set Variable    False
#     FOR    ${i}    IN RANGE    0    ${max_wait}    ${interval}
#         ${is_hidden}    Run Keyword And Return Status    Wait For Elements State    ${element}    hidden    timeout=${interval}s
#         IF    ${is_hidden}
#             Log    Element is hidden after ${elapsed} seconds
#             Exit For Loop
#         ELSE
#             Log    Element still visible after ${elapsed} seconds, polling again...
#             ${elapsed}    Evaluate    ${elapsed} + ${interval}
#              Click Answers Tab
#              Click   ${Side_Bar_Risk360_Button}
#              Switch to Documents
#         END
#     END
#     Run Keyword And Continue On Failure    Should Be True    ${is_hidden}    Element was not hidden after ${max_wait} seconds
Wait Until Element Is Hidden With Polling
    [Documentation]    Waits until the given element is hidden, polling every 60 seconds up to 600 seconds.
    ...    Checks the element's state every 60 seconds instead of waiting the full timeout at once.
    ...    *Arguments:*
    ...    - `${element}`: The locator of the element to check for hidden state.

    [Arguments]    ${element}

    ${max_wait}=    Set Variable    600
    ${interval}=    Set Variable    60
    ${elapsed}=     Set Variable    0
    ${is_hidden}=   Set Variable    False

    FOR    ${i}    IN RANGE    0    ${max_wait}    ${interval}
        ${is_hidden}=    Run Keyword And Return Status    Wait For Elements State    ${element}    hidden    timeout=${interval}s
        IF    ${is_hidden}
            Log    Element is hidden after ${elapsed} seconds
            Exit For Loop
        ELSE
            Log    Element still visible after ${elapsed} seconds, polling again...
            ${elapsed}=    Evaluate    ${elapsed} + ${interval}

            ${clicked}=    Run Keyword And Return Status    Click    Answers Tab
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Answers Tab during polling

            ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Risk360 sidebar button during polling

            Switch to Documents
        END
    END

    Run Keyword And Continue On Failure    Should Be True    ${is_hidden}    msg=Element '${element}' was not hidden after ${max_wait} seconds

# Add Lob in the Clearnce Tab for Product Type
#     [Arguments]    ${product}
#     Click Coverage Tab   
#     # Wait For Elements State    ${CoverageProductButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    CoverageProductButton    ${CoverageProductButton}    visible
#     Click    ${CoverageProductButton} 
#     # Wait For Elements State    ${AddValueButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AddValueButton    ${AddValueButton}    visible
#     Click    ${AddValueButton} 
#     # Wait For Elements State    ${CoverageProductDropdown}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    CoverageProductDropdown    ${CoverageProductDropdown}    visible
#     Click    ${CoverageProductDropdown}
#     ${value}    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${product}    '])[2]
#     # Wait For Elements State    ${value}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    value    ${value}    visible
#     Click    ${value}
#     Get Element States    ${CoverageUserMod}    validate    value & visible    
#     Hover    ${NewLob}
#     # Wait For Elements State    ${RemoveLob}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    RemoveLob    ${RemoveLob}    visible
#     Click    ${RemoveLob}
Add Lob in the Clearnce Tab for Product Type
    [Arguments]    ${product}

    Click Coverage Tab

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${CoverageProductButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage Product button is not visible in Clearance tab.

    ${clicked}=    Run Keyword And Return Status    Click    ${CoverageProductButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Coverage Product button.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${AddValueButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Add Value button is not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${AddValueButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Add Value button.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${CoverageProductDropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage Product dropdown is not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${CoverageProductDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Coverage Product dropdown.

    ${value}=    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${product}    '])[2]
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Product '${product}' option is not visible in dropdown.

    ${clicked}=    Run Keyword And Return Status    Click    ${value}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select product value '${product}'.

    ${status}=    Run Keyword And Return Status    Get Element States    ${CoverageUserMod}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Coverage added but user modification icon is not visible.

    Hover    ${NewLob}

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${RemoveLob}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Remove LOB icon is not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${RemoveLob}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Remove LOB icon.

# Add LOB if not present
#     [Arguments]    ${product}
#     Click Coverage Tab 
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${EmptyProductType}    visible
#     IF    ${status}
#         Click    ${EmptyProductType}
#         Click    ${ProductDropdown1}
#         ${value}    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${product}    '])[1]
#         # Wait For Elements State    ${value}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    value    ${value}    visible
#     Click    ${value}
#     END
Add LOB if not present
    [Arguments]    ${product}

    Click Coverage Tab

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${EmptyProductType}    visible    timeout=${element_timeout}
    IF    ${status}

        ${clicked}=    Run Keyword And Return Status    Click    ${EmptyProductType}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Empty Product Type field.

        ${clicked}=    Run Keyword And Return Status    Click    ${ProductDropdown1}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Product dropdown.

        ${value}=    Catenate    SEPARATOR=    ${CoverageProductSelect}    ${product}    '])[1]
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Product '${product}' option is not visible in dropdown.

        ${clicked}=    Run Keyword And Return Status    Click    ${value}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select product '${product}' from dropdown.

    END


# Not Taken and Verify the Tag name
#     [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
#     ...
#     ...    *Arguments:*
#     ...    - `${NotTakenReasons}`: A list of reasons for the rejection.
#     ...    - `${data_details}`: A text description of the rejection details.
#     ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.
#     [Arguments]    ${NotTakenReasons}    ${data_details}    ${action}
#     Click    ${WorkFLow_NotTaken}
#     # Wait For Elements State    ${UpdateWorkflowStage}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
#     Get Element States    ${SelectReason}    validate    value & visible    'SelectReason should be visible.'
#     FOR     ${NotTakenReason}    IN    @{NotTakenReasons}
#     ${reason}    Catenate    SEPARATOR=    ${ReasonForReject1}    ${NotTakenReason}    ${ReasonForReject2}
#     Check Checkbox    ${reason}
#     END
#     Type Text    ${Details}    ${data_details}
#     IF    '${action}' == 'Cancel'
#         Get Element States    ${SelectReason}    validate    value & enabled    'SelectReason should be enabled.'
#         Click    ${CancelButtonInReject}
#         Verify WorkFlow Options Advance Stage and Not Taken
#         Get Element States    ${QuotedTag}    validate    value & visible    'QuotedTag should be visible.'
#     ELSE
#          Get Element States    ${AcceptButton}    validate    value & enabled    'AcceptButton should be enabled.'
#          Click    ${AcceptButton}
#          Wait For Processing Stage
#          Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
#          Get Element States    ${NotTakenTag}    validate    value & visible    'RejectedTag should be visible.'
#     END
Reject Submission And Verify Not Taken Tag
    [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
    ...
    ...    *Arguments:*
    ...    - `${NotTakenReasons}`: A list of reasons for the rejection.
    ...    - `${data_details}`: A text description of the rejection details.
    ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.

    [Arguments]    ${NotTakenReasons}    ${data_details}    ${action}

    ${clicked}=    Run Keyword And Return Status    Click    ${WorkFLow_NotTaken}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click WorkFLow_NotTaken

    # Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UpdateWorkflowStage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Update Work flow Stage is not available while Reject Submission And Verify Not Taken Tag'

    Run Keyword And Continue On Failure    Get Element States    ${SelectReason}    validate    value & visible    msg=SelectReason should be visible

    FOR     ${NotTakenReason}    IN    @{NotTakenReasons}
        ${reason}=    Catenate    SEPARATOR=    ${ReasonForReject1}    ${NotTakenReason}    ${ReasonForReject2}
        Run Keyword And Continue On Failure    Check Checkbox    ${reason}
    END

    Run Keyword And Continue On Failure    Type Text    ${Details}    ${data_details}

    IF    '${action}' == 'Cancel'
        Run Keyword And Continue On Failure    Get Element States    ${SelectReason}    validate    value & enabled    msg=SelectReason should be enabled

        ${clicked}=    Run Keyword And Return Status    Click    ${CancelButtonInReject}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click CancelButtonInReject

        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Not Taken

        Run Keyword And Continue On Failure    Get Element States    ${QuotedTag}    validate    value & visible    msg=QuotedTag should be visible
    ELSE
        Run Keyword And Continue On Failure    Get Element States    ${AcceptButton}    validate    value & enabled    msg=AcceptButton should be enabled

        ${clicked}=    Run Keyword And Return Status    Click    ${AcceptButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click AcceptButton

        Run Keyword And Continue On Failure    Wait For Processing Stage

        Run Keyword And Continue On Failure    Get Element States    ${Reactive}    validate    value & visible    msg=Reactive should be visible

        Run Keyword And Continue On Failure    Get Element States    ${NotTakenTag}    validate    value & visible    msg=NotTakenTag should be visible
    END


# Verify WorkFlow Options Advance Stage and Not Taken
#     [Documentation]    Verifies that the 'Advance Stage' and 'Reject' buttons are visible in the workflow options.
#     Get Element States    ${Workflow_Advance_Stage}    validate    value & visible    'Workflow_Advance_Stage should be visible.'
#     Get Element States    ${WorkFLow_NotTaken}    validate    value & visible    'WorkFLow_NotTaken should be visible.'
Verify WorkFlow Options Advance Stage and Not Taken
    [Documentation]    Verifies that the 'Advance Stage' and 'Not Taken' buttons are visible in the workflow options.

    Run Keyword And Continue On Failure    Get Element States    ${Workflow_Advance_Stage}    validate    value & visible    msg=Workflow_Advance_Stage should be visible

    Run Keyword And Continue On Failure    Get Element States    ${WorkFLow_NotTaken}    validate    value & visible    msg=WorkFLow_NotTaken should be visible

# Verify the Error popup when mandate fields left empty
#     [Documentation]    Verifies the 'Finish' tab is correctly displayed and then clicks the 'Save and Close' button and handle the Error popup.
#     [Arguments]    ${expected_field} 
#     Click Finish Tab
#     Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
#     Click    ${SaveAndClose}
#     ${error_Message}    Run Keyword And Return Status    Get Element States    ${Error_Saving_popup}    validate    value & visible
#     Run Keyword And Continue On Failure    Should Be True    ${error_Message}
#     IF    ${error_Message} == True 
#     ${actualmessage}    Get Text    ${Error_Saving_popup}                
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualmessage}    Error saving user modifications    
#     ${Elements1}    Get Elements    ${missing_required_field}
#     ${ActualValues}    Create List    
#     FOR    ${element}    IN    @{Elements1}
#          ${actualmessage1}    Get Text    ${element}
#      ${actual}    Strip String    ${actualmessage1}  
#         Append To List    ${ActualValues}    ${actual}    
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal   ${ActualValues}    ${expected_field['expected_error_field1']}
#     END
#     # Wait For Elements State    ${processingInSubmission}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    processingInSubmission    ${processingInSubmission}    visible
#     Click    ${processingInSubmission}
#     # Wait For Elements State    ${UnderwriterName}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    UnderwriterName    ${UnderwriterName}    visible
#     Click    ${UnderwriterName}
#     Type Text    ${UnderwriterInput}    ${expected_field['UnderwriterName']}
#     Click    ${UnderwriterEmail}
#     Type Text    ${UnderwriterEmailInput}    ${expected_field['UnderwriterEmail']}
#     Click Finish Tab
#     Get Element States    ${SaveAndClose}    validate    value & visible    'SaveAndClose should be visible.'
#     Click    ${SaveAndClose}
#     ${error_Message}    Run Keyword And Return Status    Get Element States    ${Error_Saving_popup}    validate    value & visible
#     Run Keyword And Continue On Failure    Should Be True    ${error_Message}
#     IF    ${error_Message} == True 
#     ${actualmessage}    Get Text    ${Error_Saving_popup}                
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualmessage}    Error saving user modifications
#     # ${missing_required2}    Run Keyword And Return Status    Get Element States    ${Error_mess}
#     ${actualmessage2}    Get Text    ${Error_mess}
#     ${actual}    Strip String    ${actualmessage2}                
#     Run Keyword And Continue On Failure    Should Be Equal    ${actual}    ${expected_field['expected_error_field2']}
#     END
Verify the Error popup when mandate fields left empty
    [Documentation]    Verifies mandatory field errors on Finish tab & validates related error popup.
    [Arguments]    ${expected_field}

    # --- Click Finish Tab ---
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${SaveAndClose}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Save & Close button is not visible on Finish tab.

    ${clicked}=    Run Keyword And Return Status    Click    ${SaveAndClose}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Save & Close button.

    # --- Error Popup Validation ---
    ${error}=    Run Keyword And Return Status    Wait For Elements State    ${Error_Saving_popup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${error}    msg=Error popup not shown for missing mandatory fields.

    IF    ${error}
        ${popup_text}=    Get Text    ${Error_Saving_popup}
        Run Keyword And Continue On Failure    Should Be Equal    ${popup_text}    Error saving user modifications

        ${elements_list}=    Get Elements    ${missing_required_field}
        ${collected}=    Create List
        FOR    ${item}    IN    @{elements_list}
            ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${item}    attached    timeout=${element_timeout}
            Should Be True    ${attached}    msg=missing_required_field element is not present to get text.
            ${txt}=    Get Text    ${item}
            ${txt}=    Strip String    ${txt}
            Append To List    ${collected}    ${txt}
        END

        Run Keyword And Continue On Failure    Lists Should Be Equal    ${collected}    ${expected_field['expected_error_field1']}
    END

    # --- Fill Required Fields to Resolve Errors ---
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${processingInSubmission}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Processing tab is not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${processingInSubmission}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Processing tab.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${UnderwriterName}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Underwriter name field not visible.

    Type Text    ${UnderwriterInput}    ${expected_field['UnderwriterName']}
    Type Text    ${UnderwriterEmailInput}    ${expected_field['UnderwriterEmail']}

    # --- Save Again After Filling Mandatory Fields ---
    Click Finish Tab
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${SaveAndClose}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Save & Close not visible after filling fields.

    ${clicked}=    Run Keyword And Return Status    Click    ${SaveAndClose}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Save & Close after filling fields.

    ${error2}=    Run Keyword And Return Status    Wait For Elements State    ${Error_Saving_popup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${error2}    msg=Final error popup not shown.

    IF    ${error2}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${Error_mess}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Error_mess element is not present to get text.
        ${msg2}=    Get Text    ${Error_mess}
        ${msg2}=    Strip String    ${msg2}
        Run Keyword And Continue On Failure    Should Be Equal    ${msg2}    ${expected_field['expected_error_field2']}
    END

    # Click Answers Tab
    # Click and verify Clearance tab

verify Clearance Tab  
    [Documentation]    verify the Clearance tab
    ...    ${Expected_Values}    expected Product Segment value And Product value in the Coverage tab
    [Arguments]    ${Expected_Values}
    Click and verify Clearance tab
    Click Coverage Tab
     ${Acutal_List}    Create List
    FOR    ${Exceptedelement}    IN    @{TC_E2E_023['CoverageHeader']}
    ${Locator}    Catenate    SEPARATOR=    ${Loc_Clearance_ProductName}    ${Exceptedelement}    ${Loc_Clearance_SegmentName}
    # Wait For Elements State    ${Locator}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Locator}    visible    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Product name locator '${Locator}' is not visible.

    ${ActualProductName}=    Get Text    ${Locator}
    Append To List    ${Acutal_List}    ${ActualProductName}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Acutal_List}    ${Expected_Values}

# Verify Advance Stage is InActive
#     [Documentation]    This Method is used Verify the 'Advance Stage' is Not Active
#     Get Element States    ${Workflow_Advance_Stage}    validate    hidden

Verify Advance Stage Is InActive
    [Documentation]    Verifies that the 'Advance Stage' button is not active (hidden).

    Run Keyword And Continue On Failure    Get Element States    ${Workflow_Advance_Stage}    validate    hidden    msg=Advance Stage button should be hidden

# Verify System displays task reassignment pop-up for completed tasks
#     [Documentation]    This method is used Convr task tab
    
#     [Arguments]    ${ColumnNames}    ${expected_text}    ${Assign_To}

#     Click    ${Convr_Task_tab}
#     Click All tasks option
#     Rearrange Submission Page Columns    @{ColumnNames}
#     Click    ${Convr_Status_Filter_Button}
#     Click    ${Convr_Select_All_Option}
#     Click    ${Convr_Completed_Option}
#     Click    ${Convr_Status_Elements}
#     Click    ${Convr_Status_Elements}    button=right
#     ${result}    Get Text    ${Convr_Reassign}
#     Run Keyword And Continue On Failure    Should Be Equal    ${result}    ${expected_text}
#     Click    ${Convr_Status_Filter_Button}
#     Click    ${Convr_Select_All_Option}
#     Click    ${Convr_Select_All_Option}
#     Click    ${Convr_Created_Option}
#     Click    ${Convr_Status_Elements}
#     Click    ${Convr_Status_Elements}    button=right
#     Click    ${Convr_Reassign}
#     # Wait For Elements State    ${Convr_Reassign_Input_Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Reassign_Input_Field    ${Convr_Reassign_Input_Field}    visible
#     Fill Text    ${Convr_Reassign_Input_Field}    ${Assign_To}
#     click    ${Convr_Reassign_Option}
#     Get Element States    ${Convr_Reassign_Sucess_popup}    validate    value & visible 
#     # Wait For Elements State    ${Cancel_Filter_Button}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Cancel_Filter_Button    ${Cancel_Filter_Button}    visible
#     click    ${Cancel_Filter_Button}
Verify System Displays Task Reassignment Pop-up For Completed Tasks
    [Documentation]    Verifies task reassignment functionality in Convr task tab.
    [Arguments]    ${ColumnNames}    ${expected_text}    ${Assign_To}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Task_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Convr Task tab
    Click All tasks option
    Run Keyword And Continue On Failure    Rearrange Submission Page Columns    @{ColumnNames}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Filter_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Status Filter button

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Select_All_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Select All option

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Completed_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Completed option

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Elements}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Status Elements

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Elements}    button=right
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to right-click Status Elements

    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${Convr_Reassign}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=Convr_Reassign element is not present to get a text value.
    ${result}=    Get Text    ${Convr_Reassign}

    Run Keyword And Continue On Failure    Should Be Equal    ${result}    ${expected_text}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Filter_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Status Filter button second time

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Select_All_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Select All option

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Select_All_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Select All option second time

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Created_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Created option

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Elements}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Status Elements

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Status_Elements}    button=right
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to right-click Status Elements

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Reassign}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Reassign

    # Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Reassign_Input_Field    ${Convr_Reassign_Input_Field}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Convr_Reassign_Input_Field}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Convr Reassign Input Field is not visible for reassign the task'
    Fill Text    ${Convr_Reassign_Input_Field}    ${Assign_To}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Reassign_Option}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select Reassign option

    Run Keyword And Continue On Failure    Get Element States    ${Convr_Reassign_Sucess_popup}    validate    value & visible    msg=Reassign success popup should be visible

    # Run Keyword And Continue On Failure    Wait For Element With Message    Cancel_Filter_Button    ${Cancel_Filter_Button}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Cancel_Filter_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Cancel Filter Button is not visible to while Reassign the task'
    ${clicked}=    Run Keyword And Return Status    Click    ${Cancel_Filter_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Cancel Filter button

   
# verify the Effective date in Convr Task Tab 
#     [Documentation]    This method is used to verify the Effective Date In Convr Task Tab
#     ...    ${Date}    we need to pass the Date in this format "dd/mm/yyy"
#     ...    ${Date_1}    we need to pass the Date in this format "mm/dd/yyy"    
#     [Arguments]    ${ColumnNames}    ${Date}    ${Date_1}
#     Click    ${Convr_Task_tab}
#     Click All tasks option
#     Set_Page_Size    20
#     Rearrange Submission Page Columns    @{ColumnNames}
#     Click    ${Convr_EffDate_Filter_Button}
#     type Text    ${Convr_Effdate_field}    ${Date}
#     ${elements}    Get Elements    ${Convr_Effdate_Elements}
#     FOR    ${element}    IN    @{elements}
#         ${effective_Date}    Get Text    ${element}
#         Run Keyword And Continue On Failure    Should Be Equal    ${effective_Date}    ${Date_1}  
#     END    
#     # Wait For Elements State    ${Convr_Submission_tab}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Submission_tab    ${Convr_Submission_tab}    visible
#     click    ${Convr_Submission_tab}
#     # Wait For Elements State    ${Convr_Submission_tab}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Submission_tab    ${Convr_Submission_tab}    visible
verify the Effective date in Convr Task Tab
    [Documentation]    Verifies the Effective Date in Convr Task Tab.
    ...    ${Date}: input in "dd/mm/yyyy" format
    ...    ${Date_1}: expected in "mm/dd/yyyy" format
    [Arguments]    ${ColumnNames}    ${Date}    ${Date_1}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Task_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Convr Task tab

    Click All tasks option
    Run Keyword And Continue On Failure    Set_Page_Size    20
    Run Keyword And Continue On Failure    Rearrange Submission Page Columns    @{ColumnNames}

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_EffDate_Filter_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Effective Date filter button

    Run Keyword And Continue On Failure    Type Text    ${Convr_Effdate_field}    ${Date}

    ${elements}=    Get Elements    ${Convr_Effdate_Elements}
    # Run Keyword And Continue On Failure    Should Be True    ${elements}    msg=No Effective Date elements found

    FOR    ${element}    IN    @{elements}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${element}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Convr_Effdate_Elements element is not present to get a text value.

        ${effective_Date}=    Get Text    ${element}
        Run Keyword And Continue On Failure    Should Be Equal    ${effective_Date}    ${Date_1}    msg=Effective Date does not match expected
    END

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Submission_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Convr Submission tab

    # Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Submission_tab    ${Convr_Submission_tab}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Convr_Submission_tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Convr Submission tab is not visible'

# Set_Page_Size 
#     [Documentation]    This method is used to the Set the Page Size
#     ...    ${Size}    we need to give the Size value 
#     [Arguments]    ${Size}  
#     # Wait For Elements State    ${Convr_Page_Size}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Page_Size    ${Convr_Page_Size}    visible
#     Click    ${Convr_Page_Size}
#     ${element}    Catenate    SEPARATOR=    ${Convr_page_Option}    ${Size}'] 
#     Click    ${element}
Set_Page_Size
    [Documentation]    Sets the page size in Convr Task tab.
    ...    ${Size}: The page size value to select.
    [Arguments]    ${Size}  

    # Run Keyword And Continue On Failure    Wait For Element With Message    Convr_Page_Size    ${Convr_Page_Size}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Convr_Page_Size}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Convr Page Size option is not visible in all submission pag'

    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Page_Size}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click page size dropdown

    ${element}=    Catenate    SEPARATOR=    ${Convr_page_Option}    ${Size}']
    ${clicked}=    Run Keyword And Return Status    Click    ${element}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select page size option ${Size}


# Create new submission in processing
#     [Documentation]    Creates a new submission by uploading a specified file.
#     ...    This keyword handles the full UI flow for creating a submission: setting filters, rearranging columns, clicking 'New', uploading the file, and waiting for processing to complete.
#     ...
#     ...    *Arguments:*
#     ...    - `${file_name}`: The name of the file to upload from the `uploads` directory.
#     ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
#     ...
#     ...    *Returns:*
#     ...    - The ID of the newly created submission.
#     [Arguments]    ${file_name}    @{submission_column_names}
#     ${AbsolutePath}=    Normalize Path    ${path}${file_name}
#     Log    ${AbsolutePath}
#         # Select Date Filter option    Today
#         Click All submissions option
#         Rearrange Submission Page Columns    @{submission_column_names}
#         Log Step    'Creating New Submission!'
#         # Wait For Elements State    ${NewButton}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    NewButton    ${NewButton}    visible
#         Click    ${NewButton}
#         Sleep    3s
#         ${status}    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible    'SelectPage should be visible.'
#         IF    ${status}  
#         Select Options By    ${SelectPage}    text    100
#         END
#         Sleep    2s
#         # ${existingSubmissionCount1}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount1}
#         # Wait For Elements State    ${CreateSubmissionTab}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
#         Click    ${UploadSupportingDocuments}
#         # Wait For Elements State    ${BrowseFile}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
#         Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#         Sleep    2s
#         Scroll To Element    ${CreateSubmissionButton}
#         # Wait For Elements State    ${CreateSubmissionButton}    enabled
#         Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    visible
#         Click    ${CreateSubmissionButton}
#         Sleep    5s
#         # Wait For Elements State    ${Processing}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
#         # Click My submissions option
#         # Sleep    2s
#         # Click All submissions option
#         # Wait For Elements State    ${ProcessingStatus}    visible
#         #  ${existingSubmissionCount2}    Get Element Count    ${ProcessingStatusCount}
#         # Log    ${existingSubmissionCount2}
#         # IF    ${existingSubmissionCount2} == ${existingSubmissionCount1}
#         #    ${index}    Evaluate    ${existingSubmissionCount2} + 1
#         #    ${locator}    Catenate    SEPARATOR=    ${ExistingProcessingStatus}    ${index}    ]  
#         #     Wait For Elements State    ${locator}    visible
#         # END
#         # Wait For Elements State    ${ProcessingStatus}    visible    timeout=120s    
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible
#         ${retrive_submission_id}    Get Text    ${Locator_SubmissionId}
#         ${get_submission_id}    Strip String    ${retrive_submission_id}
#         # Wait For Elements State    ${ProcessingStatus}    detached    timeout=600s
#         # Wait For Elements State    ${CloseSubmissionPreview}    visible    timeout=${element_timeout}
#         # Click    ${CloseSubmissionPreview}
#         Log Step    'New Submission ID -> ${get_submission_id}'
#         RETURN    ${get_submission_id}

# Create new submission in processing
#     [Documentation]    Creates a new submission by uploading a specified file.
#     ...    Handles the full UI flow: setting filters, rearranging columns, clicking 'New', uploading the file, and waiting for processing to complete.
#     ...
#     ...    *Arguments:*
#     ...    - `${file_name}`: The name of the file to upload from the `uploads` directory.
#     ...    - `@{submission_column_names}`: Column names to configure on the submissions page.
#     ...
#     ...    *Returns:*
#     ...    - The ID of the newly created submission.
#     [Arguments]    ${file_name}    @{submission_column_names}

#     ${AbsolutePath}=    Normalize Path    ${path}${file_name}
#     Log    ${AbsolutePath}

#     Click All submissions option
#     Rearrange Submission Page Columns    @{submission_column_names}

#     Log Step    'Creating New Submission!'
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewButton    ${NewButton}    visible
#     ${clicked}=    Run Keyword And Return Status    Click    ${NewButton}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'New' button

#     Sleep    3s
#     ${status}=    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible    'SelectPage should be visible.'
#     IF    ${status}
#         Run Keyword And Continue On Failure    Select Options By    ${SelectPage}    text    100
#     END
#     Sleep    2s

#     Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionTab    ${CreateSubmissionTab}    visible
#     ${clicked}=    Run Keyword And Return Status    Click    ${UploadSupportingDocuments}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Upload Supporting Documents'

#     Run Keyword And Continue On Failure    Wait For Element With Message    BrowseFile    ${BrowseFile}    visible
#     Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#     Sleep    2s

#     Scroll To Element    ${CreateSubmissionButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    CreateSubmissionButton    ${CreateSubmissionButton}    visible
#     ${clicked}=    Run Keyword And Return Status    Click    ${CreateSubmissionButton}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Create Submission' button

#     Sleep    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Processing    ${Processing}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingStatus    ${ProcessingStatus}    visible

#     ${retrive_submission_id}=    Get Text    ${Locator_SubmissionId}
#     ${get_submission_id}=    Strip String    ${retrive_submission_id}

#     Log Step    'New Submission ID -> ${get_submission_id}'
#     RETURN    ${get_submission_id}
Create new submission in processing
    [Documentation]    Creates a new submission by uploading a specified file.
    ...    Handles the full UI flow: setting filters, rearranging columns, clicking 'New',
    ...    uploading the file, and waiting for processing to complete.
    [Arguments]    ${file_name}    @{submission_column_names}

    ${AbsolutePath}=    Normalize Path    ${path}${file_name}
    Log    ${AbsolutePath}

    Click All submissions option
    Rearrange Submission Page Columns    @{submission_column_names}

    Log Step    'Creating New Submission!'

    # Wait for New button
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='New button is not visible'
    
    ${clicked}=    Run Keyword And Return Status    Click    ${NewButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'New' button

    Sleep    3s
    ${status}=    Run Keyword And Return Status    Get Element States    ${SelectPage}    validate    value & visible
    IF    ${status}
        Run Keyword And Continue On Failure    Select Options By    ${SelectPage}    text    100
    END
    Sleep    2s

    # Create Submission Tab visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionTab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Create Submission tab not visible'

    ${clicked}=    Run Keyword And Return Status    Click    ${UploadSupportingDocuments}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Upload Supporting Documents'

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${BrowseFile}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='BrowseFile button not visible'

    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
    Sleep    2s

    Scroll To Element    ${CreateSubmissionButton}

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${CreateSubmissionButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Create Submission button not visible'

    ${clicked}=    Run Keyword And Return Status    Click    ${CreateSubmissionButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Create Submission' button

    Sleep    5s

    # Processing stage
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Processing}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Processing loader not visible'

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingStatus}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Processing status not visible'
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${Locator_SubmissionId}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=Locator_SubmissionId element is not present to get a text value.

    ${retrive_submission_id}=    Get Text    ${Locator_SubmissionId}
    ${get_submission_id}=    Strip String    ${retrive_submission_id}

    Log Step    'New Submission ID -> ${get_submission_id}'
    RETURN    ${get_submission_id}


 
# verify that the Reprocess button is not Available in Document Tab
#     [Documentation]    This method is verify the Reprocess button  not Availabe in the Document Tab
#     [Arguments]    ${DropDown_Option}  
#     Switch to Documents
#     # Wait For Elements State    ${More_Option_Sov}
#     Run Keyword And Continue On Failure    Wait For Element With Message    More_Option_Sov    ${More_Option_Sov}    visible
#     Click    ${More_Option_Sov}
#     # Wait For Elements State    ${Stop_Option}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Stop_Option    ${Stop_Option}    visible
#     Click    ${Stop_Option}
#     Get Element States    ${Asset_Stop_Popup}    validate    value & visible
#     # Wait For Elements State    ${More_Option_Sov}
#     Run Keyword And Continue On Failure    Wait For Element With Message    More_Option_Sov    ${More_Option_Sov}    visible
#     Click    ${More_Option_Sov}
#     # Wait For Elements State    ${Force_HITL}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Force_HITL    ${Force_HITL}    visible
#     Click    ${Force_HITL}
#     Get Element States    ${Forcing_HITL_popup}    validate    value & visible
#     # Wait For Elements State    ${Sov_DropDown_Option}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Sov_DropDown_Option    ${Sov_DropDown_Option}    visible
#     sleep    10s
#     Select Options By    ${Sov_DropDown_Option}    text    ${DropDown_Option}
#     Get Element States    ${reprocess_msg}    validate    value & visible
#     Get Element States    ${Bug_Reprocess_Button_Doc_Tab}    validate    value & detached
#     Get Element States    ${Bug_Reprocess_Msg_Doc_Tab}    validate    value & detached

verify that the Reprocess button is not Available in Document Tab
    [Documentation]    Verifies that the 'Reprocess' button is not available in the Document Tab.
    [Arguments]    ${DropDown_Option}  

    Switch To Documents

    ${status}=    Run Keyword And Return Status    Click    ${More_Option_Sov}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click 'More Options'

    ${status}=    Run Keyword And Return Status    Click    ${Stop_Option}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click 'Stop Option'

    Run Keyword And Continue On Failure    Get Element States    ${Asset_Stop_Popup}    validate    value & visible

    ${status}=    Run Keyword And Return Status    Click    ${More_Option_Sov}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click 'More Options' second time

    ${status}=    Run Keyword And Return Status    Click    ${Force_HITL}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click 'Force HITL'

    Run Keyword And Continue On Failure    Get Element States    ${Forcing_HITL_popup}    validate    value & visible

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Sov_DropDown_Option}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Sov dropdown option is not visible
    Sleep    10s

    ${status}=    Run Keyword And Return Status    Select Options By    ${Sov_DropDown_Option}    text    ${DropDown_Option}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to select dropdown option

    Run Keyword And Continue On Failure    Get Element States    ${reprocess_msg}    validate    value & visible
    Run Keyword And Continue On Failure    Get Element States    ${Bug_Reprocess_Button_Doc_Tab}    validate    value & detached
    Run Keyword And Continue On Failure    Get Element States    ${Bug_Reprocess_Msg_Doc_Tab}    validate    value & detached


verify the Renewal Flag is Should not Present in All Tab
    [Documentation]    This method is used to the Verify the REnewal flag is not present in All tab 
    [Arguments]    ${excepted_Value}
     Click Answers Tab
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Switch to Summary
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab
    Click and verify Clearance tab
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Tasks
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab
    Switch To Email Tab
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab
    Switch to Documents
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab
    Switch to Risk360 tab
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab
    Navigate to Form
    Verify Renewal Flag Should Not Be Present    ${excepted_Value}
    Click Answers Tab

# verify the Renewal Flag is Run Keyword And Continue On Failure    Should not Present 
#     [Documentation]    This method is used to the Verify the REnewal flag is not present 
#     [Arguments]    ${Expected_Value}
#    ${Allfields}    Get Elements    ${All_field_Side_Menu} 
#    FOR    ${counter}    IN    @{Allfields} 
#        ${fieldname}=    Get Text    ${counter}
#        Run Keyword And Continue On Failure    Should Not Match    ${Expected_Value}     ${fieldname}
#     END
# Verify Renewal Flag Should Not Be Present
#     [Documentation]    Verifies that the Renewal Flag is NOT present in the current page or section.
#     ...    Loops through all fields/elements in the side menu or given locator and ensures the flag is not displayed.
#     [Arguments]    ${Expected_Value}

#     ${all_fields}=    Get Elements    ${All_field_Side_Menu}
#     Run Keyword And Continue On Failure    Should Not Be Empty    ${all_fields}    msg=Verify Renewal Flag: No fields found in the side menu. Cannot verify the Renewal flag.

#     ${field_count}=    Get Length    ${all_fields}
#     Log To Console    Verify Renewal Flag: Total number of fields found: ${field_count}

#     FOR    ${field}    IN    @{all_fields}
#         ${field_name}=    Get Text    ${field}
#         Run Keyword And Continue On Failure    Should Not Be Empty    ${field_name}    msg=Verify Renewal Flag: Unable to get text from a side menu field element.
#         Run Keyword And Continue On Failure    Should Not Match    ${Expected_Value}    ${field_name}    msg=Verify Renewal Flag: Renewal flag '${Expected_Value}' SHOULD NOT be present in field '${field_name}', but it was found. Check the UI for incorrect display.
#         Log To Console    Verify Renewal Flag: Field '${field_name}' checked and did NOT contain Renewal flag '${Expected_Value}'.
#     END
Verify Renewal Flag Should Not Be Present
    [Documentation]    Verifies that the Renewal Flag is NOT present in the current page or section.
    ...    Loops through all fields/elements in the side menu or given locator and ensures the flag is not displayed.
    [Arguments]    ${Expected_Value}

    ${all_fields}=    Get Elements    ${All_field_Side_Menu}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${all_fields}    msg=Verify Renewal Flag: No fields found in the side menu. Cannot verify the Renewal flag.

    ${field_count}=    Get Length    ${all_fields}
    Log To Console    Verify Renewal Flag: Total number of fields found: ${field_count}

    FOR    ${field}    IN    @{all_fields}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${field}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=All_field_Side_Menu element is not present to get a text value.

        ${field_name}=    Get Text    ${field}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${field_name}    msg=Verify Renewal Flag: Unable to get text from a side menu field element.

        Run Keyword And Continue On Failure    Should Not Match    ${Expected_Value}    ${field_name}    msg=Verify Renewal Flag: Renewal flag '${Expected_Value}' SHOULD NOT be present in field '${field_name}', but it was found. Check the UI for incorrect display.

        Log To Console    Verify Renewal Flag: Field '${field_name}' checked and did NOT contain Renewal flag '${Expected_Value}'.
    END


# Select Submission using submission id Draft
#     [Documentation]    Selects a specific submission from the 'All Submissions' list by its ID.
#     ...    It configures the view, searches for the submission,Captures the score value  and then clicks on the company name to open it.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_submissionID}`: The ID of the submission to select.
#     ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
#     [Arguments]    ${data_submissionID}    @{submission_column_names}
#     Click All submissions option
#     Rearrange Submission Page Columns    @{submission_column_names}
#     Search Submission By Submission ID    ${data_submissionID}
#     # Wait For Elements State    ${Loc_ScoreValue}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_ScoreValue    ${Loc_ScoreValue}    visible
#     ${actual_Score}    Get Text    ${Loc_ScoreValue}
#     Log    'The Scorevalue shown in SubmissionPage is ${actual_Score}'

#     ${locator_company_name}    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${BalanceCompanyName})[1]
#     # Wait For Elements State    ${locator_company_name}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    locator_company_name    ${locator_company_name}    visible
#     ${locator_product_name}    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${Loc_ProductName})[1]
#     ${product}    Get Text    ${locator_product_name}
#     Click    ${locator_company_name}
#     Sleep    2s
#     ${visible}    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${element_timeout}
#     IF    ${visible}
#          Click    ${locator_company_name}
#     END
#     RETURN    ${actual_Score}
Select Submission using submission id Draft
    [Documentation]    Selects a specific submission from the 'All Submissions' list by its ID.
    ...    It configures the view, searches for the submission, captures the score value, and then clicks on the company name to open it.
    ...
    ...    *Arguments:*
    ...    - `${data_submissionID}`: The ID of the submission to select.
    ...    - `@{submission_column_names}`: A list of column names to configure on the submissions page.
    [Arguments]    ${data_submissionID}    @{submission_column_names}

    # Click All Submissions option
    Click All submissions option

    # Rearrange columns
    Rearrange Submission Page Columns    @{submission_column_names}

    # Search submission by ID
    Search Submission By Submission ID    ${data_submissionID}

    # Wait for Score element
    ${scoreVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_ScoreValue}    visible    timeout=${element_timeout}
    Should Be True    ${scoreVisible}    msg=Score value element not visible for submission ID ${data_submissionID}.

    # Capture actual score
    ${actual_Score}=    Get Text    ${Loc_ScoreValue}
    Log    The Score value shown in SubmissionPage is ${actual_Score}

    # Company name locator
    ${locator_company_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${BalanceCompanyName})[1]

    ${companyVisible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${companyVisible}    msg=Company name locator not visible for submission ID ${data_submissionID}.

    # Product name locator
    ${locator_product_name}=    Catenate    SEPARATOR=    (${CompanyName}    ${data_submissionID}    ${Loc_ProductName})[1]
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${locator_product_name}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=locator_product_name element is not present to get a text value.

    ${product}=    Get Text    ${locator_product_name}

    # Click company name to open submission
    ${clickCompany}=    Run Keyword And Return Status    Click    ${locator_company_name}
    Run Keyword And Continue On Failure    Should Be True    ${clickCompany}    msg=Failed to click on company name for submission ID ${data_submissionID}.

    Sleep    2s

    # Retry click if still visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${locator_company_name}    visible    timeout=${display_timeout}
    IF    ${visible}
        ${clickCompanyRetry}=    Run Keyword And Return Status    Click    ${locator_company_name}
        Run Keyword And Continue On Failure    Should Be True    ${clickCompanyRetry}    msg=Failed to click on company name after retry for submission ID ${data_submissionID}.
    END

    RETURN    ${actual_Score}

# Verify that Reactive details are not displayed after reloading
#     [Documentation]    This method verifies the details which we entered for reactive is not be displayed after reloading
#     Switch to Documents
#     # Wait For Elements State    ${Loc_Decline}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline    ${Loc_Decline}    visible
#     Click    ${Loc_Decline}
    
#     # Wait For Elements State    ${Loc_Decline_checkbox}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline_checkbox    ${Loc_Decline_checkbox}    visible
#     Check Checkbox    ${Loc_Decline_checkbox}

#     # Wait For Elements State    ${Loc_decline_Details}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_decline_Details    ${Loc_decline_Details}    visible
#     Fill Text    ${Loc_decline_Details}    Test

#     Click    ${Accept_Btn_Decline}

#     # Wait For Elements State    ${Reactive}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    visible
#     Click    ${Reactive}
    
#     # Wait For Elements State    ${Loc_Reactive_Details}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     Fill Text    ${Loc_Reactive_Details}    Test

#     # Wait For Elements State    ${Loc_Reactive_cancel}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_cancel    ${Loc_Reactive_cancel}    visible
#     Click    ${Loc_Reactive_cancel}

#     # Wait For Elements State    ${Loc_Reactive_cancel}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_cancel    ${Loc_Reactive_cancel}    visible
#     Click    ${Reactive}

#     # Wait For Elements State    ${Loc_Reactive_Details}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     ${Actual}    get Text    ${Loc_Reactive_Details}

#     Run Keyword And Continue On Failure    Should Be Empty    ${Actual}  
# 
# Verify that Reactive details are not displayed after reloading
#     [Documentation]    Verifies that the details entered for Reactive are not displayed after reloading.
    
#     Switch to Documents

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline    ${Loc_Decline}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${Loc_Decline}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Loc_Decline

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline_checkbox    ${Loc_Decline_checkbox}    visible
#     ${status}=    Run Keyword And Return Status    Check Checkbox    ${Loc_Decline_checkbox}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to check Loc_Decline_checkbox

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_decline_Details    ${Loc_decline_Details}    visible
#     Run Keyword And Continue On Failure    Fill Text    ${Loc_decline_Details}    Test

#     ${status}=    Run Keyword And Return Status    Click    ${Accept_Btn_Decline}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Accept_Btn_Decline

#     Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${Reactive}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Reactive

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     Run Keyword And Continue On Failure    Fill Text    ${Loc_Reactive_Details}    Test

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_cancel    ${Loc_Reactive_cancel}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${Loc_Reactive_cancel}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Loc_Reactive_cancel

#     Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${Reactive}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Reactive second time

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     ${Actual}=    Get Text    ${Loc_Reactive_Details}

#     Run Keyword And Continue On Failure    Should Be Empty    ${Actual}
Verify that Reactive details are not displayed after reloading
    [Documentation]    Verifies that the details entered for Reactive are not displayed after reloading.
    
    Switch to Documents

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Decline}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Decline button is not visible to click'
    ${status}=    Run Keyword And Return Status    Click    ${Loc_Decline}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Loc_Decline'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Decline_checkbox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Decline_checkbox is not visible to check'
    ${status}=    Run Keyword And Return Status    Check Checkbox    ${Loc_Decline_checkbox}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to check Loc_Decline_checkbox'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_decline_Details}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_decline_Details field is not visible to enter text'
    Run Keyword And Continue On Failure    Fill Text    ${Loc_decline_Details}    Test

    ${status}=    Run Keyword And Return Status    Click    ${Accept_Btn_Decline}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Accept_Btn_Decline'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Reactive button is not visible to click'
    ${status}=    Run Keyword And Return Status    Click    ${Reactive}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Reactive'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Reactive_Details}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Reactive_Details field is not visible to enter text'
    Run Keyword And Continue On Failure    Fill Text    ${Loc_Reactive_Details}    Test

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Reactive_cancel}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Reactive_cancel button is not visible to click'
    ${status}=    Run Keyword And Return Status    Click    ${Loc_Reactive_cancel}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Loc_Reactive_cancel'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Reactive button is not visible to click again'
    ${status}=    Run Keyword And Return Status    Click    ${Reactive}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Reactive second time'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Reactive_Details}    visible    timeout=${element_timeout}
    Should Be True    ${status}    'Loc_Reactive_Details is not visible to verify text'
    ${Actual}=    Get Text    ${Loc_Reactive_Details}

    Run Keyword And Continue On Failure    Should Be Empty    ${Actual}


 Verify Switching From Clearance Tab To All Other tabs
    [Documentation]    This method is used to the Verify that ,we are able to click all other tabs from clearance tab.

     Click and verify Clearance tab
     Click Answers Tab
    
    Click and verify Clearance tab
    Switch to Summary
    
    Click and verify Clearance tab
    Click Tasks
    
    Click and verify Clearance tab
    Switch To Email Tab
    
    Click and verify Clearance tab
    Switch to Documents
    Click and verify Clearance tab
    Switch to Risk360 tab
    Click and verify Clearance tab
    Navigate to Form
    
# Verify datas in Underwriter Reference file
#     [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
#     ...    It compares a list of expected text values with the actual values found in the document.
#     ...
#     ...    *Arguments:*
#     ...    - `${expectedText}`: A list of strings with the expected values.
#     [Arguments]    ${expectedText}
#     Switch to Documents
#     # Wait For Elements State    ${Document_options}    visible 
#     Run Keyword And Continue On Failure    Wait For Element With Message    Document_options    ${Document_options}    visible
#     Click    ${Document_options}
#     Click    ${Show_Documents}
#     Scroll To Element    ${underwriter_reference_Doc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    underwriter_reference_Doc    ${underwriter_reference_Doc}    visible
#     # Wait For Elements State    ${underwriter_reference_Doc}    visible    timeout=${element_timeout}
#     Click    ${underwriter_reference_Doc}
#     @{variables}    Get Elements    ${UserModificationVariable}
#     @{values}    Get Elements    ${UserModificationValue}
#     @{actualText}    Create List    
#     FOR    ${value}    IN    @{values}
#         ${text}    Get Text    ${value}
#         ${trimValue}    Strip String    ${text}
#         ${Text_Value}=    Replace String    ${trimValue}    "    ${EMPTY}
#         Append To List    ${actualText}    ${Text_Value}
#     END
#     Log    ${expectedText}
#     Log    ${actualText}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}
Verify datas in Underwriter Reference file
    [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
    ...    It compares a list of expected text values with the actual values found in the document.
    [Arguments]    ${expectedText}

    Switch to Documents

    # Run Keyword And Continue On Failure    Wait For Element With Message    Document_options    ${Document_options}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Document_options}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Document_options is not visible to proceed'
    ${status}=    Run Keyword And Return Status    Click    ${Document_options}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Document_options

    ${status}=    Run Keyword And Return Status    Click    ${Show_Documents}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Show_Documents

    Scroll To Element    ${underwriter_reference_Doc}
    # Run Keyword And Continue On Failure    Wait For Element With Message    underwriter_reference_Doc    ${underwriter_reference_Doc}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${underwriter_reference_Doc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'underwriter_reference_Doc is not visible to proceed'
    ${status}=    Run Keyword And Return Status    Click    ${underwriter_reference_Doc}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click underwriter_reference_Doc

    @{variables}=    Get Elements    ${UserModificationVariable}
    @{values}=    Get Elements    ${UserModificationValue}
    @{actualText}=    Create List

    FOR    ${value}    IN    @{values}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${value}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=UserModificationValue element is not present to get a text value.

        ${text}=    Get Text    ${value}
        ${trimValue}=    Strip String    ${text}
        ${Text_Value}=    Replace String    ${trimValue}    "    ${EMPTY}
        Append To List    ${actualText}    ${Text_Value}
    END

    Log    ${expectedText}
    Log    ${actualText}

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}    msg=UserModification values in Underwriter Reference file do not match the expected values

Verify the Eml data in processing tab
    [Documentation]    Fills in the Underwriter and Operations contact information in the 'Processing' tab.
    ...
    ...    *Arguments:*
    ...    - `${Expected_Value}`: The Expected value .
    [Arguments]    ${Expected_Value}   
    ${Actual_Value}    Create List
    # Wait For Elements State    ${UnderwriterName}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Wait For Element With Message    UnderwriterName    ${UnderwriterName}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${underwriter_reference_Doc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'underwriter_reference_Doc is not visible to proceed'
    ${Actual_UnderwriterName}    Get Text    ${UnderwriterName}
    Append To List    ${Actual_Value}    ${Actual_UnderwriterName}
    Get Element States    ${UnderwriterEmail}    validate    value & visible    'UnderwriterEmail should be visible.'
    ${Actual_UnderwriterEmail}    Get Text    ${UnderwriterEmail}
    Append To List    ${Actual_Value}    ${Actual_UnderwriterEmail}
    Get Element States    ${UnderwrittingOffice}    validate    value & visible    'UnderwrittingOffice should be visible.'
    ${Actual_UnderwrittingOffice}    Get Text    ${UnderwrittingOffice}
    Append To List    ${Actual_Value}    ${Actual_UnderwrittingOffice}
    Get Element States    ${OperationsName}    validate    value & visible    'OperationsName should be visible.'
    ${Actual_OperationsName}    Get Text    ${OperationsName}
    Append To List    ${Actual_Value}    ${Actual_OperationsName}
    Get Element States    ${OperationsEmail}    validate    value & visible    'OperationsEmail should be visible.'
    ${Actual_OperationsEmail}    Get Text    ${OperationsEmail}
    Append To List    ${Actual_Value}    ${Actual_OperationsEmail}
    Get Element States    ${Channel}    validate    value & visible    'Channel should be visible.'
    ${Actual_Channel}    Get Text    ${Channel}
    Append To List    ${Actual_Value}    ${Actual_Channel}
    Get Element States    ${Rep_Office}    validate    value & visible    'Rep Office should be visible.'
    ${Actual_Repoffice}    Get Text    ${Rep_Office}
    Append To List    ${Actual_Value}    ${Actual_Repoffice}
    ${Actual_Direct_Assumed}    Get Text    ${Direct_Assumed}
    Append To List    ${Actual_Value}    ${Actual_Direct_Assumed}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Expected_Value}    ${Actual_Value}
Verify Eml Data in Producer Tab
    [Documentation]    Verifies that the text of specific fields in the 'Producer' tab matches the expected data.
    ...    The fields checked are hardcoded within the keyword.
    ...
    ...    *Arguments:*
    ...    - `@{ExpectedPDFText}`: A list of strings containing the expected text for each verified field.
    [Arguments]    ${ExpectedPDFText}
    @{locators}     Create List    ${Agency}    ${ProducerName}    ${ProducerEmailButton}    
    @{ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        Scroll To Element    ${locator}
        ${text}    Get Text    ${locator}
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}

Verify EML PDF Data in Producer Tab
    [Documentation]    Verifies that the text of specific fields in the 'Producer' tab matches the expected data.
    ...    The fields checked are hardcoded within the keyword.
    ...
    ...    *Arguments:*
    ...    - `${ExpectedPDFText}`: A list of strings containing the expected text for each verified field.
    [Arguments]    ${ExpectedPDFText}
    @{locators}     Create List    ${Agency}    ${ProducerName}    ${ProducerAddress}    ${ProducerAddressStreet}    ${ProducerAddress2}    ${ProducerAddressCity}    ${ProducerAddressState}    ${ProducerPostalCode}    ${ProducerCountry}    ${ProducerCodeButton}    ${ProducerEmailButton}    ${Producer_Phone_number}
    @{ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        Scroll To Element    ${locator}
        ${text}    Get Text    ${locator}
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}    
 
Verify EML Data the Coverage Tab
    [Documentation]    Verifies the effective date, expiration date, and product type in the 'Coverage' tab.
    ...
    ...    *Arguments:*
    ...    - `${data_expected_eff_date}`: The expected effective date.
    ...    - `${data_expected_expiry_date}`: The expected expiration date.
    ...    - `${data_expected_product}`: The expected product type.
    ...    ${Property_Segment_value}`: The expected product segment type.
    ...    ${Facultative_Reinsurance}`: The expected Facultative Reinsurance type.
        [Arguments]    ${data_expected_eff_date}    ${data_expected_expiry_date}    ${data_expected_product}    ${Property_Segment_value}    ${Facultative_Reinsurance}    
    #  Wait For Elements State    ${EffectiveDate}    visible    timeout=${element_timeout}
    #  Run Keyword And Continue On Failure    Wait For Element With Message    EffectiveDate    ${EffectiveDate}    visible
     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${underwriter_reference_Doc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'underwriter_reference_Doc is not visible to proceed'
     ${actualEffectiveDate}    Get Text    ${EffectiveDate}
     ${trimEffectiveDate}    Strip String    ${actualEffectiveDate}
     Run Keyword And Continue On Failure    Should Be Equal    ${data_expected_eff_date}    ${trimEffectiveDate}
     ${actualExpirationDate}    Get Text    ${ExpirationDate}
     ${trimExpirationDate}    Strip String    ${actualExpirationDate}
     Run Keyword And Continue On Failure    Should Be Equal    ${data_expected_expiry_date}    ${trimExpirationDate}  
     ${Product_Name}    Get Text    ${CoverageProductButton}  
     Run Keyword And Continue On Failure    Should Be Equal    ${data_expected_product}    ${Product_Name}
     ${Product_Segment_Name}    Get Text    ${Clearance_Product_Segment}  
     Run Keyword And Continue On Failure    Should Be Equal    ${Property_Segment_value}    ${Product_Segment_Name}  
     ${Facultative_Reinsurance_Name}    Get Text    ${Facultative_Reinsurance_loc}  
     Run Keyword And Continue On Failure    Should Be Equal    ${Facultative_Reinsurance}    ${Facultative_Reinsurance_Name}

# Verify datas in UserModification files
#     [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
#     ...    It compares a list of expected text values with the actual values found in the document.
#     ...    *Arguments:*
#     ...    - `@{expectedText}` : A list of strings with the expected values.
#     ...    - `@{UserExpected}` : Another list of strings with expected values.
#     [Arguments]    ${expectedText}    ${UserExpected}
 
#     ${Elements}    Get Elements    ${UserModification}
#     ${Length}    Get Length    ${Elements}
#     FOR    ${index}    IN RANGE    0    ${Length}
#         ${element}    Get From List    ${Elements}    ${index}
#         Scroll To Element    ${element}
#         # Wait For Elements State    ${element}    visible    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    element    ${element}    visible
#         Click    ${element}
#         @{values}       Get Elements    ${UserModificationValue}
#         @{actualText}   Create List
#         FOR    ${value}    IN    @{values}
#             ${text}    Get Text    ${value}
#             ${trimValue}    Strip String    ${text}
#             Append To List    ${actualText}    ${trimValue}
#         END
#             Log    'The actual value in User modification file is @{actualText}'
#         IF    ${index} == 0
#             Log    'Comparing first iteration against expectedText list is ${expectedText}'
#             Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}
#         ELSE
#             Log    'Comparing Next iteration against expectedText list is ${UserExpected}'
#             Run Keyword And Continue On Failure    Lists Should Be Equal    ${UserExpected}    ${actualText}
#         END
#         Switch To Documents
#     END
Verify datas in UserModification files
    [Documentation]    Verifies the contents of the 'UserModification' file in the 'Documents' section.
    ...    It compares a list of expected text values with the actual values found in the document.
    [Arguments]    ${expectedText}    ${UserExpected}
 
    ${Elements}=    Get Elements    ${UserModification}
    ${Length}=      Get Length      ${Elements}
    
    FOR    ${index}    IN RANGE    0    ${Length}
        ${element}=    Get From List    ${Elements}    ${index}
        Scroll To Element    ${element}
        # Run Keyword And Continue On Failure    Wait For Element With Message    element    ${element}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'element - '${element}' is not visible to proceed'
        ${click_status}=    Run Keyword And Return Status    Click    ${element}
        Run Keyword And Continue On Failure    Should Be True    ${click_status}    msg=Failed to click UserModification element at index ${index}

        @{values}=       Get Elements    ${UserModificationValue}
        @{actualText}=   Create List

        FOR    ${value}    IN    @{values}
            ${text}=       Get Text    ${value}
            ${trimValue}=  Strip String    ${text}
            Append To List    ${actualText}    ${trimValue}
        END

        Log    The actual value in User modification file is @{actualText}

        IF    ${index} == 0
            Log    Comparing first iteration against expectedText list: ${expectedText}
            Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${actualText}    msg=UserModification first iteration values do not match expectedText
        ELSE
            Log    Comparing next iteration against UserExpected list: ${UserExpected}
            Run Keyword And Continue On Failure    Lists Should Be Equal    ${UserExpected}    ${actualText}    msg=UserModification values at iteration ${index} do not match UserExpected
        END

        Switch To Documents
    END


# verify email composer attachement is not presnt 
#     [Documentation]    This method is used to the Verify the email composer attachement is not present for msig clients
#     [Arguments]    ${user_name}
#     Click    ${Clients_button}
#     Fill Text    ${Search_clients}    ${user_name}
#     Click    ${Client_field}
#     Run Keyword And Continue On Failure    Wait For Elements State    ${Email_composer_attachement}    detached   
#     Run Keyword And Continue On Failure    Wait For Elements State    ${Email_conmposer_submmion_attachement}    detached    
#     Click    ${User_Button}
verify email composer attachement is not presnt
    [Documentation]    Verifies that the email composer attachment is not present for MSIG clients.
    [Arguments]    ${user_name}

    ${click_clients}=    Run Keyword And Return Status    Click    ${Clients_button}
    Run Keyword And Continue On Failure    Should Be True    ${click_clients}    msg=Failed to click Clients button

    Fill Text    ${Search_clients}    ${user_name}

    ${click_client_field}=    Run Keyword And Return Status    Click    ${Client_field}
    Run Keyword And Continue On Failure    Should Be True    ${click_client_field}    msg=Failed to click client field for user ${user_name}

    Run Keyword And Continue On Failure    Wait For Elements State    ${Email_composer_attachement}    detached    msg=Email composer attachment should not be present
    Run Keyword And Continue On Failure    Wait For Elements State    ${Email_conmposer_submmion_attachement}    detached    msg=Email composer submission attachment should not be present

    ${click_user_btn}=    Run Keyword And Return Status    Click    ${User_Button}
    Run Keyword And Continue On Failure    Should Be True    ${click_user_btn}    msg=Failed to click User button

# Verify Clearance Data in Insured Tab
#     [Documentation]    Verifies that the text of specific fields in the 'Insured' tab matches the expected data.
#     ...    The fields checked are matched by index to the expected values.
#     ...    *Arguments:*
#     ...    - ${ExpectedPDFText}: A list of strings containing the expected text for each verified field.
#     [Arguments]    ${ExpectedPDFText}
#     ${ActualPDFText}    Create List
#     ${InsuredTabDetails}    Get Elements    ${InsuredTabFields}
#     ${count}    Get Length    ${InsuredTabDetails}
#     FOR    ${index}    IN RANGE    ${count}
#         ${locator}    Get From List    ${InsuredTabDetails}    ${index}
#         Scroll To Element    ${locator}
#         ${text}    Get Attribute    ${locator}    value
#         ${trimText}    Strip String    ${text}
#         Append To List    ${ActualPDFText}    ${trimText}
#     END
#     Log    Expected: ${ExpectedPDFText}
#     Log    Actual:   ${ActualPDFText}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}

# Verify Clearance Data in Insured Tab
#     [Documentation]    Verifies that the text of specific fields in the 'Insured' tab matches the expected data.
#     [Arguments]    ${ExpectedPDFText}
#     ${ActualPDFText}    Create List
#     ${InsuredTabDetails}    Get Elements    ${InsuredTabFields}
#     ${count}    Get Length    ${ExpectedPDFText}
#     FOR    ${index}    IN RANGE    ${count}
#         ${locator}    Get From List    ${InsuredTabDetails}    ${index}
#         Scroll To Element    ${locator}
#         ${text}    Get Attribute    ${locator}    value
#         ${trimText}    Strip String    ${text}
#         Append To List    ${ActualPDFText}    ${trimText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}
Verify Clearance Data in Insured Tab
    [Documentation]    Verifies that the text of specific fields in the 'Insured' tab matches the expected data.
    [Arguments]    ${ExpectedPDFText}

    ${ActualPDFText}=    Create List

    # Get all fields in Insured tab
    ${InsuredTabDetails}=    Get Elements    ${InsuredTabFields}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${InsuredTabDetails}    msg=Verify Clearance Data: No fields found in the Insured tab. Locator: ${InsuredTabFields}

    ${count}=    Get Length    ${ExpectedPDFText}
    Run Keyword And Continue On Failure    Should Be True    ${count} > 0    msg=Verify Clearance Data: Expected data list is empty. Cannot verify Insured tab fields.

    FOR    ${index}    IN RANGE    ${count}
        ${locator}=    Get From List    ${InsuredTabDetails}    ${index}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${locator}    msg=Verify Clearance Data: Could not get element at index ${index} from Insured tab fields.

        Scroll To Element    ${locator}

        ${text}=    Get Attribute    ${locator}    value
        # Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Clearance Data: Failed to get text from Insured tab field at index ${index}.

        ${trimText}=    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END

    # Verify all values match expected
    # ${match}=    Run Keyword And Return Status    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}
    # Run Keyword And Continue On Failure    Should Be True    ${match}    msg=Verify Clearance Data: Insured tab field values do not match expected. Actual: ${ActualPDFText}, Expected: ${ExpectedPDFText}
    ${length}=    Get Length    ${ExpectedPDFText}
    FOR    ${index}    IN RANGE    ${length}
        ${expected}=    Get From List    ${ExpectedPDFText}    ${index}
        ${actual}=      Get From List    ${ActualPDFText}      ${index}
        ${match}=       Run Keyword And Return Status    Should Be Equal As Strings    ${expected}    ${actual}
        Run Keyword And Continue On Failure    Should Be True    ${match}    msg=Verify Clearance Data: Insured tab field values do not match expected. Mismatch at index ${index}. Expected: '${expected}', Actual: '${actual}'
    END

# Verify Clearance Data in Processing Tab
#     [Documentation]    Verifies the Decline button works successfully without any issues.
#     [Arguments]    ${Data}
#     ${Underwriter}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriter    ${Loc_PIF_Process_Detail2}
#     Click    ${Underwriter}
#     # Wait For Elements State    ${NameSearchFiled}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NameSearchFiled    ${NameSearchFiled}    visible
#     Fill Text    ${NameSearchFiled}    ${Data['UnderwriterName']}
#     ${ExistingUnderwriter}    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['UnderwriterName']}    ']
#     ${status}    Run Keyword And Ignore Error    Wait For Elements State    ${ExistingUnderwriter}    visible    10s
#     Run Keyword If    '${status}[0]' == 'PASS'    Click    ${ExistingUnderwriter}
#     # If not visible, click the new one
#     ${NewUnderwriter}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwriterName']}    ']
#     Run Keyword If    '${status}[0]' == 'FAIL'    Click    ${NewUnderwriter}
#     ${Underwriteremail}    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Underwriter Email    ${Loc_PIF_InsuredDetails2}
#     Fill Text    ${Underwriteremail}    ${Data['UnderwriterEmail']}
#     ${UnderwriterOffice}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriting Office    ${Loc_PIF_Process_Detail2}
#     Click    ${UnderwriterOffice}
#     ${SelectUnderwrittingOffice}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwrittingOffice']}    ']
#     # Wait For Elements State    ${SelectUnderwrittingOffice}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SelectUnderwrittingOffice    ${SelectUnderwrittingOffice}    visible
#     Click    ${SelectUnderwrittingOffice}

#     ${OperationsName}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Operations Name    ${Loc_PIF_Process_Detail2}
#     Click    ${OperationsName}
#     # Wait For Elements State    ${NameSearchFiled}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NameSearchFiled    ${NameSearchFiled}    visible
#     Fill Text    ${NameSearchFiled}    ${Data['OperationsName']}
#     ${ExistingUnderwriter}    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['OperationsName']}    ']
#     ${status}    Run Keyword And Ignore Error    Wait For Elements State    ${ExistingUnderwriter}    visible    10s
#     Run Keyword If    '${status}[0]' == 'PASS'    Click    ${ExistingUnderwriter}
#     # ...    ELSE    Log    Underwriter not found, selecting new underwriter
#     ${NewUnderwriter}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['OperationsName']}    ']
#     Run Keyword If    '${status}[0]' == 'FAIL'    Click    ${NewUnderwriter}
#     ${Operations_Email}    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Operations Email    ${Loc_PIF_InsuredDetails2}
#     Fill Text    ${Operations_Email}    ${Data['OperationsEmail']}
    
#     ${RepOffice}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Rep Office    ${Loc_PIF_Process_Detail2}
#     Click    ${RepOffice}
#     ${SelectRepOffice}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['RepOffice']}    ']
#     # Wait For Elements State    ${SelectRepOffice}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SelectRepOffice    ${SelectRepOffice}    visible
#     Click    ${SelectRepOffice}
#     ${Rep_Email}    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Rep Email    ${Loc_PIF_InsuredDetails2}
#     Fill Text    ${Rep_Email}    ${Data['RepEmail']}

#     ${Channel}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Channel    ${Loc_PIF_Process_Detail2}
#     Click    ${Channel}
#     ${SelectChannel}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['Channel']}    ']
#     # Wait For Elements State    ${SelectChannel}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SelectChannel    ${SelectChannel}    visible
#     Click    ${SelectChannel}

#     ${SubChannel}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Sub Channel    ${Loc_PIF_Process_Detail2}
#     Click    ${SubChannel}
#     ${SelectSubChannel}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['SubChannelValue']}    ']
#     # Wait For Elements State    ${SelectSubChannel}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SelectSubChannel    ${SelectSubChannel}    visible
#     Click    ${SelectSubChannel}

#     ${DirectorAssumed}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Direct or Assumed    ${Loc_PIF_Process_Detail2}
#     Click    ${DirectorAssumed}
#     ${SelectDirectorAssumed}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['DirectorAssumedValue']}    ']
#     # Wait For Elements State    ${SelectDirectorAssumed}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SelectDirectorAssumed    ${SelectDirectorAssumed}    visible
#     Click    ${SelectDirectorAssumed}
Verify Clearance Data in Processing Tab
    [Documentation]    Verifies the Decline button works successfully without any issues.
    [Arguments]    ${Data}

    ${Underwriter}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriter    ${Loc_PIF_Process_Detail2}
    ${clicked_underwriter}=    Run Keyword And Return Status    Click    ${Underwriter}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_underwriter}    msg=Processing Tab: Failed to click 'Underwriter' field. Ensure it is visible.

    ${name_search_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NameSearchFiled}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${name_search_visible}    msg=Processing Tab: Name search field is not visible after clicking 'Underwriter'.

    Fill Text    ${NameSearchFiled}    ${Data['UnderwriterName']}
    # ${text_filled}=    Run Keyword And Return Status    Get Attribute    ${NameSearchFiled}    value
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${text_filled}    msg=Processing Tab: Failed to enter Underwriter name '${Data['UnderwriterName']}'.

    ${ExistingUnderwriter}=    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['UnderwriterName']}    ']
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ExistingUnderwriter}    visible    10s
    IF    '${status}' == 'True'
        ${clicked_existing}=    Run Keyword And Return Status    Click    ${ExistingUnderwriter}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_existing}    msg=Processing Tab: Failed to select existing Underwriter '${Data['UnderwriterName']}'.
    ELSE  
        ${NewUnderwriter}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwriterName']}    ']
        ${clicked_new}=    Run Keyword And Return Status    Click    ${NewUnderwriter}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new}    msg=Processing Tab: Failed to select new Underwriter '${Data['UnderwriterName']}'.
    END
    Sleep    2s
    ${Underwriteremail}=    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Underwriter Email    ${Loc_PIF_InsuredDetails2}
    Fill Text    ${Underwriteremail}    ${Data['UnderwriterEmail']}
    # ${email_filled}=    Run Keyword And Return Status    Get Attribute    ${Underwriteremail}    valuse
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${email_filled}    msg=Processing Tab: Failed to enter Underwriter Email '${Data['UnderwriterEmail']}'.

    ${UnderwriterOffice}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriting Office    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${UnderwriterOffice}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select UnderwriterOffice '${Data['UnderwrittingOffice']}'.

    ${SelectUnderwrittingOffice}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwrittingOffice']}    ']
    ${office_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectUnderwrittingOffice}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${office_visible}    msg=Processing Tab: Underwriting Office '${Data['UnderwrittingOffice']}' is not visible.
    ${Status}=    Run Keyword And Return Status    Click    ${SelectUnderwrittingOffice}
     Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select UnderwriterOffice .

    ${OperationsName}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Operations Name    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${OperationsName}
     Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select OperationsName 

    ${ops_search_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NameSearchFiled}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${ops_search_visible}    msg=Processing Tab: Operations Name search field not visible.
    Fill Text    ${NameSearchFiled}    ${Data['OperationsName']}

    ${ExistingOperations}=    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['OperationsName']}    ']
    ${status_ops}=    Run Keyword And Return Status    Wait For Elements State    ${ExistingOperations}    visible    10s
    IF    '${status_ops}' == 'True'
        ${clicked_existing_ops}=    Run Keyword And Return Status    Click    ${ExistingOperations}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_existing_ops}    msg=Processing Tab: Failed to select existing Operations Name '${Data['OperationsName']}'.
    ELSE
        ${NewOperations}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['OperationsName']}    ']
        ${clicked_new_ops}=    Run Keyword And Return Status    Click    ${NewOperations}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new_ops}    msg=Processing Tab: Failed to select new Operations Name '${Data['OperationsName']}'.
    END
    Sleep    2s
    ${Operations_Email}=    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Operations Email    ${Loc_PIF_InsuredDetails2}
    Fill Text    ${Operations_Email}    ${Data['OperationsEmail']}
    # ${email_ops_filled}=    Run Keyword And Return Status    Get Attribute    ${Operations_Email}    value
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${email_ops_filled}    msg=Processing Tab: Failed to enter Operations Email '${Data['OperationsEmail']}'.

    ${RepOffice}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Rep Office    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${RepOffice}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select RepOffice
    
    ${SelectRepOffice}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['RepOffice']}    ']
    ${rep_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectRepOffice}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${rep_visible}    msg=Processing Tab: Rep Office '${Data['RepOffice']}' is not visible.
    ${Status}=    Run Keyword And Return Status    Click    ${SelectRepOffice}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select RepOffice
    ${Rep_Email}=    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    Rep Email    ${Loc_PIF_InsuredDetails2}
    Fill Text    ${Rep_Email}    ${Data['RepEmail']}
    # ${rep_email_filled}=    Run Keyword And Return Status    Get Attribute    ${Rep_Email}    value
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${rep_email_filled}    msg=Processing Tab: Failed to enter Rep Email '${Data['RepEmail']}'.

    ${Channel}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Channel    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${Channel}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select Channel
    ${SelectChannel}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['Channel']}    ']
    ${channel_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectChannel}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${channel_visible}    msg=Processing Tab: Channel '${Data['Channel']}' is not visible.
    ${Status}=    Run Keyword And Return Status    Click    ${SelectChannel}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select Channel

    ${SubChannel}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Sub Channel    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${SubChannel}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select SubChannel
    ${SelectSubChannel}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['SubChannelValue']}    ']
    ${sub_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectSubChannel}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${sub_visible}    msg=Processing Tab: Sub Channel '${Data['SubChannelValue']}' is not visible.
    ${Status}=    Run Keyword And Return Status    Click    ${SelectSubChannel}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select SubChannel

    ${DirectorAssumed}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Direct or Assumed    ${Loc_PIF_Process_Detail2}
    ${Status}=    Run Keyword And Return Status    Click    ${DirectorAssumed}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select DirectorAssumed
    ${SelectDirectorAssumed}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['DirectorAssumedValue']}    ']
    ${director_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SelectDirectorAssumed}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${director_visible}    msg=Processing Tab: Director/Assumed '${Data['DirectorAssumedValue']}' is not visible.
    ${Status}=    Run Keyword And Return Status    Click    ${SelectDirectorAssumed}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Processing Tab: Failed to select DirectorAssumed

# Verify Clearance Data in Producer Tab
#     [Documentation]    Verifies the Decline button works successfully without any issues.
#     [Arguments]    ${ExpectedPDFText}    ${ProducerNameData}=''    ${ProducerEmailData}=''
#     @{locators}     Create List    Agency Name    Producer Code    Address    Address 1    Address 2    City    State    Zip    Country
#     @{ActualPDFText}    Create List
#     FOR    ${locator}    IN    @{locators}
#         ${ProducerData}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    ${locator}    ${Loc_PIF_InsuredDetails2}
#         Scroll To Element    ${ProducerData}
#         ${text}    Get Attribute    ${ProducerData}    value
#         ${trimText}    Strip String    ${text}
#         Append To List    ${ActualPDFText}    ${trimText}
#     END
#     Log    ${ExpectedPDFText}
#     Log    ${ActualPDFText}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}
#     IF    "${ProducerNameData} != ''"
#         ${ProducerName}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Producer Name    ${Loc_PIF_InsuredDetails2}
#         Fill Text    ${ProducerName}    ${ProducerNameData}
#     END
#     IF    "${ProducerEmailData} != ''"
#         ${ProducerEmail}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Email    ${Loc_PIF_InsuredDetails2}
#         Fill Text    ${ProducerEmail}    ${ProducerEmailData}
#     END
Verify Clearance Data in Producer Tab
    [Documentation]    Verifies the Clearance Producer tab fields and allows updating Producer Name/Email.
    [Arguments]    ${ExpectedPDFText}    ${ProducerNameData}=''    ${ProducerEmailData}=''

    @{locators}=    Create List    Agency Name    Producer Code    Address    Address 1    Address 2    City    State    Zip    Country
    @{ActualPDFText}=    Create List

    FOR    ${locator}    IN    @{locators}
        ${ProducerData}=    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    ${locator}    ${Loc_PIF_InsuredDetails2}
        ${scrolled}=    Run Keyword And Return Status    Scroll To Element    ${ProducerData}
        Run Keyword And Continue On Failure    Should Be True    ${scrolled}    msg=Producer Tab: Failed to scroll to '${locator}' field.

        ${text}=    Get Attribute    ${ProducerData}    value
        # Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Producer Tab: Failed to get text from '${locator}' field.

        ${trimText}=    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END

    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}    msg=Producer Tab: Clearance data does not match expected values.

    IF    "${ProducerNameData} != ''"
        ${ProducerName}=    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Producer Name    ${Loc_PIF_InsuredDetails2}
        ${filled_name}=    Run Keyword And Return Status    Fill Text    ${ProducerName}    ${ProducerNameData}
        Run Keyword And Continue On Failure    Should Be True    ${filled_name}    msg=Producer Tab: Failed to fill Producer Name '${ProducerNameData}'.
    END

    IF    "${ProducerEmailData} != ''"
        ${ProducerEmail}=    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Email    ${Loc_PIF_InsuredDetails2}
        ${filled_email}=    Run Keyword And Return Status    Fill Text    ${ProducerEmail}    ${ProducerEmailData}
        Run Keyword And Continue On Failure    Should Be True    ${filled_email}    msg=Producer Tab: Failed to fill Producer Email '${ProducerEmailData}'.
    END

Verify Clearance Data in Producer Tab 11420Corp
    [Documentation]    Verifies the Decline button works successfully without any issues.
    [Arguments]    ${ExpectedPDFText}    ${ProducerNameData}    ${ProducerEmailData}    ${ProducerCodeData}
    @{locators}     Create List    Agency Name    Address    Address 1    Address 2    City    State    Zip    Country
    @{ActualPDFText}    Create List
    FOR    ${locator}    IN    @{locators}
        ${ProducerData}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    ${locator}    ${Loc_PIF_InsuredDetails2}
        Scroll To Element    ${ProducerData}
        ${text}    Get Attribute    ${ProducerData}    value
        ${trimText}    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END
    Log    ${ExpectedPDFText}
    Log    ${ActualPDFText}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}
    IF    "${ProducerNameData} != ''"
        ${ProducerName}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Producer Name    ${Loc_PIF_InsuredDetails2}
        Fill Text    ${ProducerName}    ${ProducerNameData}
    END
    ${ProducerName}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Producer Code    ${Loc_PIF_InsuredDetails2}
        Fill Text    ${ProducerName}    ${ProducerCodeData}
    IF    "${ProducerEmailData} != ''"
        ${ProducerEmail}    Catenate    SEPARATOR=    ${ClearanceProducerDetails1}    Email    ${Loc_PIF_InsuredDetails2}
        Fill Text    ${ProducerEmail}    ${ProducerEmailData}
    END

# Verify Clearance Data in Coverage Tab
#     [Arguments]    ${data}
#         Click    ${CoverageProduct}
#         ${value}    Catenate    SEPARATOR=    ${SelectNewValue}    ${data['Product']}    ']
#         # Wait For Elements State    ${value}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    value    ${value}    visible
#         Click    ${value}
#         Press Keys    ${CoverageProduct}    Escape
#         ${text}    Get Text    ${ProductSegmentValue}
#         ${trimText}    Strip String    ${text}
#         Run Keyword And Continue On Failure    Should Be Equal    ${data['ProductSegment']}    ${trimText}
Verify Clearance Data in Coverage Tab
    [Arguments]    ${data}

    ${clicked}=    Run Keyword And Return Status    Click    ${CoverageProduct}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Coverage Tab: Failed to click Coverage Product dropdown.

    ${value}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${data['Product']}    ']
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage Tab: Product '${data['Product']}' is not visible in the dropdown.

    ${clicked_value}=    Run Keyword And Return Status    Click    ${value}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_value}    msg=Coverage Tab: Failed to select product '${data['Product']}' from the dropdown.

    ${escaped}=    Run Keyword And Return Status    Press Keys    ${CoverageProduct}    Escape
    Run Keyword And Continue On Failure    Should Be True    ${escaped}    msg=Coverage Tab: Failed to send Escape key to Coverage Product dropdown.
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ProductSegmentValue}    visible    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Coverage Tab: Product '${ProductSegmentValue}' is not visible in the 

    ${text}=    Get Text    ${ProductSegmentValue}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Coverage Tab: Failed to get text from Product Segment field.

    ${trimText}=    Strip String    ${text}

    Run Keyword And Continue On Failure    Should Be Equal    ${data['ProductSegment']}    ${trimText}    msg=Coverage Tab: Product Segment value '${trimText}' does not match expected '${data['ProductSegment']}'.
    
# Complete CLearance and Verify Popup
#     [Arguments]    ${data}
#     Scroll To Element    ${ClearanceCompleteButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearanceCompleteButton    ${ClearanceCompleteButton}    visible    wait for clearance complete buttton 
#     Click    ${ClearanceCompleteButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClearanceSavedPopup    ${ClearanceSavedPopup}    visible    Wait for clearance saved popup to verify that the Clearance is completed 
#     ${text}    Get Text    ${ClearanceSavedPopup}
#     ${trimText}    Strip String    ${text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${data['ClearanceSavedPopupText']}    ${trimText}
Complete Clearance and Verify Popup
    [Arguments]    ${data}

    Scroll To Element    ${ClearanceCompleteButton}
    
    ${button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceCompleteButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${button_visible}    msg=Clearance: 'Clearance Complete' button is not visible on the page. Cannot proceed.

    ${clicked}=    Run Keyword And Return Status    Click    ${ClearanceCompleteButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Clearance: Failed to click 'Clearance Complete' button.

    ${popup_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceSavedPopup}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${popup_visible}    msg=Clearance: 'Clearance Saved' popup did not appear after clicking 'Clearance Complete'.
    
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ClearanceSavedPopup}    visible    timeout=${element_timeout}
    Should Be True    ${visible}    msg=Coverage Tab: Clearance Saved Popup is not visible in the Clearance Tab.

    ${text}=    Get Text    ${ClearanceSavedPopup}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Clearance: Failed to get text from 'Clearance Saved' popup.

    ${trimText}=    Strip String    ${text}

    Should Be Equal    ${data['ClearanceSavedPopupText']}    ${trimText}    msg=Clearance Tab: Try to save the clearance in Stage-1 - Actual Popup text '${trimText}' does not match expected '${data['ClearanceSavedPopupText']}'.

# Enter their Clearance SIC and NAIC Code
#     [Arguments]    ${SicData}    ${NiacData}
#     ${SICCodes}    Get Elements    ${SicCodeInputFileds}    
#     ${count}    Get Length    ${SicData}
#     FOR    ${index}    IN RANGE    ${count}
#         ${locator}    Get From List    ${SICCodes}    ${index}
#         ${data}    Get From List    ${SicData}    ${index}
#         Scroll To Element    ${locator}
#         Fill Text    ${locator}    ${data}
#     END
#     ${NAICCodes}    Get Elements    ${NAICSCodeInputFileds}    
#     ${count}    Get Length    ${NiacData}
#     FOR    ${index}    IN RANGE    ${count}
#         ${locator}    Get From List    ${NAICCodes}    ${index}
#         ${data}    Get From List    ${NiacData}    ${index}
#         Scroll To Element    ${locator}
#         Fill Text    ${locator}    ${data}
#     END

Enter their Clearance SIC and NAIC Code
    [Documentation]    Enters the SIC and NAIC codes into their respective input fields.
    ...    Uses the provided data lists to fill values dynamically for each available field.
    ...
    ...    *Arguments:*
    ...    - `${SicData}`: List of SIC codes to fill.
    ...    - `${NiacData}`: List of NAIC codes to fill.
    [Arguments]    ${SicData}    ${NiacData}

    # ----- Fill SIC Codes -----
    ${SICCodes}=    Get Elements    ${SicCodeInputFileds}
    ${count}=    Get Length    ${SicData}
    FOR    ${index}    IN RANGE    ${count}
        ${locator}=    Get From List    ${SICCodes}    ${index}
        ${data}=    Get From List    ${SicData}    ${index}
        Scroll To Element    ${locator}
        ${sic_status}=    Run Keyword And Return Status    Fill Text    ${locator}    ${data}
        Run Keyword If    not ${sic_status}    Log    Failed to fill SIC code at index ${index} with value ${data}    WARN
    END

    # ----- Fill NAIC Codes -----
    ${NAICCodes}=    Get Elements    ${NAICSCodeInputFileds}
    ${count}=    Get Length    ${NiacData}
    FOR    ${index}    IN RANGE    ${count}
        ${locator}=    Get From List    ${NAICCodes}    ${index}
        ${data}=    Get From List    ${NiacData}    ${index}
        Scroll To Element    ${locator}
        ${naic_status}=    Run Keyword And Return Status    Fill Text    ${locator}    ${data}
        Run Keyword If    not ${naic_status}    Log    Failed to fill NAIC code at index ${index} with value ${data}    WARN
    END


# Verify Decline in under Review Stage
#     [Documentation]    This method verifies the decline button is working sucessfully without any issues
#     # [Arguments]    ${Data}
#     Switch to Documents
#     # Wait For Elements State    ${Loc_Decline}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline    ${Loc_Decline}    visible
#     Click    ${Loc_Decline}
    
#     # Wait For Elements State    ${Loc_Decline_checkbox}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline_checkbox    ${Loc_Decline_checkbox}    visible
#     Check Checkbox    ${Loc_Decline_checkbox}

#     # Wait For Elements State    ${Loc_decline_Details}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_decline_Details    ${Loc_decline_Details}    visible
#     Fill Text    ${Loc_decline_Details}    Test

#     Click    ${Accept_Btn_Decline}

#     # Wait For Elements State    ${Reactive}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    visible
#     Click    ${Reactive}
    
#     # Wait For Elements State    ${Loc_Reactive_Details}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     Fill Text    ${Loc_Reactive_Details}    Test
#     Click    ${AcceptButtonInReactive}
#     Click    ${Side_Bar_Risk360_Button}
#     ${reactiveButtonStatus}    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
#     IF    ${reactiveButtonStatus} == 'False'
#      ${WorkFlow_Side_Panel}    Get Elements    ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#         ${Status}    Run Keyword And Return Status    Wait For Elements State    ${element}    enabled
#         Run Keyword And Continue On Failure    Should Not Be True    ${Status}
#     END
#     END
#     Switch to Documents
#     Sleep    3s
#     ${reactiveButtonStatus}    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
#     IF    ${reactiveButtonStatus}
#         Switch to Documents
#         Click    ${Side_Bar_Risk360_Button}
#         Click    ${Reactive}
#         Click    ${AcceptButtonInReactive}
#         Wait For Elements State    ${Reactive}    detached    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    detached
    
#     ELSE
#     Log    Reactive button is hidden
#     END
#     ${WorkFlow_Side_Panel}    Get Elements    ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#         ${Status}    Run Keyword And Return Status    Wait For Elements State    ${element}    enabled
#         Run Keyword And Continue On Failure    Should Not Be True    ${Status}
#     END

# Verify Decline in Under Review Stage
#     [Documentation]    Verifies the Decline and Reactive buttons work successfully under the Review stage.

#     Switch to Documents

#     # ----- Handle Decline -----
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline    ${Loc_Decline}    visible
#     ${decline_clicked}=    Run Keyword And Return Status    Click    ${Loc_Decline}
#     Run Keyword And Continue On Failure    Should Be True    ${decline_clicked}    msg=Decline button could not be clicked

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Decline_checkbox    ${Loc_Decline_checkbox}    visible
#     ${checkbox_checked}=    Run Keyword And Return Status    Check Checkbox    ${Loc_Decline_checkbox}
#     Run Keyword And Continue On Failure    Should Be True    ${checkbox_checked}    msg=Decline checkbox could not be checked

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_decline_Details    ${Loc_decline_Details}    visible
#     ${filled_decline}=    Run Keyword And Return Status    Fill Text    ${Loc_decline_Details}    Test
#     Run Keyword And Continue On Failure    Should Be True    ${filled_decline}    msg=Decline details could not be filled

#     ${accept_decline}=    Run Keyword And Return Status    Click    ${Accept_Btn_Decline}
#     Run Keyword And Continue On Failure    Should Be True    ${accept_decline}    msg=Accept button for Decline could not be clicked

#     # ----- Handle Reactive -----
#     Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    visible
#     ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
#     Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    msg=Reactive button could not be clicked

#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Reactive_Details    ${Loc_Reactive_Details}    visible
#     ${filled_reactive}=    Run Keyword And Return Status    Fill Text    ${Loc_Reactive_Details}    Test
#     Run Keyword And Continue On Failure    Should Be True    ${filled_reactive}    msg=Reactive details could not be filled

#     ${accept_reactive}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
#     Run Keyword And Continue On Failure    Should Be True    ${accept_reactive}    msg=Accept button in Reactive could not be clicked

#     ${sidebar_clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
#     Run Keyword And Continue On Failure    Should Be True    ${sidebar_clicked}    msg=Side Bar Risk360 button could not be clicked

#     ${reactive_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}

#     IF    ${reactive_visible}
#         Switch to Documents
#         ${sidebar_clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
#         Run Keyword And Continue On Failure    Should Be True    ${sidebar_clicked}    msg=Side Bar Risk360 button could not be clicked

#         ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
#         Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    msg=Reactive button could not be clicked

#         ${accept_reactive}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
#         Run Keyword And Continue On Failure    Should Be True    ${accept_reactive}    msg=Accept button in Reactive could not be clicked

#         Run Keyword And Continue On Failure    Wait For Elements State    ${Reactive}    detached    timeout=${element_timeout}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reactive    ${Reactive}    detached
#     ELSE
#         Log    Reactive button is hidden
#     END

#     # ----- Validate Workflow Side Panel -----
#     ${WorkFlow_Side_Panel}=    Get Elements    ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#         ${is_enabled}=    Run Keyword And Return Status    Wait For Elements State    ${element}    enabled
#         Run Keyword And Continue On Failure    Should Be True    ${is_enabled}
#     END
Verify Decline in Under Review Stage
    [Documentation]    Verifies the Decline and Reactive buttons work successfully under the Review stage.

    Switch to Documents

    # ----- Handle Decline -----
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Decline}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Decline button is not visible to click'
    ${decline_clicked}=    Run Keyword And Return Status    Click    ${Loc_Decline}
    Run Keyword And Continue On Failure    Should Be True    ${decline_clicked}    'Decline button could not be clicked'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Decline_checkbox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Decline_checkbox is not visible to check'
    ${checkbox_checked}=    Run Keyword And Return Status    Check Checkbox    ${Loc_Decline_checkbox}
    Run Keyword And Continue On Failure    Should Be True    ${checkbox_checked}    'Decline checkbox could not be checked'

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_decline_Details}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_decline_Details field is not visible to fill text'
    ${filled_decline}=    Run Keyword And Return Status    Fill Text    ${Loc_decline_Details}    Test
    Run Keyword And Continue On Failure    Should Be True    ${filled_decline}    'Decline details could not be filled'

    ${accept_decline}=    Run Keyword And Return Status    Click    ${Accept_Btn_Decline}
    Run Keyword And Continue On Failure    Should Be True    ${accept_decline}    'Accept button for Decline could not be clicked'

    # ----- Handle Reactive -----
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Reactive button is not visible to click'
    ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
    Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    'Reactive button could not be clicked'

    # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Reactive_Details}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    'Loc_Reactive_Details field is not visible to fill text'
    # ${filled_reactive}=    Run Keyword And Return Status    Fill Text    ${Loc_Reactive_Details}    Test
    # Run Keyword And Continue On Failure    Should Be True    ${filled_reactive}    'Reactive details could not be filled'

    ${accept_reactive}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
    Run Keyword And Continue On Failure    Should Be True    ${accept_reactive}    'Accept button in Reactive could not be clicked'

    ${sidebar_clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Run Keyword And Continue On Failure    Should Be True    ${sidebar_clicked}    'Side Bar Risk360 button could not be clicked'

    ${reactive_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    visible    timeout=${element_timeout}

    IF    ${reactive_visible}
        Switch to Documents
        ${sidebar_clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
        Run Keyword And Continue On Failure    Should Be True    ${sidebar_clicked}    'Side Bar Risk360 button could not be clicked'

        ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
        Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    'Reactive button could not be clicked again'

        ${accept_reactive}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${accept_reactive}    'Accept button in Reactive could not be clicked again'

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reactive}    detached    timeout=${processing_stage_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Reactive button is not detached as expected'
        Wait For Processing Stage
    ELSE
        Log    Reactive button is hidden
    END

    # ----- Validate Workflow Side Panel -----
    ${WorkFlow_Side_Panel}=    Get Elements    ${Workflow_Lists}
    FOR    ${element}    IN    @{WorkFlow_Side_Panel}
        ${is_enabled}=    Run Keyword And Return Status    Wait For Elements State    ${element}    enabled    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${is_enabled}    'Workflow side panel element is not enabled'
    END



Get Colour Name
    [Documentation]    this method is used to conver the rgb value to colour name
    ...    ${rgb_value}    we need to pass the rgp value
    [Arguments]    ${rgb_value}
   
    ${colour_map}=    Get From Dictionary    ${ColourCode}    ColourName
    ${colour_name}=   Get From Dictionary    ${colour_map}    ${rgb_value}
    RETURN    ${colour_name}

# verify the Sidebar label colour
#     [Documentation]    This method is used to verify the colour of the label (eg:Broker Not Appointed)
 
#     [Arguments]    ${Expected_colourname}  
#     ${Actual_colour_name}    Create List
#     ${label}    Get Elements    ${Sidebar_Label}                                                                                                                                                                                                                          
#     FOR    ${element}    IN    @{label}
#     # ${color}=    Get Element Attribute    xpath=//ng-transclude[normalize-space(.)='Save']@style
#     ${Colour}=    Get Style    ${element}    color    
#     Log    ${Colour}
#     ${Colour_name}    Get Colour Name    ${Colour}
#     Append To List    ${Actual_colour_name}    ${Colour_name}      
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_colour_name}    ${Expected_colourname}

verify the Sidebar label colour
    [Documentation]    Verifies the colour of the sidebar labels (e.g., Broker Not Appointed).

    [Arguments]    ${Expected_colourname}

    ${Actual_colour_name}=    Create List
    ${labels}=    Get Elements    ${Sidebar_Label}

    FOR    ${element}    IN    @{labels}
        ${colour}=    Get Style    ${element}    color
        Log    Found colour: ${colour}
        ${colour_name}=    Get Colour Name    ${colour}
        Append To List    ${Actual_colour_name}    ${colour_name}
    END

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_colour_name}    ${Expected_colourname}    msg=Sidebar label colours do not match expected values


# verify the forms data is extracted based on risk 360 Tab
#     [Documentation]    This methos is used verify the forms data is extracted based on risk 360 Tab
#     Switch to Risk360 tab
#     ${Actual_risk_year}    Get Text    ${risk_year}
#     ${ShowAllStatus}    Run Keyword And Return Status    Wait For Elements State    ${DescriptionShowAllButton}    visible
#     IF    ${ShowAllStatus} == True
#         Click    ${DescriptionShowAllButton}
#     END
#     ${Actual_risk_description}    Get Text    ${risk_description}
#     Navigate to Form
#     ${excepted_forms_year}    Get Text    ${PIFInsuredYearEstablished}
#     ${excepted_forms_description}    Get Text    ${PIFInsuredOperationDesc}
#     Run Keyword And Continue On Failure    Should Contain    ${Actual_risk_year}    ${excepted_forms_year}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_risk_description}    ${excepted_forms_description}
verify the forms data is extracted based on risk 360 Tab
    [Documentation]    This methos is used verify the forms data is extracted based on risk 360 Tab

    Switch to Risk360 tab
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${risk_year}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=risk_year element is not present to get a text value.
    ${Actual_risk_year}=    Get Text    ${risk_year}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${Actual_risk_year}    msg=Verify Forms Data: Unable to retrieve Risk Year from Risk360 tab. Locator: ${risk_year}

    ${ShowAllStatus}=    Run Keyword And Return Status    Wait For Elements State    ${DescriptionShowAllButton}    visible
    IF    ${ShowAllStatus} == True
        ${clicked}=    Run Keyword And Return Status    Click    ${DescriptionShowAllButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Forms Data: Failed to click 'Show All' button for Risk Description. Locator: ${DescriptionShowAllButton}
    END
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${risk_description}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=risk_description element is not present to get a text value.
    ${Actual_risk_description}=    Get Text    ${risk_description}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${Actual_risk_description}    msg=Verify Forms Data: Unable to retrieve Risk Description from Risk360 tab. Locator: ${risk_description}

    Navigate to Form
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${PIFInsuredYearEstablished}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=PIFInsuredYearEstablished element is not present to get a text value.

    ${excepted_forms_year}=    Get Text    ${PIFInsuredYearEstablished}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${excepted_forms_year}    msg=Verify Forms Data: Unable to retrieve 'Insured Year Established' from the form. Locator: ${PIFInsuredYearEstablished}
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${PIFInsuredOperationDesc}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=PIFInsuredOperationDesc element is not present to get a text value.
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${PIFInsuredOperationDesc}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=PIFInsuredOperationDesc element is not present to get a text value.

    ${excepted_forms_description}=    Get Text    ${PIFInsuredOperationDesc}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${excepted_forms_description}    msg=Verify Forms Data: Unable to retrieve 'Insured Operation Description' from the form. Locator: ${PIFInsuredOperationDesc}

    Run Keyword And Continue On Failure    Should Contain    ${Actual_risk_year}    ${excepted_forms_year}    msg=Verify Forms Data: Risk360 'Year' value '${Actual_risk_year}' does not contain expected form value '${excepted_forms_year}'

    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_risk_description}    ${excepted_forms_description}    msg=Verify Forms Data: Risk360 'Description' value '${Actual_risk_description}' does not match expected form value '${excepted_forms_description}'

# Reject Submission and Verify the error msg
#     [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
#     ...
#     ...    *Arguments:*
#     ...    - `${FailureReasons}`: A list of reasons for the rejection.
#     ...    - `${data_details}`: A text description of the rejection details.
#     ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.
#     [Arguments]    ${FailureReasons}    ${data_details}    
#     Click    ${Workflow_Reject}
#     # Wait For Elements State    ${UpdateWorkflowStage}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
#     Get Element States    ${SelectReason}    validate    value & visible    'SelectReason should be visible.'
#     FOR     ${failureReason}    IN    @{FailureReasons}
#     ${reason}    Catenate    SEPARATOR=    ${ReasonForReject1}    ${failureReason}    ${ReasonForReject2}
#     Check Checkbox    ${reason}
#     END
#     ${other_option}=    Run Keyword And Return Status    List Should Contain Value    ${FailureReasons}    Other
       
#     IF    '${other_option}' == 'True'
#         ${state}=    Get Element States    ${enter_detials_button}
#         Run Keyword And Continue On Failure    Should Contain    ${state}    disabled
#     END
#     Fill Text    ${Details}    ${data_details}
#     ${state}=    Get Element States    ${AcceptButton}
#     Run Keyword And Continue On Failure    Should Contain    ${state}    enabled
#     Click    ${CancelButtonInReject}  
#     Click    ${Workflow_Reject}
#     ${actual_data}    Get Text    ${Details}
#     Run Keyword And Continue On Failure    Should Be Empty    ${actual_data}
#     Click    ${CancelButtonInReject}  

Reject Submission and Verify the error msg
    [Documentation]    Rejects a submission, fills out the rejection reason, and verifies the submission tag changes accordingly.
    ...
    ...    *Arguments:*
    ...    - `${FailureReasons}`: A list of reasons for the rejection.
    ...    - `${data_details}`: A text description of the rejection details.
    ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.

    [Arguments]    ${FailureReasons}    ${data_details}    

    ${clicked}=    Run Keyword And Return Status    Click    ${Workflow_Reject}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Workflow Reject button could not be clicked
    # Run Keyword And Continue On Failure    Wait For Element With Message    UpdateWorkflowStage    ${UpdateWorkflowStage}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UpdateWorkflowStage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'UpdateWorkflowStage is not visible to proceed'
    Get Element States    ${SelectReason}    validate    value & visible    'SelectReason should be visible.'
    FOR    ${failureReason}    IN    @{FailureReasons}
        ${reason}=    Catenate    SEPARATOR=    ${ReasonForReject1}    ${failureReason}    ${ReasonForReject2}
        ${checked}=    Run Keyword And Return Status    Check Checkbox    ${reason}
        Run Keyword And Continue On Failure    Should Be True    ${checked}    msg=Could not check reason: ${failureReason}
    END
    ${other_option}=    Run Keyword And Return Status    List Should Contain Value    ${FailureReasons}    Other
    IF    ${other_option}
        ${state}=    Get Element States    ${enter_detials_button}
        Run Keyword And Continue On Failure    Should Contain    ${state}    disabled    msg=Enter Details button should be disabled when 'Other' is selected
    END
    ${filled}=    Run Keyword And Return Status    Fill Text    ${Details}    ${data_details}
    Run Keyword And Continue On Failure    Should Be True    ${filled}    msg=Could not fill rejection details
    ${state}=    Get Element States    ${AcceptButton}
    Run Keyword And Continue On Failure    Should Contain    ${state}    enabled    msg=Accept button should be enabled after entering details
    ${cancel_clicked}=    Run Keyword And Return Status    Click    ${CancelButtonInReject}
    Run Keyword And Continue On Failure    Should Be True    ${cancel_clicked}    msg=Cancel button in Reject could not be clicked
    ${clicked}=    Run Keyword And Return Status    Click    ${Workflow_Reject}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Workflow Reject button could not be clicked
    ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${Details}    attached    timeout=${element_timeout}
    Should Be True    ${attached}    msg=Details element is not present to get a text value.
    ${actual_data}=    Get Text    ${Details}
    Run Keyword And Continue On Failure    Should Be Empty    ${actual_data}    msg=Rejection details were not reset after Cancel
    ${cancel_clicked}=    Run Keyword And Return Status    Click    ${CancelButtonInReject}
    Run Keyword And Continue On Failure    Should Be True    ${cancel_clicked}    msg=Cancel button in Reject could not be clicked


# verify Reactive the Rejected Submission error msg appear
#     [Documentation]    Activates a submission that was previously rejected.
#     ...    It handles clicking the 'Reactive' button and any confirmation dialogs, waiting for the submission to leave the rejected state.
#     # [Arguments]    ${detials}
#     Sleep    3s
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${element_timeout}
#     ${rejectStatus}    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${element_timeout}
#     IF    ${status} == True or ${rejectStatus} == True
#         Log    'Processing Stage is visible'
#         Wait For Processing Stage    ""
#     END
#     Click    ${Reactive}
#     # Wait For Elements State    ${ReactivatePopup}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReactivatePopup    ${ReactivatePopup}    visible
#     ${acceptButton}    Run Keyword and Return Status    Wait For Elements State    ${AcceptButtonInReactive}    visible    timeout=${element_timeout}
#     IF    ${acceptButton}
#         Click    ${AcceptButtonInReactive}
#         Run Keyword And Continue On Failure    Get Element States    ${Summary_reactive_error_msg}    validate    value & visible    'Summary_reactive_error_msg should be enabled.'
#     ELSE
#         Click    ${Reactive}
#         Click    ${AcceptButtonInReactive}
#         Run Keyword And Continue On Failure    Get Element States    ${Summary_reactive_error_msg}    validate    value & visible    'Summary_reactive_error_msg should be enabled.'
#     END

verify Reactive the Rejected Submission error msg appear
    [Documentation]    Activates a submission that was previously rejected.
    ...    Clicks the 'Reactive' button, handles confirmation dialogs, and verifies the error message appears.

    Sleep    5s
    Wait For Processing Stage
    # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${processingStageInLeftMenu}    visible    timeout=${display_timeout}
    # ${rejectStatus}=    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${display_timeout}

    # IF    ${status} or ${rejectStatus}
    #     Log    Processing Stage is visible
    #     Wait For Processing Stage    ""
    # END

    ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
    Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    msg=Reactive button could not be clicked

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ReactivatePopup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reactivate popup is not visible

    ${accept_visible}=    Run Keyword And Return Status    Wait For Elements State    ${AcceptButtonInReactive}    visible    timeout=${element_timeout}

    IF    ${accept_visible}
        ${accept_clicked}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${accept_clicked}    msg=Accept button in Reactive could not be clicked
        ${Status}    Run Keyword And Return Status    Wait For Elements State    ${Summary_reactive_error_msg}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${Status}   msg='workflow reactive error msg not visible when user didn't enter the reason for other option.'
    ELSE
        ${reactive_clicked}=    Run Keyword And Return Status    Click    ${Reactive}
        Run Keyword And Continue On Failure    Should Be True    ${reactive_clicked}    msg=Reactive button could not be clicked

        ${accept_clicked}=    Run Keyword And Return Status    Click    ${AcceptButtonInReactive}
        Run Keyword And Continue On Failure    Should Be True    ${accept_clicked}    msg=Accept button in Reactive could not be clicked 

        ${Status}    Run Keyword And Return Status    Wait For Elements State    ${Summary_reactive_error_msg}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${Status}   msg='workflow reactive error msg not visible when user didn't enter the reason for other option.'
    END

 
# Verify the AM Best card in risk360 tab
#     [Documentation]    This method is used to verify the Nasics Code in AM best card in risk 360 tab

#     Click and verify Clearance tab
#     ${Naics_element}    Get Elements    ${Clearance_NaicsCode}
#     ${ActualNaics_code}    Create List
#     FOR    ${element}    IN    @{Naics_element}
#         ${Naicscode}    Get Text    ${element}
#         Append To List    ${ActualNaics_code}    ${Naicscode}
#     END
#     Click Answers Tab
#     Switch to Risk360 tab
#     Click    ${Am_bestcard}
#     Select Options By    ${AmCard_setpages}    label    100
#     ${ExceptedNaics_code}    Create List
#     ${rows_elements}    Get Elements    ${AMBest_Row}
#     ${rowlength}    Get Length    ${rows_elements}
#    FOR    ${index}    IN RANGE    1    ${rowlength}+1
#     ${locator}=    Set Variable    ${Amcard_Nasicscode1}${index}${Amcard_Nasicscode2}
#     ${naics_text}=    Get Text    ${locator}
#     Append To List    ${ExceptedNaics_code}    ${naics_text}
#     END
#     FOR    ${index}    IN RANGE    1    ${rowlength}+1
#     ${locator}=    Set Variable    ${Amcard_Nasicscode1}${index}${Amcard_Nasicscode3}
#     ${naics_text}=    Get Text    ${locator}
#     Append To List    ${ExceptedNaics_code}    ${naics_text}
#     END
#     Run Keyword And Continue On Failure    List Run Keyword And Continue On Failure    Should Contain Sub List    ${ExceptedNaics_code}    ${ActualNaics_code}
#     Click Answers Tab 
Verify the AM Best card in risk360 tab
    [Documentation]    This method is used to verify the Nasics Code in AM Best card in risk 360 tab

    Click and verify Clearance tab

    ${Naics_element}=    Get Elements    ${Clearance_NaicsCode}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${Naics_element}    msg=Verify AM Best Card: No NAICS code elements found in the Clearance tab. Locator: ${Clearance_NaicsCode}
    ${ActualNaics_code}=    Create List
    FOR    ${element}    IN    @{Naics_element}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${element}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=Naics_element element is not present to get a text value.
        ${Naicscode}=    Get Text    ${element}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${Naicscode}    msg=Verify AM Best Card: Failed to retrieve NAICS code text from Clearance tab element: ${element}
        Append To List    ${ActualNaics_code}    ${Naicscode}
    END

    Click Answers Tab
    Switch to Risk360 tab

    ${clicked}=    Run Keyword And Return Status    Click    ${Am_bestcard}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify AM Best Card: Failed to click the AM Best card. Locator: ${Am_bestcard} in the risk 360 tab

    Select Options By    ${AmCard_setpages}    label    100
    ${rows_elements}=    Get Elements    ${AMBest_Row}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${rows_elements}    msg=Verify AM Best Card: No rows found in AM Best card. Locator: ${AMBest_Row} in the risk 360 tab
    ${rowlength}=    Get Length    ${rows_elements}

    ${ExceptedNaics_code}=    Create List
    FOR    ${index}    IN RANGE    1    ${rowlength}+1
        ${locator}=    Set Variable    ${Amcard_Nasicscode1}${index}${Amcard_Nasicscode2}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=AMBest_Row element is not present to get a text value.
        ${naics_text}=    Get Text    ${locator}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${naics_text}    msg=Verify AM Best Card: Failed to get NAICS code text from row ${index}, locator: ${locator} in the risk 360 tab
        Append To List    ${ExceptedNaics_code}    ${naics_text}
    END

    FOR    ${index}    IN RANGE    1    ${rowlength}+1
        ${locator}=    Set Variable    ${Amcard_Nasicscode1}${index}${Amcard_Nasicscode3}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg=AMBest_Row element is not present to get a text value.
        ${naics_text}=    Get Text    ${locator}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${naics_text}    msg=Verify AM Best Card: Failed to get additional NAICS code text from row ${index}, locator: ${locator} in the risk 360 tab
        Append To List    ${ExceptedNaics_code}    ${naics_text}
    END

    ${contains}=    Run Keyword And Return Status    List Should Contain Sub List    ${ExceptedNaics_code}    ${ActualNaics_code}
    Run Keyword And Continue On Failure    Should Be True    ${contains}    msg=Verify AM Best Card: Clearance tab NAICS codes ${ActualNaics_code} are not present in AM Best card values ${ExceptedNaics_code} in the risk 360 tab

    Click Answers Tab

# Select the Underwritername in clearance
#     [Documentation]    This method is used to verify that the select the Underwriter name in clearance tab
#     [Arguments]    ${data}
#     ${Underwriter}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriter    ${Loc_PIF_Process_Detail2}
#     Click    ${Underwriter}
#     # Wait For Elements State    ${NameSearchFiled}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NameSearchFiled    ${NameSearchFiled}    visible
#     Fill Text    ${NameSearchFiled}    ${Data['UnderwriterName']}
#     ${ExistingUnderwriter}    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['UnderwriterName']}    ']
#     ${status}    Run Keyword And Ignore Error    Wait For Elements State    ${ExistingUnderwriter}    visible    10s
#     Run Keyword If    '${status}[0]' == 'PASS'    Click    ${ExistingUnderwriter}
#     # If not visible, click the new one
#     ${NewUnderwriter}    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwriterName']}    ']
#     Run Keyword If    '${status}[0]' == 'FAIL'    Click    ${NewUnderwriter}    
Select the Underwriter Name in Clearance
    [Documentation]    Selects the Underwriter name in the clearance tab.
    [Arguments]    ${Data}

    ${Underwriter}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    Underwriter    ${Loc_PIF_Process_Detail2}
    ${clicked}=    Run Keyword And Return Status    Click    ${Underwriter}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click Underwriter field in the clearance tab

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${NameSearchFiled}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=NameSearchFiled is not visible

    ${filled}=    Run Keyword And Return Status    Fill Text    ${NameSearchFiled}    ${Data['UnderwriterName']}
    Run Keyword And Continue On Failure    Should Be True    ${filled}    msg=Could not fill Underwriter name in search field in clearance tab 

    ${ExistingUnderwriter}=    Catenate    SEPARATOR=    ${SelectExistingValue}    ${Data['UnderwriterName']}    ']
    ${status}=    Run Keyword And Ignore Error    Wait For Elements State    ${ExistingUnderwriter}    visible    10s

    Run Keyword If    '${status}[0]' == 'PASS'
    ${clicked}=    Run Keyword And Return Status    Click    ${ExistingUnderwriter}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click existing Underwriter option in the clearance tab

    ${NewUnderwriter}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${Data['UnderwriterName']}    ']
    Run Keyword If    '${status}[0]' == 'FAIL'
    ${clicked}=    Run Keyword And Return Status    Click    ${NewUnderwriter}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not click new Underwriter in the clearance tab
   

# Verify Clearance Data in Processing Tab based on Underwriter name
#     [Documentation]    Verifies the Decline button works successfully without any issues.
#     [Arguments]    ${ExpectedPDFText}    
#     @{locators}     Create List    Underwriter    Underwriter Email    Underwriting Office    Operations Name    Operations Email    Rep Office    Rep Email    Channel    Sub Channel    Direct or Assumed
#     @{ActualPDFText}    Create List
#     FOR    ${locator}    IN    @{locators}
#         ${ProcesingData}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    ${locator}    ${Clearance_processing_loc3}
#         Scroll To Element    ${ProcesingData}
#         ${text}    Get Text    ${ProcesingData}
#         ${trimText}    Strip String    ${text}
#         Append To List    ${ActualPDFText}    ${trimText}
#     END
#     Log    ${ExpectedPDFText}
#     Log    ${ActualPDFText}    
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText} 
Verify Clearance Data in Processing Tab Based on Underwriter Name
    [Documentation]    Verifies that the clearance data in the processing tab matches the expected values.
    [Arguments]    ${ExpectedPDFText}

    @{locators}=    Create List    Underwriter    Underwriter Email    Underwriting Office    Operations Name    Operations Email    Rep Office    Rep Email    Channel    Sub Channel    Direct or Assumed
    @{ActualPDFText}=    Create List

    FOR    ${locator}    IN    @{locators}
        ${ProcessingData}=    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}    ${locator}    ${Clearance_processing_loc3}
        ${attached}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingData}    attached    timeout=${element_timeout}
        Should Be True    ${attached}    msg='${locator}' element is not present to get a text value.
        Scroll To Element    ${ProcessingData}
        ${text}=    Get Text    ${ProcessingData}
        ${trimText}=    Strip String    ${text}
        Append To List    ${ActualPDFText}    ${trimText}
    END

    Log    Expected: ${ExpectedPDFText}
    Log    Actual: ${ActualPDFText}

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedPDFText}    ${ActualPDFText}    msg=Clearance data does not match expected values

verify the delete Submission is not available for the Client Admin Role
    [Documentation]    Verifies that the 'Delete Submission' option is not available for the HITL user.
    
    # Select first row
    ${check_status}=    Run Keyword And Return Status    Wait For Elements State    ${Select_firstrow}    visible    timeout=5s
    Run Keyword And Continue On Failure    Should Be True    ${check_status}    msg=Select_firstrow is not visible on the page.

    ${checkbox_status}=    Run Keyword And Return Status    Check Checkbox    ${Select_firstrow}
    Run Keyword And Continue On Failure    Should Be True    ${checkbox_status}    msg=Failed to check the first row checkbox.

    # Right click on the first row
    ${clicked}=    Run Keyword And Return Status    Click    ${Select_firstrow}    button=right
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to right-click on the first row.

    # Get dropdown options
    ${options}=    Get Elements    ${Convr_Dropdown_option}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${options}    msg=No dropdown options found for HITL user right-click menu.

    FOR    ${element}    IN    @{options}
        ${wait_status}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=5s
        Run Keyword And Continue On Failure    Should Be True    ${wait_status}    msg=Dropdown option not visible before reading text.

        ${text}=    Get Text    ${element}
        ${text}=    Strip String    ${text}
        ${not_delete}=    Run Keyword And Return Status    Should Not Be Equal As Strings    ${text}    Delete
        Run Keyword And Continue On Failure    Should Be True    ${not_delete}    msg=The 'Delete' option is unexpectedly available for HITL user (found text: '${text}').
    END 

Remove the State from the clearance Tab
    [Documentation]  this method is used remove the State form clearance  
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${InsuredState}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Insured Tab:Insured State is not visible in the clearance page
    ${Status}=    Run Keyword And Return Status    Clear Text    ${InsuredState}      
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Insured Tab:Failed to clear the Insured State 

verify the projectadress and vessels
    [Documentation]    Verify the Project Address and Vessels fields in the Clearance tab.
    [Arguments]    ${expected_project_fields}    ${expected_vessels_field}

    # --- Verify Project Addresses ---
    Scroll To Element    ${Project_Addresses}
    ${project_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Project_Addresses}    visible    timeout=5s
    Run Keyword And Continue On Failure    Should Be True    ${project_visible}    msg=Project Addresses section is not visible in the clearance tab.

    ${click_status}=    Run Keyword And Return Status    Click    ${Project_Addresses_Add}
    Run Keyword And Continue On Failure    Should Be True    ${click_status}    msg=Failed to click 'Add' button in Project Addresses section.

    ${project_fields}=    Get Elements    ${project_Addres_field}
    ${actual_project_fields}=    Create List

    FOR    ${field}    IN    @{project_fields}
        ${wait_status}=    Run Keyword And Return Status    Wait For Elements State    ${field}    visible    timeout=5s
        Run Keyword And Continue On Failure    Should Be True    ${wait_status}    msg=Project Address field element not visible before fetching text.
        ${text}=    Get Text    ${field}
        ${text}=    Strip String    ${text}
        Append To List    ${actual_project_fields}    ${text}
    END

    ${length}=    Get Length    ${expected_project_fields}
    FOR    ${index}    IN RANGE    ${length}
        ${expected}=    Get From List    ${expected_project_fields}    ${index}
        ${actual}=      Get From List    ${actual_project_fields}      ${index}
        ${match}=       Run Keyword And Return Status    Should Be Equal As Strings    ${expected}    ${actual}
        Run Keyword And Continue On Failure    Should Be True    ${match}    msg=Project Address field mismatch at index ${index}. Expected: '${expected}', Actual: '${actual}'.
    END

    # --- Verify Vessels Section ---
    ${click_status}=    Run Keyword And Return Status    Click    ${Vessels_delete}
    Run Keyword And Continue On Failure    Should Be True    ${click_status}    msg=Failed to click 'Delete' in Vessels section before verification.

    ${vessels_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Vessels}    visible    timeout=5s
    Run Keyword And Continue On Failure    Should Be True    ${vessels_visible}    msg=Vessels section is not visible in the clearance tab.

    ${click_status}=    Run Keyword And Return Status    Click    ${Vessels_Add}
    Run Keyword And Continue On Failure    Should Be True    ${click_status}    msg=Failed to click 'Add' in Vessels section.

    ${wait_status}=    Run Keyword And Return Status    Wait For Elements State    ${project_Addres_field}    visible    timeout=5s
    Run Keyword And Continue On Failure    Should Be True    ${wait_status}    msg=Vessel field element not visible before fetching text.
    ${vessels_field}=    Get Text    ${project_Addres_field}
    ${match}=    Run Keyword And Return Status    Should Be Equal As Strings    ${vessels_field}    ${expected_vessels_field}
    Run Keyword And Continue On Failure    Should Be True    ${match}    msg=Vessels field mismatch. Expected: '${expected_vessels_field}', Actual: '${vessels_field}'.

    ${click_status}=    Run Keyword And Return Status    Click    ${Vessels_delete}
    Run Keyword And Continue On Failure    Should Be True    ${click_status}    msg=Failed to click 'Delete' in Vessels section after verification.
    
Delete and add the SIC and Naics code in clearance tab 
    [Documentation]    This method verify the Delete and add the SIC and Naics code in clearance tab
    [Arguments]    ${NAICS_value}

    # ${delete_sic}    Catenate    SEPARATOR=    ${delete_sic_code_prefix}    ${SIC_value}    ${delete_sic_code_sufix}    
    # Click    ${delete_sic}
    #  Wait For Elements State    ${Add_sic_code_button}    visible    ${display_timeout}
    # Click    ${Add_sic_code_button}
    # # Wait For Elements State    ${delete_sic}    visible    ${display_timeout}
    # ${SIC_input}    Get Elements    ${Add_sic_value}
    # FOR    ${element}    IN    @{SIC_input}   
    #     Fill Text    ${element}    ${SIC_value} 
    # END
    
    ${delete_naics}    Catenate    SEPARATOR=    ${delete_sic_code_prefix}    ${NAICS_value}    ${delete_sic_code_sufix}    
    ${status}=    Run Keyword And Return Status    Click    ${delete_naics}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click delete NAICS button

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Add_naic_code_button}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Add NAICS Code button not visible

    ${status}=    Run Keyword And Return Status    Click    ${Add_naic_code_button}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Add NAICS Code button
    ${NAICS_input}    Get Elements    ${Add_naics_value}

    FOR    ${element}    IN    @{NAICS_input}
    Fill Text    ${element}    ${NAICS_value}
    Exit For Loop
    END
      ${NAICS_input}    Get Elements    ${Add_naics_value}

    FOR    ${element}    IN    @{NAICS_input}
    Fill Text    ${element}    ${NAICS_value}
    Exit For Loop
    END
# Delete and add the SIC and Naics code in clearance tab
#     [Documentation]    This method verifies the Delete and Add functionality of SIC and NAICS codes in the Clearance tab
#     [Arguments]    ${NAICS_value}

#     # --- Delete and Add SIC Code ---
#     # Uncomment below if SIC code handling is required in future
#     # ${delete_sic}=    Catenate    SEPARATOR=    ${delete_sic_code_prefix}    ${SIC_value}    ${delete_sic_code_sufix}
#     # ${status}=    Run Keyword And Return Status    Click    ${delete_sic}
#     # Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click delete SIC button
#     # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Add_sic_code_button}    visible    ${display_timeout}
#     # Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Add SIC Code button not visible
#     # ${status}=    Run Keyword And Return Status    Click    ${Add_sic_code_button}
#     # Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Add SIC Code button
#     # ${SIC_input}=    Get Elements    ${Add_sic_value}
#     # FOR    ${element}    IN    @{SIC_input}
#     #     ${status}=    Run Keyword And Return Status    Fill Text    ${element}    ${SIC_value}
#     #     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to enter SIC code value
#     #     Exit For Loop
#     # END

#     # --- Delete and Add NAICS Code ---
#     ${delete_naics}=    Catenate    SEPARATOR=    ${delete_sic_code_prefix}    ${NAICS_value}    ${delete_sic_code_sufix}

#     ${status}=    Run Keyword And Return Status    Click    ${delete_naics}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click delete NAICS button

#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Add_naic_code_button}    visible    ${display_timeout}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Add NAICS Code button not visible

#     ${status}=    Run Keyword And Return Status    Click    ${Add_naic_code_button}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to click Add NAICS Code button

#     ${NAICS_input}=    Get Elements    ${Add_naics_value}
#     FOR    ${element}    IN    @{NAICS_input}
#         ${status}=    Run Keyword And Return Status    Fill Text    ${element}    ${NAICS_value}
#         Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill NAICS code value
#         Exit For Loop
#     END

Veify That Empty NAICS and SIC box should not be present in the clearance 
    [Documentation]    This method is Veify That Empty NAICS and SIC box should not be present in the clearance    
    Sleep    2s
    ${NAICS_input}    Get Elements    ${Add_naics_value}
    Run Keyword And Continue On Failure    Should Be Empty    ${NAICS_input}    after the delete the naics code the empty box is present 
    ${SIC_input}    Get Elements    ${Add_sic_value}
    Run Keyword And Continue On Failure    Should Be Empty    ${Add_sic_value}    after the delete the sic code the empty box is present

verify the Transation Type filter in Convr Submission page
    [Documentation]    This method is used to verify the Transation Type filter in Convr Submission page
    [Arguments]    ${expected_options}    
    select the Options as per given data in Submission page    Created by me 
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Transaction_filter_button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    should be True    ${status}    msg=Transaction Type filter button is not visible
    ${clicked}=    Run Keyword And Return Status    Click    ${Transaction_filter_button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Transaction Type filter button
    # ${status}    Run Keyword And Return Status    Wait For Elements State    ${Transaction_type_options}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    should be True    ${status}    msg=Transaction Type options are not visible
    ${options_elements}    Get Elements    ${Transaction_type_options}
    ${Actual_options}    Create List
    FOR    ${element}    IN    @{options_elements}
        ${option_text}    Get Text    ${element}
        strip String    ${option_text}
        Append To List    ${Actual_options}    ${option_text}
    END
    FOR    ${element}    IN    @{Actual_options}
        ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${element}    ${Filter_option_checkbox_suffix}
        ${staus}    Get Checkbox State    ${locator}  
        Run Keyword And Continue On Failure    Should Be True    ${staus}    msg=Checkbox for option ${element} is not selected    
    END
    Press Keys    ${Transaction_filter_button}    Escape
    FOR    ${Option}    IN    @{Actual_options}
      IF    '${Option}' == '(Select All)'
            Continue For Loop
      ELSE
            Click    ${Transaction_filter_button}
            ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${Option}    ${Filter_option_checkbox_suffix}
            ${staus}    Get Checkbox State    ${locator}  
            Run Keyword And Continue On Failure    Should Be True    ${staus}    msg=Checkbox for option ${element} is not selected    
            ${clicked}=    Run Keyword And Return Status    Click    ${locator}
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
            press Keys    ${Transaction_filter_button}    Escape
            Sleep    2s
            ${Transaction_element}    Get Elements    ${transaction_type_value}
            FOR    ${element}    IN    @{Transaction_element}
                ${value}    Get Text    ${element}
                ${value}    strip String    ${value}
                Run Keyword And Continue On Failure    Should Not Be Equal    ${value}    ${Option}    msg=Filtered value ${value} is still displayed after unchecking ${Option} option
            END
            Click    ${Transaction_filter_button}
            ${clicked}=    Run Keyword And Return Status    Click    ${locator}
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
            press Keys    ${Transaction_filter_button}    Escape
        END
    END
    Log    Expected Options: ${expected_options}
    Log    Actual Options: ${Actual_options}
    ${status}    Run Keyword And Return Status    Should Be Equal    ${Actual_options}    ${expected_options}
    Run Keyword And Continue On Failure    Should Be True    ${status}    TransactionType option are mismatch in allsummission page       


verify Broker LLM EXTRACTION is Enabled or not 
    [Documentation]    Verifies that Broker LLM EXTRACTION is present for MSIG clients.
    [Arguments]    ${user_name}

    ${click_clients}=    Run Keyword And Return Status    Click    ${Clients_button}
    Run Keyword And Continue On Failure    Should Be True    ${click_clients}    msg=Failed to click Clients button

    Fill Text    ${Search_clients}    ${user_name}

    ${click_client_field}=    Run Keyword And Return Status    Click    ${Client_field}
    Run Keyword And Continue On Failure    Should Be True    ${click_client_field}    msg=Failed to click client field for user ${user_name}

    ${status}    Run Keyword And Return Status    Wait For Elements State    ${BROKER_LLM_extraction}    detached    msg=Email composer attachment should not be present
    IF    '${status}' == 'True'
        ${status}    Run Keyword And Return Status   Click    ${BROKER_LLM_extraction} 
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to enable the Broker LLM EXTRACTION for MSIG CLients
    END
    ${click_user_btn}=    Run Keyword And Return Status    Click    ${User_Button}
    Run Keyword And Continue On Failure    Should Be True    ${click_user_btn}    msg=Failed to click User button

# verify theclearance effective date and exp date
#     [Documentation]  
#     [Arguments]    ${Expected_date}  
#     ${Actual_date}    Create List
#     ${Effective_date}    Get Attribute    ${Clearnce_effective_Date}    value
#     ${Effective_date}    Strip String    ${Effective_date}
#     Log    ${Effective_date}
#     ${Exp_date}    Get Attribute    ${clearance_exp_date}    value
#     ${Exp_date}    Strip String    ${Exp_date}
#     Log    ${Exp_date}
#     Append To List    ${Actual_date}     ${Effective_date}    
#     Append To List    ${Actual_date}     ${Exp_date}
Verify The Clearance Effective Date And Exp Date
    [Documentation]
    [Arguments]    ${Expected_date}
    ${Actual_date}=    Create List

    ${Effective_date}=    Get Attribute    ${Clearnce_effective_Date}    value
    ${Effective_date}=    Strip String    ${Effective_date}
    ${Effective_date}=    Convert Date    ${Effective_date}    result_format=%m/%d/%Y
    Log    Effective: ${Effective_date}

    ${Exp_date}=    Get Attribute    ${clearance_exp_date}    value
    ${Exp_date}=    Strip String    ${Exp_date}
    ${Exp_date}=    Convert Date    ${Exp_date}    result_format=%m/%d/%Y
    Log    Expiry: ${Exp_date}

    Append To List    ${Actual_date}    ${Exp_date}
    Append To List    ${Actual_date}    ${Effective_date}
   

    ${status}    Run Keyword And Return Status    Lists Should Be Equal    ${Expected_date}    ${Actual_date}
    Run Keyword And Continue On Failure    Should Be True    ${status}    forms date not reflected in the clearance tab 

Switch to Convr Task tab
    [Documentation]    Switches to the Convr Task tab.
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Convr_Task_tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    should be True    ${status}    msg=Convr Task tab is not visible
    ${clicked}=    Run Keyword And Return Status    Click    ${Convr_Task_tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Convr Task tab
    Click All tasks option

Verify the filter option in Convr Submission page
    [Documentation]    This method is used to verify the Account filter in Convr Submission page
    [Arguments]    ${Column_header}    ${expected_options}        
    select the Options as per given data in Submission page    All submissions
    sleep    2s
    Rearrange Submission Page Columns    ${Column_header}
    ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
    ${Cell_value_element}    Get Elements    ${Cell_value_locator}
    ${Count}    Get Length    ${Cell_value_element}
    ${Actual_options_value}    Create List
    FOR    ${element}    IN RANGE    0    ${Count}
       
        ${option_text}    Get Text    ${Cell_value_element}[${element}]
        strip String    ${option_text}
        Run Keyword If    '${option_text}' == ' '    Continue For Loop
        Append To List    ${Actual_options_value}    ${option_text}
        # ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}
    END
    ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}

    FOR    ${fill_value}    IN    @{Actual_options_value}
        ${locator}    Catenate    SEPARATOR=    ${filter_apply_button_prefix}    ${expected_options}    ${filter_apply_button_suffix} 
        ${status}    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter button is not visible
        ${clicked}=    Run Keyword And Return Status    Click    ${locator}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Account filter button
        ${status}    Run Keyword And Return Status    Wait For Elements State    ${Filter_input}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter input is not visible
        ${status}    Run Keyword And Return Status    fill Text    ${Filter_input}    ${fill_value}
        should be True    ${status}    msg=Could not fill text in Account filter input
        Sleep    2s
        Press Keys    ${locator}    Escape
        Sleep    2s
        ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
        ${Cell_value_element}    Get Elements    ${Cell_value_locator}
        Should Not Be Empty    ${Cell_value_element}    filter is not working fine for is header : ${Column_header} on this value ${fill_value} 
        ${Actual_options}    Create List
            FOR    ${element}    IN    @{Cell_value_element}
                ${option_text}    Get Text    ${element}
                strip String    ${option_text}
                
                Append To List    ${Actual_options}    ${option_text}
                
            END
            ${Actual_options}=    Remove Duplicates    ${Actual_options}
            FOR    ${Actual_value}    IN    @{Actual_options}
            Log    ${Actual_value}
            log    ${fill_value}
            ${status}    Run Keyword And Return Status    Should Contain    ${Actual_value}    ${fill_value}    msg=Filtered value ${Actual_value} does not match expected value ${fill_value} filter option is not working as expected
            Run Keyword And Continue On Failure    should be True    ${status}    msg=Filtered value ${Actual_value} does not match expected value ${fill_value} : filter option is not working as expected
            END
            ${status}    Run Keyword And Return Status    Wait For Elements State    ${Remove_filter}    visible    timeout=${display_timeout}
            Run Keyword And Continue On Failure    should be True    ${status}    msg=Remove filter button is not visible
        
            ${status}    Run Keyword And Return Status    Click    ${Remove_filter}
            Run Keyword And Continue On Failure    should be True    ${status}    msg=Remove filter button is not clicked 
    END

verify the Checkbox Type filter in Convr Submission page
    [Documentation]    This method is used to verify the Transation Type filter in Convr Submission page
    [Arguments]    ${Column_header}    ${expected_options}    ${expected_options_value}    
    select the Options as per given data in Submission page    All tasks
    sleep    2s
    Rearrange Submission Page Columns    ${Column_header}
    ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
    ${Cell_value_element}    Get Elements    ${Cell_value_locator}
    ${Count}    Get Length    ${Cell_value_element}
    ${Actual_options_value}    Create List
    FOR    ${element}    IN RANGE    0    ${Count}
        ${text}    Get Text    ${Cell_value_element}[${element}]
        strip String    ${text}
        ${has_newline}=    Run Keyword And Return Status    Should Contain    ${text}    \n
         ${is_empty}=    Run Keyword And Return Status    Should Be Empty    ${text}
         ${has_comma}=    Run Keyword And Return Status    Should Contain    ${text}    ,
        IF    ${has_newline}
            ${lines}=    Split String    ${text}    \n
            ${last_line}=    Get From List    ${lines}    -1
            ${last_line}=    Strip String    ${last_line}
            ${clean}=    Set Variable    ${last_line}
            Append To List    ${Actual_options_value}    ${clean}
        ELSE IF    ${is_empty}
            Continue For Loop
        ELSE IF    ${has_comma}
            ${items}=    Split String    ${text}    , 
            FOR    ${item}    IN    @{items}
                ${clean}=    Strip String    ${item}
                Append To List    ${Actual_options_value}    ${clean}
            END
        ELSE 
        ${text}=    Strip String    ${text}
        Append To List    ${Actual_options_value}    ${text}
           
        END

    END
    ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}
    Log    ${Actual_options_value}
    ${Filter_locator}    Catenate    SEPARATOR=    ${filter_apply_button_prefix}    ${expected_options}    ${filter_apply_button_suffix} 
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Filter_locator}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter button is not visible
    ${clicked}=    Run Keyword And Return Status    Click    ${Filter_locator}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Account filter button
    ${options_elements}    Get Elements    ${Transaction_type_options}
    ${Actual_options}    Create List
    FOR    ${element}    IN    @{options_elements}
        ${option_text}    Get Text    ${element}
        strip String    ${option_text}
        Append To List    ${Actual_options}    ${option_text}
    END
    FOR    ${element}    IN    @{Actual_options}
        ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${element}    ${Filter_option_checkbox_suffix}
        ${staus}    Get Checkbox State    ${locator}  
        IF    '${staus}' == 'True'
            Uncheck Checkbox    ${locator}    
        END
    END
            Press Keys    ${Filter_locator}    Escape
        FOR    ${Option}    IN    @{Actual_options_value}   
            Click    ${Filter_locator}
            Fill Text    ${check_box_filter_field}    ${Option}
            ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${Option}    ${Filter_option_checkbox_suffix}
            ${staus}    Get Checkbox State    ${locator}  
            Run Keyword And Continue On Failure    Should Not Be True    ${staus}    msg=Checkbox for option ${Option} is not selected    
            ${clicked}=    Run Keyword And Return Status    Click    ${locator}
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
            press Keys    ${Filter_locator}    Escape
            Sleep    2s
            ${Transaction_element}    Get Elements    ${Cell_value_locator}
            Should Not Be Empty    ${Transaction_element}    The filter option is not working fine for this column : ${Column_header} and This value ${Option} 
            FOR    ${element}    IN    @{Transaction_element}
                ${value}    Get Text    ${element}
                ${value}    strip String    ${value}
                Run Keyword And Continue On Failure    Should Contain    ${value}    ${Option}    msg=Filtered value ${value} is still displayed after unchecking ${Option} option
            END
                Click    ${Filter_locator}
                ${clicked}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
                press Keys    ${Filter_locator}    Escape
                
        END
    Log    Expected Options: ${expected_options_value}
    Log    Actual Options: ${Actual_options}
    # ${status}    Run Keyword And Return Status    Should Be Equal    ${Actual_options}    ${expected_options}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    TransactionType option are mismatch in allsummission page        




  
verify the Checkbox Type filter in Convr Task page
    [Documentation]    This method is used to verify the Transation Type filter in Convr Submission page
    [Arguments]    ${Column_header}    ${expected_options}        
    Switch to Convr Task tab
    Sleep    2s
    select the Options as per given data in Submission page    All tasks
    sleep    2s
    Rearrange Submission Page Columns    ${Column_header}
    ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
    ${Cell_value_element}    Get Elements    ${Cell_value_locator}
    ${Count}    Get Length    ${Cell_value_element}
    ${Actual_options_value}    Create List
    FOR    ${element}    IN RANGE    0    ${Count}
        ${text}    Get Text    ${Cell_value_element}[${element}]
        strip String    ${text}
        Run Keyword If    '${text}' == ' '    Continue For Loop
        Run Keyword If    '${text}' == ''    Continue For Loop

        ${has_comma}=    Run Keyword And Return Status    Should Contain    ${text}    ,

        IF    ${has_comma}
        ${items}=    Split String    ${text}    , 
            FOR    ${item}    IN    @{items}
                ${clean}=    Strip String    ${item}
                Append To List    ${Actual_options_value}    ${clean}
            END
        ELSE
            ${clean}=    Strip String    ${text}
             Append To List    ${Actual_options_value}    ${clean}
        END
    END
    ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}
    Log    ${Actual_options_value}
    ${Filter_locator}    Catenate    SEPARATOR=    ${filter_apply_button_prefix}    ${expected_options}    ${filter_apply_button_suffix} 
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Filter_locator}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter button is not visible
    ${clicked}=    Run Keyword And Return Status    Click    ${Filter_locator}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Account filter button
    ${options_elements}    Get Elements    ${Transaction_type_options}
    ${Actual_options}    Create List
    FOR    ${element}    IN    @{options_elements}
        ${option_text}    Get Text    ${element}
        strip String    ${option_text}
        Append To List    ${Actual_options}    ${option_text}
    END
    FOR    ${element}    IN    @{Actual_options}
        ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${element}    ${Filter_option_checkbox_suffix}
        ${staus}    Get Checkbox State    ${locator}  
        IF    '${staus}' == 'True'
            Uncheck Checkbox    ${locator}    
        END
    END
            Press Keys    ${Filter_locator}    Escape
        FOR    ${Option}    IN    @{Actual_options_value}   
            Click    ${Filter_locator}
            Fill Text    ${check_box_filter_field}    ${Option}
            ${locator}    Catenate    SEPARATOR=    ${Filter_option_checkbox}    ${Option}    ${Filter_option_checkbox_suffix}
            ${staus}    Get Checkbox State    ${locator}  
            Run Keyword And Continue On Failure    Should Not Be True    ${staus}    msg=Checkbox for option ${Option} is not selected    
            ${clicked}=    Run Keyword And Return Status    Click    ${locator}
            Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
            press Keys    ${Filter_locator}    Escape
            Sleep    2s
            ${Transaction_element}    Get Elements    ${Cell_value_locator}
            FOR    ${element}    IN    @{Transaction_element}
                ${value}    Get Text    ${element}
                ${value}    strip String    ${value}
                Run Keyword And Continue On Failure    Should Contain    ${value}    ${Option}    msg=Filtered value ${value} is still displayed after unchecking ${Option} option
            END
                Click    ${Filter_locator}
                ${clicked}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Could not uncheck checkbox for option ${element}
                press Keys    ${Filter_locator}    Escape
        
        END
    Log    Expected Options: ${expected_options}
    Log    Actual Options: ${Actual_options}
    # ${status}    Run Keyword And Return Status    Should Be Equal    ${Actual_options}    ${expected_options}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    TransactionType option are mismatch in allsummission page        

Verify the filter option in Convr Task page
    [Documentation]    This method is used to verify the Account filter in Convr Submission page
    [Arguments]    ${Column_header}    ${expected_options}        
    Switch to Convr Task tab
    Sleep    2s
    select the Options as per given data in Submission page    All tasks
    Sleep    2s
    Rearrange Submission Page Columns    ${Column_header}
    ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
    ${Cell_value_element}    Get Elements    ${Cell_value_locator}
    ${Count}    Get Length    ${Cell_value_element}
    ${Actual_options_value}    Create List
    FOR    ${element}    IN RANGE    0    ${Count}
        ${option_text}    Get Text    ${Cell_value_element}[${element}]
        strip String    ${option_text}
        Run Keyword If    '${option_text}' == ' '    Continue For Loop
        Append To List    ${Actual_options_value}    ${option_text}
        # ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}
    END
    ${Actual_options_value}=    Remove Duplicates    ${Actual_options_value}

    FOR    ${fill_value}    IN    @{Actual_options_value}
        ${locator}    Catenate    SEPARATOR=    ${filter_apply_button_prefix}    ${expected_options}    ${filter_apply_button_suffix} 
        ${status}    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter button is not visible
        ${clicked}=    Run Keyword And Return Status    Click    ${locator}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Account filter button
        ${status}    Run Keyword And Return Status    Wait For Elements State    ${Filter_input}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    should be True    ${status}    msg=Account filter input is not visible
        ${status}    Run Keyword And Return Status    fill Text    ${Filter_input}    ${fill_value}
        should be True    ${status}    msg=Could not fill text in Account filter input
        Sleep    2s
        Press Keys    ${locator}    Escape
        Sleep    2s
        ${Cell_value_locator}    Catenate    SEPARATOR=    ${Cell_value}    ${expected_options}']
        ${Cell_value_element}    Get Elements    ${Cell_value_locator}
        Should Not Be Empty    ${Cell_value_element}    filter is not working fine for is header : ${Column_header} on this value ${fill_value} 
        ${Actual_options}    Create List
            FOR    ${element}    IN    @{Cell_value_element}
                ${option_text}    Get Text    ${element}
                strip String    ${option_text}
                Append To List    ${Actual_options}    ${option_text}
                
            END
            ${Actual_options}=    Remove Duplicates    ${Actual_options}
            FOR    ${Actual_value}    IN    @{Actual_options}
            Log    ${Actual_value}
            log    ${fill_value}
            ${status}    Run Keyword And Return Status    Should Contain    ${Actual_value}    ${fill_value}    msg=Filtered value ${Actual_value} does not match expected value ${fill_value} filter option is not working as expected
            Run Keyword And Continue On Failure    should be True    ${status}    msg=Filtered value ${Actual_value} does not match expected value ${fill_value} : filter option is not working as expected
            END

    END
# Wait For Processing Stage
#     [Documentation]    Waits for the processing stage (or rejection stage) to be completed and hidden.
#     ...    This keyword checks whether the submission is still processing and waits until it completes or times out.
#     ...
#     ...    *Arguments:*
#     ...    - `${stageNo}`: Optional. The specific stage number to wait for. If not provided, waits for the default processing stage.
#     [Arguments]    ${stageNo}=''
#     Click Answers Tab
#     Switch To Documents
#     Sleep    5s
#     IF    ${stageNo} == ''
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ')]

#     ELSE
#         ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]

#     END

#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${display_timeout}
#     ${rejectStatus}=    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    visible    timeout=${display_timeout}

#     IF    ${status}
#         Switch to Summary
#         ${summaryVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Processing}    attached    timeout=${display_timeout}
#         Run Keyword And Continue On Failure    Should Be True    ${summaryVisible}    msg=Summary processing message not visible.

#         ${ActualValue}=    Get Text    ${Summary_Processing}
#         Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Read-only while processing    msg=Summary processing message text mismatch.
#         Switch To Documents
#         Sleep    5s
#         ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
#         Run Keyword And Continue On Failure    Should Be True    ${status}    Processing stage ${stageNo} did not complete within ${processing_stage_timeout} seconds. The submission is still processing.
#         IF    not ${status}
#             Log    ❌ Processing stage ${stageNo} is still visible after timeout. Aborting test.
#             RETURN    False
#         ELSE
#             Log Step    ✅ Processing stage ${stageNo} completed successfully.
#         END

#     ELSE IF    ${rejectStatus}
#         Switch to Summary
#         ${summaryVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Processing}    visible    timeout=${display_timeout}
#         Should Be True    ${summaryVisible}    msg=Summary processing message not visible.

#         ${ActualValue}=    Get Text    ${Summary_Processing}
#         Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Read-only while processing    msg=Summary processing message text mismatch.
#         Switch To Documents
#         Sleep    5s
#         ${status}=    Run Keyword And Return Status    Wait For Elements State    ${RejectProcessing}    hidden    timeout=${processing_stage_timeout}
#         Run Keyword And Continue On Failure    Should Be True    ${status}    Rejected processing stage did not complete within ${processing_stage_timeout} seconds. The submission is still processing.
#         IF    not ${status}
#             Log    ❌ Reject processing stage is still visible after timeout. Aborting test.
#             RETURN    False
#         ELSE
#             Log Step    ✅ Reject processing stage completed successfully.
#         END

#     ELSE
#         Log    ⚠️ Neither processing stage nor reject processing stage was Not found visible.

#     END

Verify the Coverage Drop Down values in the Clearance tab
    [Documentation]    This method is used to verify the Coverage Drop Down values in the Clearance tab
    [Arguments]    ${expected_product}    ${expected_product_segment}    ${Field_name}       
    Click And Verify Clearance Tab     
    Sleep    2s
    ${lengths}    Get Length    ${expected_product}
    FOR   ${index}    IN RANGE    0    ${lengths}
        ${product}    Get From List    ${expected_product}    ${index}
        # ${product_segment}    Get From Dictionary    ${expected_product_segment}    ${index}
        ${clicked}=    Run Keyword And Return Status    Click    ${CoverageProduct}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Coverage Tab: Failed to click Coverage Product dropdown.

        ${value}=    Catenate    SEPARATOR=    ${SelectNewValue}    ${product}    ']
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${value}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Coverage Tab: Product '${product}' is not visible in the dropdown.

        ${clicked_value}=    Run Keyword And Return Status    Click    ${value}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_value}    msg=Coverage Tab: Failed to select product '${product}' from the dropdown.

        ${escaped}=    Run Keyword And Return Status    Press Keys    ${CoverageProduct}    Escape
        Run Keyword And Continue On Failure    Should Be True    ${escaped}    msg=Coverage Tab: Failed to send Escape key to Coverage Product dropdown.
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${ProductSegmentValue}    visible    timeout=${element_timeout}
        Should Be True    ${visible}    msg=Coverage Tab: Product '${ProductSegmentValue}' is not visible in the 

        ${text}=    Get Text    ${ProductSegmentValue}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Coverage Tab: Failed to get text from Product Segment field.

        ${trimText}=    Strip String    ${text}

        Run Keyword And Continue On Failure    Should Be Equal    ${expected_product_segment}    ${trimText}    msg=Coverage Tab: Product Segment value '${trimText}' does not match expected '${expected_product_segment}'.
        ${state}=    Get Element States    ${Vessels_Add}
        Should Contain    ${state}    visible    msg=FAILURE: Vessels Add button is not visible.
        Should Contain    ${state}    enabled    msg=FAILURE: Vessels Add button is not enabled.
        FOR    ${option}    IN    @{Field_name}
            ${Remove_locator}    Catenate    SEPARATOR=    ${Clearance_remove_Button1}    ${option}    ${Clearance_remove_Button2}
            ${clicked_remove}=    Run Keyword And Return Status    Click    ${Remove_locator}
            Run Keyword And Continue On Failure    Should Be True    ${clicked_remove}    msg=Coverage Tab: Failed to remove option '${option}' from Coverage Drop Down.
        END
        ${state}=    Get Element States    ${Vessels_Add}
        Should Contain    ${state}    visible    msg=FAILURE: Vessels Add button is not visible.
        Should Contain    ${state}    disabled    msg=FAILURE: Vessels Add button is not disabled.

    END
    # ${options_elements}    Get Elements    ${Coverage_Drop_Down_Value}
    # ${Actual_options}    Create List
    # FOR    ${element}    IN    @{options_elements}
    #     ${option_text}    Get Text    ${element}
    #     strip String    ${option_text}
    #     Append To List    ${Actual_options}    ${option_text}
    # END
    # Press Keys    ${Coverage_dropdown}    Escape
    # Log    Expected Options: ${expected_options}
    # Log    Actual Options: ${Actual_options}
    # ${status}    Run Keyword And Return Status    Should Be Equal    ${Actual_options}    ${expected_options}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    Coverage Drop Down option are mismatch in clearance tab    

Verify the Dot summary list 
    [documentation]    This method is used to verify the Dot summary list in Answer tab
    [arguments]    ${Excepted_toolTip}
    # click Answers Tab
    ${status}    Run Keyword And Return Status    wait for Elements State    ${hazmat_haular_card}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Hazmat Haular card is not visible in Answers tab
    ${clicked}=    Run Keyword And Return Status    Click    ${hazmat_haular_card}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Hazmat Haular card in Answers tab
    ${status}    Run Keyword And Return Status    wait for Elements State    ${Hazmant_remove_icon}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg= Hazmant_remove_icon is not visible in Answers tab
    Mouse Move Relative To    ${Hazmant_remove_icon}
    ${status}    Run Keyword And Return Status    wait for Elements State    ${Hazmat_tooltip}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Hazmat_tooltip is not visible in Answers tab
    ${tooltip_text}=    Get Text    ${Hazmat_tooltip}
    strip String    ${tooltip_text}
    log    ${tooltip_text}
    log    ${Excepted_toolTip}
    Run Keyword And Continue On Failure    should be Equal    ${tooltip_text}    ${Excepted_toolTip}    msg=Tooltip text is not matching as expected in Answers tab
    
   