*** Settings ***
Resource     ../../utils/common_keywords.robot
Variables     ../locators/documents_locators.py

*** Variables ***
${path}             ${CURDIR}/../../uploads/
${DownloadPath}     ${CURDIR}/../../downloads/
${testDataPath}     ${CURDIR}/../../testdata/
${ActualClaimsFileName}     ActualClaims.xlsx
${ExpectedClaimsFileName}     ExpectedClaims.xlsx
${ActualPoliciesFileName}     ActualPolicies.csv
${ExpectedPoliciesFileName}     ExpectedPolicies.csv
${ActualSchemaFileName}     ActualSchema.json
${ExpectedSchemaFileName}     ExpectedSchema.json
# ${processing_stage_timeout}    1200s
# ${upload_procesing_timeout}    1800s
# ${element_timeout}    180s

*** Keywords ***
# Upload SOV and Loss Run Documents
#     [Documentation]    Uploads multiple documents (like SOV and Loss Run) to the submission.
#     ...
#     ...    *Arguments:*
#     ...    - `@{FileName}`: A list of file names to be uploaded from the `uploads` directory.
#     [Arguments]    @{FileName}
#     Switch to Documents
#     FOR    ${file}    IN    @{FileName}
#             ${AbsolutePath}=    Normalize Path    ${path}${file}
#             Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#             Sleep    2s
#     END
#     FOR    ${file}    IN    @{FileName}
#         ${isArchive} =   Run Keyword And Return Status    Get Element States    ${ArchiveIcon}    validate    value & visible    'ArchiveIcon should be visible.'
#         IF   ${isArchive}
#             # ${AbsolutePath}=    Normalize Path    ${path}${file}
#             ${ArchieveFile}=    Catenate    SEPARATOR=    ${ArchiveButton1}    ${file}    ${ArchiveButton2}
#             Click    ${ArchieveFile}
#             Sleep    2s
#         END
#     END
#     Wait For Element With Message    UploadButton    ${UploadButton}    visible    Wait for the Upload button and verify that the SOV file and Loss Run file can be uploaded.
#     Click    ${UploadButton}
Upload SOV and Loss Run Documents
    [Documentation]    Uploads multiple documents (like SOV and Loss Run) to the submission.
    [Arguments]    @{FileName}

    Switch to Documents

    FOR    ${file}    IN    @{FileName}
        ${AbsolutePath}=    Normalize Path    ${path}${file}
        ${status}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to upload file: ${file}.
        Sleep    2s
    END

    FOR    ${file}    IN    @{FileName}
        ${isArchive}=    Run Keyword And Return Status    Get Element States    ${ArchiveIcon}    validate    value & visible    'ArchiveIcon is not visible.'
        IF    ${isArchive}
            ${ArchieveFile}=    Catenate    SEPARATOR=    ${ArchiveButton1}    ${file}    ${ArchiveButton2}
            ${status}=    Run Keyword And Return Status    Click    ${ArchieveFile}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to archive file: ${file}.
            Sleep    2s
        END
    END

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UploadButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Upload button did not appear after uploading files: ${FileName}.

    ${status}=    Run Keyword And Return Status    Click    ${UploadButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click the Upload button after uploading files: ${FileName}.


Wait for Upload to Complete
    [Documentation]    Waits for the document upload and processing to complete.
    ...    It monitors several processing indicators to ensure all background tasks are finished.
    ${Status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    visible    timeout=${element_timeout}
    Should Be True    ${Status}   Document upload processing did not start as expected after uploded the file    
    ${Status}    Run Keyword And Return Status    Wait For Elements State    ${processingStage2}    hidden    timeout=600s
    Should Be True    ${Status}    Document upload processing did not Completed as expected after uploded the file    
    ${Status}    Run Keyword And Return Status    Wait For Elements State    ${LossRunProcessing}    detached    timeout=600s
    Should Be True    ${Status}    Loss Run file processing did not Completed as expected after uploded the file
    ${Status}    Run Keyword And Return Status    Wait For Elements State    ${LossRunFile}    visible    timeout=120s
    Should Be True    ${Status}    Loss Run file is not visible as expected after uploded the file
# Verify Claims Data From Loss Run File
#     [Documentation]    Downloads the claims data (as an Excel file) extracted from the Loss Run document and compares it with an expected data file.
#     ...    It ignores certain columns that may contain dynamic data (like row IDs or coordinates).
#     Switch To Documents
#     Scroll To Element    ${LossRunFile}
#     Get Element States    ${LossRunFile}    validate    enabled    'LossRunFile should be enabled.'
#     Click    ${LossRunFile}
#     Wait For Element With Message    Claims    ${Claims}    visible    Wait for the claims and verify the claim data from the loss run file
#     Click    ${Claims}
#     Wait For Element With Message    DownloadDropdown    ${DownloadDropdown}    visible    Wait for the downloadDropdown and verify that it is present for the loss run file.
#     Click    ${DownloadDropdown}
#     Wait For Element With Message    DownloadData    ${DownloadData}    visible    Wait for the download option and verify that it is present for the loss run file.
#     ${promise}    Promise To Wait For Download    ${DownloadPath}${ActualClaimsFileName}
#     Click    ${DownloadData}
#     ${fileObject}    Wait For     ${promise}
#     File Should Exist    ${fileObject}[saveAs]
#     ${cols_to_ignore}=    Create List    row_id    x1    x2    y1    y2
#     Compare Excel Files    ${testDataPath}${ExpectedClaimsFileName}    ${DownloadPath}${ActualClaimsFileName}    ignore_columns=${cols_to_ignore}
Verify Claims Data From Loss Run File
    [Documentation]    Downloads the claims data (as an Excel file) extracted from the Loss Run document and compares it with an expected data file.
    ...    It ignores certain columns that may contain dynamic data (like row IDs or coordinates).

    Switch To Documents

    ${status}=    Run Keyword And Return Status    Scroll To Element    ${LossRunFile}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to Loss Run file.

    ${status}=    Run Keyword And Return Status    Get Element States    ${LossRunFile}    validate    enabled
    Run Keyword And Continue On Failure    Should Be True    ${status}    LossRunFile should be enabled.

    ${status}=    Run Keyword And Return Status    Click    ${LossRunFile}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Loss Run file.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Claims}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Claims element is not visible; cannot verify claim data.

    ${status}=    Run Keyword And Return Status    Click    ${Claims}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Claims element.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadDropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Download dropdown is not visible for the Loss Run file.

    ${status}=    Run Keyword And Return Status    Click    ${DownloadDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Download dropdown.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadData}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Download option is not visible for the Loss Run file.

    ${promise}=    Promise To Wait For Download    ${DownloadPath}${ActualClaimsFileName}

    ${status}=    Run Keyword And Return Status    Click    ${DownloadData}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Download option for Loss Run file.

    ${fileObject}=    Wait For    ${promise}

    ${status}=    Run Keyword And Return Status    File Should Exist    ${fileObject}[saveAs]
    Run Keyword And Continue On Failure    Should Be True    ${status}    Downloaded Loss Run file does not exist at expected path.

    ${cols_to_ignore}=    Create List    row_id    x1    x2    y1    y2

    # ${status}=    Run Keyword And Return Status    Compare Excel Files    ${testDataPath}${ExpectedClaimsFileName}    ${DownloadPath}${ActualClaimsFileName}    ignore_columns=${cols_to_ignore}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Documents Tab: Uploaded Claims data in downloaded Loss Run file does not match expected file.
    ${status}    ${details}=    Compare Excel Files    ${testDataPath}${ExpectedClaimsFileName}    ${DownloadPath}${ActualClaimsFileName}    ignore_columns=${cols_to_ignore}
    IF    '${status}' == 'False'
        Fail    ❌ FAILED: Documents Tab – Uploaded Loss Run Claims data does not match expected file.\n${details}
    END

# Verify Policies Data From Loss Run File
#     [Documentation]    Downloads the policies data (as a CSV file) from the Loss Run document and compares it with an expected data file.
#     Switch To Documents
#     Scroll To Element    ${LossRunFile}
#     Get Element States    ${LossRunFile}    validate    enabled    'LossRunFile should be enabled.'
#     Click    ${LossRunFile}
#     # Wait For Elements State    ${Policies}    visible
#     Wait For Element With Message    Policies    ${Policies}    visible
#     Click    ${Policies}
#     # Wait For Elements State    ${DownloadDropdown}    visible
#     Wait For Element With Message    DownloadDropdown    ${DownloadDropdown}    visible
#     Click    ${DownloadDropdown}
#     # Wait For Elements State    ${DownloadData}    visible
#     Wait For Element With Message    DownloadData    ${DownloadData}    visible
#     ${promise}    Promise To Wait For Download    ${DownloadPath}${ActualPoliciesFileName}
#     Click    ${DownloadData}
#     ${fileObject}    Wait For     ${promise}
#     File Should Exist    ${fileObject}[saveAs]
#     Compare Excel Files    ${testDataPath}${ExpectedPoliciesFileName}    ${DownloadPath}${ActualPoliciesFileName}
Verify Policies Data From Loss Run File
    [Documentation]    Downloads the policies data (as a CSV file) from the Loss Run document and compares it with an expected data file.
    ...    Switches to the Documents tab, opens the Loss Run file, downloads the policies data, waits for download, and validates the file exists and matches expected data.
    [Arguments]

    Switch To Documents

    ${status}=    Run Keyword And Return Status    Scroll To Element    ${LossRunFile}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to the LossRun file.

    ${status}=    Run Keyword And Return Status    Get Element States    ${LossRunFile}    validate    enabled
    Run Keyword And Continue On Failure    Should Be True    ${status}    LossRunFile is not enabled.

    ${status}=    Run Keyword And Return Status    Click    ${LossRunFile}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on the LossRun file.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Policies}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Policies element did not become visible in Loss Run file.

    ${status}=    Run Keyword And Return Status    Click    ${Policies}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Policies in Loss Run file.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadDropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Download dropdown did not appear for Policies.

    ${status}=    Run Keyword And Return Status    Click    ${DownloadDropdown}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Download dropdown for Policies.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadData}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Download data option did not appear for Policies.

    ${promise}=    Run Keyword And Return Status    Promise To Wait For Download    ${DownloadPath}${ActualPoliciesFileName}
    Run Keyword And Continue On Failure    Should Be True    ${promise} != None    Failed to initiate download promise for Policies file.

    ${status}=    Run Keyword And Return Status    Click    ${DownloadData}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click DownloadData to download Policies file.

    ${fileObject}=    Run Keyword And Return Status    Wait For    ${promise}
    Run Keyword And Continue On Failure    Should Be True    ${fileObject} != None    Policies file download did not complete successfully.

    # ${status}=    Run Keyword And Return Status    File Should Exist    ${fileObject}[saveAs]
    # Run Keyword And Continue On Failure    Should Be True    ${status}    Policies file does not exist after download.

    # ${status}=    Run Keyword And Return Status    Compare Excel Files    ${testDataPath}${ExpectedPoliciesFileName}    ${DownloadPath}${ActualPoliciesFileName}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    Policies file contents do not match the expected file.
    ${status}    ${details}=    Compare Excel Files    ${testDataPath}${ExpectedPoliciesFileName}    ${DownloadPath}${ActualPoliciesFileName}
    IF    '${status}' == 'False'
        Fail    ❌ FAILED: Documents Tab – Uploaded Loss Run Policies file contents do not match the expected file..\n${details}
    END
# Verify Analysis Data From Loss Run File
#     [Documentation]    Verifies the data displayed in the 'Analysis' section for a Loss Run file.
#     ...    It compares both the summary card data and the data in the main table with expected values.
#     ...
#     ...    *Arguments:*
#     ...    - `@{CardName}`: A list of labels for the summary cards to verify.
#     ...    - `@{expectedCardData}`: A list of expected string values for the summary cards.
#     ...    - `@{expectedTableData}`: A list of expected string values for the data in the analysis table.
#     [Arguments]    ${CardName}    ${expectedCardData}    ${expectedTableData}
#     Wait For Element With Message    Analysis    ${Analysis}    visible    Wait for the Analysis option and verify that it is present for the loss run file
#     ${actualAnalysisData}    Create List    
#     Click    ${Analysis}
#     FOR    ${data}    IN    @{CardName}
#         ${locator}    Catenate    SEPARATOR=    ${CardDatas1}    ${data}    ${CardDatas2}
#         # Wait For Elements State    ${locator}    visible
#         Wait For Element With Message    locator    ${locator}    visible
#         ${actualData}    Get Text    ${locator}
#         ${trimData}    Strip String    ${actualData}
#         Append To List    ${actualAnalysisData}    ${trimData}
#     END
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualAnalysisData}    ${expectedCardData}
#     ${tableData}    Get Elements    ${AnalysisTableData}
#     ${tableDatas}    Create List
#     FOR    ${data_value}    IN    @{tableData}
#         ${text}    Get Text    ${data_value}
#         ${trimmedData}    Strip String    ${text}
#         Append To List     ${tableDatas}    ${trimmedData}
#     END
#     Run Keyword And Continue On Failure    Should Be Equal    ${tableDatas}    ${expectedTableData}
Verify Analysis Data From Loss Run File
    [Documentation]    Verifies the data displayed in the 'Analysis' section for a Loss Run file.
    ...    Compares both the summary card data and the data in the main table with expected values.
    [Arguments]    ${CardName}    ${expectedCardData}    ${expectedTableData}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Analysis}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Analysis option is not visible for the Loss Run file.

    ${actualAnalysisData}=    Create List

    ${status}=    Run Keyword And Return Status    Click    ${Analysis}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on the Analysis option.

    FOR    ${data}    IN    @{CardName}
        ${locator}=    Catenate    SEPARATOR=    ${CardDatas1}    ${data}    ${CardDatas2}

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Document Tab: Uploaded Loss Run card '${data}' did not become visible.

        ${actualData}=    Get Text    ${locator}

        ${trimData}=    Strip String    ${actualData}
        Append To List    ${actualAnalysisData}    ${trimData}
    END

    ${status}=    Run Keyword And Return Status    Should Be Equal    ${actualAnalysisData}    ${expectedCardData}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Document Tab: Uploaded Loss Run card data does not match expected values. Actual: ${actualAnalysisData} | Expected: ${expectedCardData}

    ${status}=    Get Elements    ${AnalysisTableData}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${status}    Failed to get table data elements from Analysis table.
    ${tableData}=    Set Variable    ${status}

    ${tableDatas}=    Create List
    FOR    ${data_value}    IN    @{tableData}
        ${status}=    Get Text    ${data_value}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${status}    Failed to get text from table cell.
        ${text}=    Set Variable    ${status}

        ${trimmedData}=    Strip String    ${text}
        Append To List    ${tableDatas}    ${trimmedData}
    END

    ${status}=    Run Keyword And Return Status    Should Be Equal    ${tableDatas}    ${expectedTableData}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Analysis table data does not match expected values. Actual: ${tableDatas} | Expected: ${expectedTableData}


# Verify Schema by downloading the json file
#     [Documentation]    Downloads the submission schema as a JSON file and compares it with an expected schema file.
#     ...    This is used to validate the data structure of the submission.
#     ...    Handles both single values and list results from JSON queries.
#     ...    Examples:
#     ...    - Single value query: 'd3Submission.d3Company.name'
#     ...    - List query: 'd3Submission.d3Company.naics.*.code'
#     [Arguments]    ${queryList}    @{expectedModification}
#     Switch To Documents
#     Scroll To Element    ${DownloadSchema}
#     Get Element States    ${DownloadSchema}    validate    enabled    'DownloadSchema should be enabled.'
#     Click    ${DownloadSchema}
#     ${promise}    Promise To Wait For Download    ${DownloadPath}${ActualSchemaFileName}
#     ${fileObject}    Wait For     ${promise}
#     File Should Exist    ${fileObject}[saveAs]
    
#     # Verify file is not empty
#     ${size}    Get File Size    ${fileObject}[saveAs]
#     Run Keyword And Continue On Failure    Should Be True    ${size} > 0    Downloaded schema file is empty
    
#     ${actualDataInSchema}    Create List
#     FOR    ${query}    IN    @{queryList}
#         ${result}=    Get Json Value By Query    ${DownloadPath}${ActualSchemaFileName}    ${query}
        
#         # Handle both single values and lists
#         ${is_list}=    Evaluate    isinstance($result, list)
#         IF    ${is_list}
#             Log    Processing list result for query '${query}'
#             FOR    ${item}    IN    @{result}
#                 # Ensure all values are converted to strings and normalized
#                 ${strValue}=    Convert To String    ${item}
#                 ${trimmedItem}=    Strip String    ${strValue}
#                 Append To List    ${actualDataInSchema}    ${trimmedItem}
#             END
#         ELSE
#             Log    Processing single value for query '${query}'
#             # Ensure all values are converted to strings and normalized
#             ${strValue}=    Convert To String    ${result}
#             ${trimmedData}=    Strip String    ${strValue}
#             Append To List    ${actualDataInSchema}    ${trimmedData}
#         END
#     END
    
#     Log List    ${actualDataInSchema}    
    
#     # If expectedModification is provided, compare with actual data
#     ${expectedLength}    Get Length    ${expectedModification}
#     IF    ${expectedLength} > 0
#         ${actualLength}    Get Length    ${actualDataInSchema}
#         Run Keyword And Continue On Failure    Should Be Equal As Integers    ${actualLength}    ${expectedLength}    
#         ...    Actual and expected data length mismatch. Actual: ${actualLength}, Expected: ${expectedLength}
        
#         FOR    ${index}    ${expected}    IN ENUMERATE    @{expectedModification}
#             # Convert both values to strings for comparison
#             ${expectedStr}=    Convert To String    ${expected}
#             ${expectedTrimmed}=    Strip String    ${expectedStr}
#             # Remove surrounding quotes if present
#             ${expectedTrimmed}=    Evaluate    str('${expectedTrimmed}').strip('"').strip("'")
            
#             ${actualStr}=    Convert To String    ${actualDataInSchema}[${index}]
#             ${actualTrimmed}=    Strip String    ${actualStr}
#             # Remove surrounding quotes if present
#             ${actualTrimmed}=    Evaluate    str('${actualTrimmed}').strip('"').strip("'")
            
#             # Log the types and values being compared
#             Log    Comparing at index ${index}:
#             Log    Expected (${expectedTrimmed}) type: ${expectedStr.__class__.__name__}
#             Log    Actual (${actualTrimmed}) type: ${actualStr.__class__.__name__}
#             Log    After quote stripping - Expected: '${expectedTrimmed}', Actual: '${actualTrimmed}'
            
#             Run Keyword And Continue On Failure    Should Be Equal As Strings    ${actualTrimmed}    ${expectedTrimmed}    
#             ...    Mismatch at index ${index}. Expected: '${expectedTrimmed}', Actual: '${actualTrimmed}'
#         END
#     END
Verify Schema by downloading the json file
    [Documentation]    Downloads the submission schema as a JSON file and compares it with an expected schema file. Provides detailed failure messages.
    [Arguments]    ${queryList}    @{expectedModification}

    Switch To Documents

    Scroll To Element    ${DownloadSchema}
    ${schema_visible}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadSchema}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${schema_visible}    msg=Verify Schema: 'Download Schema' button is not visible. Cannot proceed.

    ${schema_enabled}=    Run Keyword And Return Status    Wait For Elements State    ${DownloadSchema}    enabled    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${schema_enabled}    msg=Verify Schema: 'Download Schema' button is not enabled. Cannot click.

    ${clicked}=    Run Keyword And Return Status    Click    ${DownloadSchema}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Schema: Failed to click 'Download Schema' button. Ensure it is visible and enabled.

    ${promise}=    Promise To Wait For Download    ${DownloadPath}${ActualSchemaFileName}
    ${fileObject}=    Wait For     ${promise}
    File Should Exist    ${fileObject}[saveAs]    msg=Verify Schema: Downloaded schema file does not exist at path: ${DownloadPath}${ActualSchemaFileName}

    ${size}=    Get File Size    ${fileObject}[saveAs]
    Run Keyword And Continue On Failure    Should Be True    ${size} > 0    msg=Verify Schema: Downloaded schema file is empty at path: ${DownloadPath}${ActualSchemaFileName}

    ${actualDataInSchema}=    Create List

    FOR    ${query}    IN    @{queryList}
        ${result}=    Get Json Value By Query    ${DownloadPath}${ActualSchemaFileName}    ${query}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${result}    msg=Verify Schema: Query '${query}' returned no result from JSON file.

        ${is_list}=    Evaluate    isinstance($result, list)
        IF    ${is_list}
            FOR    ${item}    IN    @{result}
                ${strValue}=    Convert To String    ${item}
                Run Keyword And Continue On Failure    Should Not Be Empty    ${strValue}    msg=Verify Schema: List item for query '${query}' is empty.
                ${trimmedItem}=    Strip String    ${strValue}
                Append To List    ${actualDataInSchema}    ${trimmedItem}
            END
        ELSE
            ${strValue}=    Convert To String    ${result}
            Run Keyword And Continue On Failure    Should Not Be Empty    ${strValue}    msg=Verify Schema: Query '${query}' returned an empty value.
            ${trimmedData}=    Strip String    ${strValue}
            Append To List    ${actualDataInSchema}    ${trimmedData}
        END
    END

    ${expectedLength}=    Get Length    ${expectedModification}
    IF    ${expectedLength} > 0
        ${actualLength}=    Get Length    ${actualDataInSchema}
        Run Keyword And Continue On Failure    Should Be Equal As Integers    ${actualLength}    ${expectedLength}    
        ...    msg=Verify Schema: Actual and expected data length mismatch. Actual: ${actualLength}, Expected: ${expectedLength}

        FOR    ${index}    ${expected}    IN ENUMERATE    @{expectedModification}
            ${expectedStr}=    Convert To String    ${expected}
            ${expectedTrimmed}=    Strip String    ${expectedStr}
            ${expectedTrimmed}=    Evaluate    str('${expectedTrimmed}').strip('"').strip("'")

            ${actualStr}=    Convert To String    ${actualDataInSchema}[${index}]
            ${actualTrimmed}=    Strip String    ${actualStr}
            ${actualTrimmed}=    Evaluate    str('${actualTrimmed}').strip('"').strip("'")

            Run Keyword And Continue On Failure    Should Be Equal As Strings    ${actualTrimmed}    ${expectedTrimmed}    
            ...    msg=Verify Schema: Value mismatch at index ${index}. Expected: '${expectedTrimmed}', Actual: '${actualTrimmed}'
        END
    END


# Verify WorkFlow History
#     [Documentation]    Verifies that the workflow history log contains a set of expected events or entries.
#     ...    It reads the entire history table and checks for the presence of each expected value. It skips date validation.
#     ...
#     ...    *Arguments:*
#     ...    - `@{expectedList}`: A list of strings that are expected to be found in the workflow history table.
#     [Arguments]    ${expectedList}
#     Switch to Documents
#     Click    ${WorkFLow_History}
#     Sleep    3s
#     ${tableRows}    Get Element Count   //tbody//tr
#     Log    ${tableRows}
#     @{actualText}    Create List  
#     FOR    ${index}    IN RANGE    1    ${tableRows + 1} 
#         ${td}    Get Elements     //tbody//tr[${index}]//td[not(ul)]|//tbody//tr[${index}]//td//ul/li
#         ${row_items_count}    Get Length    ${td}
#         FOR    ${td_index}    IN RANGE    ${row_items_count}
#             ${text}    Get Text    ${td}[${td_index}]
#             ${trimValue}    Strip String    ${text}
#             # First column (index 0) in each row is a date
#             IF    ${td_index} == 0
#                 Log    >${trimValue}<
#                 ${is_valid_date}    Run Keyword And Return Status    Should Match Regexp    ${trimValue}    ^[A-Za-z]{3}, [A-Za-z]{3} \\d{1,2} \\d{4}, \\d{2}:\\d{2}:\\d{2} [A-Z]{3}(?:[+-]\\d{1,2}:\\d{2})?$
#             ELSE
#                 Append To List    ${actualText}    ${trimValue}
#             END
#         END
#     END
#     Log    ${actualText}
#     Log    ${expectedList}
#     FOR    ${expected_value}    IN    @{expectedList}
#         Log    ${expected_value}
#         List Should Contain Value    ${actualText}    ${expected_value}    msg=Workflow history data mismatch - Missing expected value: ${expected_value}
#     END
Verify WorkFlow History
    [Documentation]    Verifies that the workflow history log contains all expected events or entries.
    ...    Reads the entire history table, checks each cell for expected values, and skips date validation.
    ...
    ...    *Arguments:*
    ...    - `@{expectedList}`: List of expected strings to verify in the workflow history table.
    [Arguments]    ${expectedList}

    # Switch to Documents tab
    Switch to Documents
    # Capture Custom Screenshot    before clcik workflow history
    # Open Workflow History
    Sleep    5s
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${WorkFLow_History}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Workflow history Button in Documents page did not become visible within the timeout '${element_timeout}'.'
    # Run Keyword And Continue On Failure    Wait For Elements State    ${WorkFLow_History}    visible    timeout=${element_timeout}
    # Click    ${WorkFLow_History}
    ${status}=    Run Keyword And Return Status    Click    ${WorkFLow_History}
    Should Be True    ${status}    'Unable to click Workflow history Button in Documents page within the timeout '${element_timeout}'.'
    Sleep    5s
    # Capture Custom Screenshot    after clcik workflow history
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${WorkFlowHistoryPage}    visible    timeout=${element_timeout}
    Should Be True    ${status}    'Workflow history section in Documents page did not become visible within the timeout '${element_timeout}'.'
    Sleep    3s    msg=Wait for workflow history table to load.

    # Get all table rows
    ${tableRows}=    Get Element Count    //tbody//tr
    Log Step    Total workflow history rows found -> ${tableRows}
    @{actualText}=    Create List

    # Iterate over each row
    FOR    ${index}    IN RANGE    1    ${tableRows + 1}
        ${td}=    Get Elements    //tbody//tr[${index}]//td[not(ul)]|//tbody//tr[${index}]//td//ul/li
        ${row_items_count}=    Get Length    ${td}
        FOR    ${td_index}    IN RANGE    ${row_items_count}
            ${text}=    Get Text    ${td}[${td_index}]
            ${trimValue}=    Strip String    ${text}

            # Skip date column validation (index 0)
            IF    ${td_index} == 0
                Log Step    Skipping date column -> ${trimValue}
                ${is_valid_date}=    Run Keyword And Return Status    Should Match Regexp    ${trimValue}    ^[A-Za-z]{3}, [A-Za-z]{3} \d{1,2} \d{4}, \d{2}:\d{2}:\d{2} [A-Z]{3}(?:[+-]\d{1,2}:\d{2})?$    
                # ${is_valid_date}    Run Keyword And Return Status    Should Match Regexp    ${trimValue}    ^[A-Za-z]{3}, [A-Za-z]{3} \\d{1,2} \\d{4}, \\d{2}:\\d{2}:\\d{2} [A-Z]{3}(?:[+-]\\d{1,2}:\\d{2})?$
                # Run Keyword Unless    ${is_valid_date}    Log Step    Warning: Date format mismatch in workflow history row ${index} column 0 -> ${trimValue}
            ELSE
                Append To List    ${actualText}    ${trimValue}
            END
        END
    END

    Log Step    Actual workflow history values -> ${actualText}
    Log Step    Expected workflow history values -> ${expectedList}

    # Verify each expected value is present in the actual table data
    FOR    ${expected_value}    IN    @{expectedList}
        ${status}=    Run Keyword And Return Status    List Should Contain Value    ${actualText}    ${expected_value}
        Should Be True    ${status}    Workflow history data mismatch - Missing expected value: '${expected_value}'
    END

# Wait for Upload to Complete for SOV and Loss Run
#     [Documentation]    Waits for the document upload and processing to complete.
#     ...    It monitors several processing indicators to ensure all background tasks are finished.
#     [Arguments]    ${stageNo}
#     ${stage}    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]
#     # Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
#     Wait For Element With Message    stage    ${stage}    visible
#     # Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
#     Wait For Element With Message    stage    ${stage}    hidden    The Upload is still processing even after ${processing_stage_timeout} seconds.    timeout=${processing_stage_timeout}
#     # Wait For Elements State    ${LossRunProcessing}    detached    timeout=${processing_stage_timeout}
#     Wait For Element With Message    LossRunProcessing    ${LossRunProcessing}    detached    The Upload is still processing even after ${processing_stage_timeout} seconds.    timeout=${processing_stage_timeout}
#     # Wait For Elements State   ${LossRunFile}    visible    timeout=${element_timeout}
#     Wait For Element With Message    LossRunFile    ${LossRunFile}    visible    The Upload is still processing even after ${processing_stage_timeout} seconds.    timeout=${processing_stage_timeout}
Wait for Upload to Complete for SOV and Loss Run
    [Documentation]    Waits for the document upload and processing to complete.
    ...    It monitors several processing indicators to ensure all background tasks are finished.
    [Arguments]    ${stageNo}

    ${stage}=    Catenate    SEPARATOR=    ${processingStage}    ${stageNo}    ')]

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Stage ${stageNo} did not appear for processing.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${stage}    hidden    timeout=${processing_stage_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    The Upload is still processing after ${processing_stage_timeout} seconds for stage ${stageNo}.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${LossRunProcessing}    detached    timeout=${processing_stage_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    LossRunProcessing is still visible after ${processing_stage_timeout} seconds.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${LossRunFile}    visible    timeout=${element_timeout}
    Should Be True    ${status}    LossRunFile is not visible after processing completed.
    
# Verify Schema section is available in Documents Page
#     [Documentation]    Verifies that the schema section is available in the documents page.
#     Switch to Documents
#     ${status}    Run Keyword And Return Status    Wait For Elements State    ${SchemaSection}    visible    timeout=${element_timeout}    
#     Run Keyword And Continue On Failure    Should Be True    ${status}
#     Click    ${SchemaSection}
#     # Wait For Elements State   ${SchemaJson}    visible    timeout=${element_timeout}
#     Wait For Element With Message    SchemaJson    ${SchemaJson}    visible
Verify Schema section is available in Documents Page
    [Documentation]    Verifies that the schema section is available in the Documents page.
    
    Switch to Documents

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SchemaSection}    visible    timeout=${element_timeout}

    Run Keyword And Continue On Failure    Should Be True    ${status}    Schema section is not visible in the Documents page.

    ${status}=    Run Keyword And Return Status    Click    ${SchemaSection}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on the Schema section in the Documents page.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SchemaJson}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Schema JSON content did not become visible in the Documents page.
    
# Remove Document after Upload
#     [Documentation]    Uploads multiple documents (like SOV and Loss Run) to the submission.
#     ...
#     ...    *Arguments:*
#     ...    - `@{FileName}`: A list of file names to be uploaded from the `uploads` directory.
#     [Arguments]    @{FileName}
#     Switch to Documents
#     FOR    ${file}    IN    @{FileName}
#             ${AbsolutePath}=    Normalize Path    ${path}${file}
#             Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#             Sleep    2s
#     END
#     FOR    ${file}    IN    @{FileName}
#             # ${AbsolutePath}=    Normalize Path    ${path}${file}
#             ${isArchive} =   Run Keyword And Return Status    Get Element States    ${ArchiveIcon}    validate    value & visible    'ArchiveIcon should be visible.'
#             IF   ${isArchive}
#             ${ArchieveFile}=    Catenate    SEPARATOR=    ${ArchiveButton1}    ${file}    ${ArchiveButton2}
#             Click    ${ArchieveFile}
#             Sleep    2s
#             END
#     END
#     FOR    ${file}    IN    @{FileName}
#      ${remove}    Catenate    SEPARATOR=    ${CloseIconInDocumentsPrefix}    ${file}    ${CloseIconInDocumentsSuffix}
           
#             ${isPDF} =  Run Keyword And Return Status    Should Contain    ${file}    pdf   
#             ${isExcel} =  Run Keyword And Return Status    Should Contain    ${file}    xls 
#             IF    ${isPDF}
#                 Run Keyword And Continue On Failure     Get Element States    ${PDFIcon}    Validate    value & visible
#                  Click    ${remove}
#                 Run Keyword And Continue On Failure     Get Element States    ${remove}    Validate    hidden    'Remove button should be visible for PDF file.'
#                 Sleep    1s
#                 Run Keyword And Continue On Failure    Get Element States    ${PDFIcon}    Validate    hidden 
#             ELSE IF    ${isExcel}
#                 Run Keyword And Continue On Failure    Get Element States    ${ExcelIcon}    Validate    value & visible
#                 Click    ${remove}
#                 Run Keyword And Continue On Failure    Get Element States    ${remove}    Validate    hidden    'Remove button should be visible for Excel file.'
#                Sleep    1s
#                 Run Keyword And Continue On Failure    Get Element States    ${ExcelIcon}    Validate    hidden
#             END
#         END
Remove Document after Upload
    [Documentation]    Uploads multiple documents (like SOV and Loss Run) and removes them to verify upload/remove functionality.
    [Arguments]    @{FileName}

    # Step 1: Switch to Documents tab
    Run Keyword And Continue On Failure    Switch to Documents

    # Step 2: Upload each file
    FOR    ${file}    IN    @{FileName}
        ${AbsolutePath}=    Normalize Path    ${path}${file}
        ${status}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to upload file: ${file}.
        Sleep    2s
    END

    # Step 3: Archive each file if Archive icon is present
    FOR    ${file}    IN    @{FileName}
        ${isArchive}=    Run Keyword And Return Status    Get Element States    ${ArchiveIcon}    validate    value & visible    ArchiveIcon is not be visible.
        IF    ${isArchive}
            ${ArchiveFile}=    Catenate    SEPARATOR=    ${ArchiveButton1}    ${file}    ${ArchiveButton2}
            ${status}=    Run Keyword And Return Status    Click    ${ArchiveFile}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to archive file: ${file}.
            Sleep    2s
        END
    END

    # Step 4: Remove each uploaded file and validate icons disappear
    FOR    ${file}    IN    @{FileName}
        ${remove}=    Catenate    SEPARATOR=    ${CloseIconInDocumentsPrefix}    ${file}    ${CloseIconInDocumentsSuffix}
        ${isPDF}=    Run Keyword And Return Status    Should Contain    ${file}    pdf
        ${isExcel}=    Run Keyword And Return Status    Should Contain    ${file}    xls

        IF    ${isPDF}
            Run Keyword And Continue On Failure    Get Element States    ${PDFIcon}    validate    value & visible    PDF icon should be visible for file: ${file}.
            ${status}=    Run Keyword And Return Status    Click    ${remove}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click remove button for PDF file: ${file}.
            Run Keyword And Continue On Failure    Get Element States    ${remove}    validate    hidden    Remove button should be hidden for PDF file: ${file}.
            Run Keyword And Continue On Failure    Get Element States    ${PDFIcon}    validate    hidden    PDF icon should be hidden after removal for file: ${file}.
            Sleep    1s
        ELSE IF    ${isExcel}
            Run Keyword And Continue On Failure    Get Element States    ${ExcelIcon}    validate    value & visible    Excel icon should be visible for file: ${file}.
            ${status}=    Run Keyword And Return Status    Click    ${remove}
            Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click remove button for Excel file: ${file}.
            Run Keyword And Continue On Failure    Get Element States    ${remove}    validate    hidden    Remove button should be hidden for Excel file: ${file}.
            Run Keyword And Continue On Failure    Get Element States    ${ExcelIcon}    validate    hidden    Excel icon should be hidden after removal for file: ${file}.
            Sleep    1s
        END
    END



Verify Log History
    [Documentation]    Verifies that the Log history  contains a set of expected events or entries.
    ...    It reads the entire history table and checks for the presence of each expected value. It skips date validation.
    ...
    ...    *Arguments:*
    ...    - `@{expectedList}`: A list of strings that are expected to be found in the workflow history table.
    [Arguments]    ${expectedList}
    Switch to Documents
    Click    ${Documents_Logs}
    Sleep    3s
    ${tableRows}    Get Element Count   //tbody//tr
    Log    ${tableRows}
    @{actualText}    Create List  
    FOR    ${index}    IN RANGE    1    ${tableRows + 1} 
        ${td}    Get Elements     //tbody//tr[${index}]//td[not(ul)]|//tbody//tr[${index}]//td//ul/li
        ${row_items_count}    Get Length    ${td}
        FOR    ${td_index}    IN RANGE    ${row_items_count}
            ${text}    Get Text    ${td}[${td_index}]
            ${trimValue}    Strip String    ${text}
            # First column (index 0) in each row is a date
            IF    ${td_index} == 0
                Log    >${trimValue}<
                ${is_valid_date}    Run Keyword And Return Status    Should Match Regexp    ${trimValue}    ^[A-Za-z]{3}, [A-Za-z]{3} \\d{1,2} \\d{4}, \\d{2}:\\d{2}:\\d{2} [A-Z]{3}(?:[+-]\\d{1,2}:\\d{2})?$
            ELSE
                Append To List    ${actualText}    ${trimValue}
            END
        END
    END
    Log    ${actualText}
    Log    ${expectedList}
    FOR    ${expected_value}    IN    @{expectedList}
        Log    ${expected_value}
        List Should Contain Value    ${actualText}    ${expected_value}    msg=Workflow history data mismatch - Missing expected value: ${expected_value}
    END

Verify Email Body Document
    [Documentation]    This method is used to verify the Email Body Documents
    [Arguments]    ${expected_body_Msg}    

    Switch to Documents
    Scroll To Element    ${Email_Body_Doc}
    Click    ${Email_Body_Doc}
    ${text1}=    Get Text    ${Email_Body_msg}

    # Normalize actual text (remove newlines, collapse spaces)
    ${actual_normalized}=    Replace String    ${text1}    \n    ${SPACE}
    ${actual_normalized}=    Replace String    ${actual_normalized}    \r    ${EMPTY}
    ${actual_normalized}=    Replace String Using Regexp    ${actual_normalized}    \\s+    ${SPACE}
    ${actual_normalized}=    Strip String    ${actual_normalized}

    # Normalize expected text (remove newlines, collapse spaces)
    ${expected_clean}=    Replace String    ${expected_body_Msg}    \n    ${SPACE}
    ${expected_clean}=    Replace String    ${expected_clean}    \r    ${EMPTY}
    ${expected_clean}=    Replace String Using Regexp    ${expected_clean}    \\s+    ${SPACE}
    ${expected_clean}=    Strip String    ${expected_clean}

    # Final check
    Run Keyword And Continue On Failure    Should Be Equal    ${expected_clean}    ${actual_normalized}

# Verify Download Snapshot in Document Tab

#     [Documentation]    This method verifies the Download Snapshot is visible in Document Tab and also verify the show/hidden the system generated documents
#     [Arguments]    ${Data}

#     Wait For Elements State    ${Document_options}    visible 
#     Click    ${Document_options}
#     Sleep    3s
#     ${ActualLocator}    Get Elements    ${Document_Options_Dropdown}
#     ${ActualHeader}    Create List
#     FOR    ${element}    IN    @{ActualLocator}
#         #Wait For Elements State    ${element}
#         ${ActualValue}    Get text    ${element}
#         Append To List    ${ActualHeader}    ${ActualValue}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Data['DocumentOption_Headers']}    ${ActualHeader}
#     Wait For Elements State    ${Show_Documents}    visible 
#     Click    ${Show_Documents}

#     ${Status}    Run Keyword And Return Status    Get Element States    ${Broker_ref_Lookup}    validate    value & visible
#     Run Keyword And Continue On Failure    Should Be True    ${Status}
#     Wait For Elements State    ${Document_options}    visible 
#     Click    ${Document_options}
#     Click    ${Show_Documents}
#     Wait For Elements State    ${Broker_ref_Lookup}    hidden

# Verify Download Snapshot in Document Tab

#     [Documentation]    This method verifies the Download Snapshot is visible in Document Tab and also verify the show/hidden the system generated documents
#     [Arguments]    ${Data}

#     # Wait For Elements State    ${Document_options}    visible 
#     Wait For Element With Message    Document_options    ${Document_options}    visible
#     Click    ${Document_options}
#     Sleep    3s
#     ${ActualLocator}    Get Elements    ${Document_Options_Dropdown}
#     ${ActualHeader}    Create List
#     FOR    ${element}    IN    @{ActualLocator}
#         #Wait For Elements State    ${element}
#         ${ActualValue}    Get text    ${element}
#         Append To List    ${ActualHeader}    ${ActualValue}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Data['DocumentOption_Headers']}    ${ActualHeader}
#     # Wait For Elements State    ${Show_Documents}    visible 
#     Wait For Element With Message    Show_Documents    ${Show_Documents}    visible
#     Click    ${Show_Documents}

#     ${Status}    Run Keyword And Return Status    Get Element States    ${Broker_ref_Lookup}    validate    value & visible
#     Run Keyword And Continue On Failure    Should Be True    ${Status}
#     # Wait For Elements State    ${Document_options}    visible 
#     Wait For Element With Message    Document_options    ${Document_options}    visible
#     Click    ${Document_options}
#     Wait For Element With Message    Show_Documents    ${Show_Documents}    visible
#     Click    ${Show_Documents}
#     # Wait For Elements State    ${Broker_ref_Lookup}    hidden
#     Wait For Element With Message    Broker_ref_Lookup    ${Broker_ref_Lookup}    visible
    
# Verify Download Snapshot in Document Tab
#     [Documentation]    Verifies that the Download Snapshot is visible in the Document Tab and validates the show/hide functionality for system-generated documents.
#     [Arguments]    ${Data}

#     # Open Document options
#     Click Answers Tab
#     Switch To Documents
#     Sleep    3s

#     # Get all dropdown elements and verify headers
#     ${ActualLocator}=    Get Elements    ${Document_Options_Dropdown}
#     ${ActualHeader}=    Create List
#     FOR    ${element}    IN    @{ActualLocator}
#         ${ActualValue}=    Get Text    ${element}
#         Append To List    ${ActualHeader}    ${ActualValue}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Data['DocumentOption_Headers']}    ${ActualHeader}    msg=Document dropdown headers do not match expected values.
    
#     ${click_doc_options}=    Run Keyword And Return Status    Click    ${Document_options}
#     Run Keyword And Continue On Failure    Should Be True    ${click_doc_options}    msg=Failed to click Document options for toggling show/hide.

#     # Show Documents
#     Run Keyword And Continue On Failure    Wait For Element With Message    Show_Documents    ${Show_Documents}    visible    msg='Show Documents' button not visible.
#     ${click_show}=    Run Keyword And Return Status    Click    ${Show_Documents}
#     Run Keyword And Continue On Failure    Should Be True    ${click_show}    msg=Failed to click 'Show Documents'.

#     # Verify Broker reference lookup is visible
#     ${status}=    Run Keyword And Return Status    Get Element States    ${Broker_ref_Lookup}    validate    value & visible
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Broker reference lookup is not visible after showing documents.

#     # Toggle Show/Hide Documents
#     Run Keyword And Continue On Failure    Wait For Element With Message    Document_options    ${Document_options}    visible    msg=Document options not visible for toggling show/hide.
#     ${click_doc_options}=    Run Keyword And Return Status    Click    ${Document_options}
#     Run Keyword And Continue On Failure    Should Be True    ${click_doc_options}    msg=Failed to click Document options for toggling show/hide.

#     Run Keyword And Continue On Failure    Wait For Element With Message    Show_Documents    ${Show_Documents}    visible    msg='Show Documents' button not visible for toggling.
#     ${click_show}=    Run Keyword And Return Status    Click    ${Show_Documents}
#     Run Keyword And Continue On Failure    Should Be True    ${click_show}    msg=Failed to toggle 'Show Documents'.

#     # Verify Broker reference lookup is hidden
#     Run Keyword And Continue On Failure    Wait For Element With Message    Broker_ref_Lookup    ${Broker_ref_Lookup}    hidden    msg=Broker reference lookup is still visible after hiding documents.
Verify Download Snapshot in Document Tab
    [Documentation]    Verifies the Download Snapshot visibility and Show/Hide functionality in Document tab.
    [Arguments]    ${Data}

    Click Answers Tab
    Switch To Documents
    Sleep    3s

    # Verify dropdown headers
    ${elements}=    Get Elements    ${Document_Options_Dropdown}
    ${ActualHeader}=    Create List
    FOR    ${e}    IN    @{elements}
        ${val}=    Get Text    ${e}
        Append To List    ${ActualHeader}    ${val}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Data['DocumentOption_Headers']}    ${ActualHeader}    msg=Document dropdown headers mismatch.

    # Click document options
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Document_options}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Document options not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${Document_options}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Document options.

    # Click Show Documents
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Show_Documents}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Show Documents' button not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${Show_Documents}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Show Documents'.

    # Verify Broker Reference Lookup becomes visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Broker_ref_Lookup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Broker reference lookup not visible after showing documents.

    # Toggle Show/Hide again
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Document_options}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Document options not visible.

    ${clicked}=    Run Keyword And Return Status    Click    ${Document_options}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Document options for toggle.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Show_Documents}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg='Show Documents' not visible for toggle.

    ${clicked}=    Run Keyword And Return Status    Click    ${Show_Documents}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to toggle Show/Hide Documents.

    # Verify lookup becomes hidden
    ${hidden}=    Run Keyword And Return Status    Wait For Elements State    ${Broker_ref_Lookup}    hidden    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${hidden}    msg=Broker reference lookup still visible after hiding documents.


# verify the Sov file are editable
#     [Documentation]    This method is used to verify the sov file are editable or not
#     [Arguments]
#     Click    ${SOV}
#     Click    ${Sov_Driver_option}
#     Click    ${Sov_addrow}
#     Set Viewport Size    2560    1440
#     ${cell}    Get Elements    ${sov_file_cell}
#     ${length}    Get Length    ${cell}
#     FOR    ${element}    IN RANGE    0    ${length}  
#     Scroll To Element    ${cell}[${element}]  
#         Click    ${cell}[${element}]
#         Click    ${cell}[${element}]
#        Type text    ${Cell_input}    Test
#     END
#     Click    ${Sov_save}
#     FOR    ${element}    IN RANGE    0    ${length}
#        ${text}    Get Text    ${cell}[${element}]
#         Run Keyword And Continue On Failure   Should Be Equal    ${text}    Test
#     END
#     Set Viewport Size    1280    720
#     Click Answers Tab

verify the Sov file are editable
    [Documentation]    Verifies that the SOV file cells are editable and that changes are saved correctly.
    [Arguments]
    Click Answers Tab
    Switch To Documents
    # Open SOV file and prepare for editing
    ${click_sov}=    Run Keyword And Return Status    Click    ${SOV}
    Run Keyword And Continue On Failure    Should Be True    ${click_sov}    msg=Failed to click on SOV file.

    ${click_driver}=    Run Keyword And Return Status    Click    ${Sov_Driver_option}
    Run Keyword And Continue On Failure    Should Be True    ${click_driver}    msg=Failed to click SOV driver option.

    ${click_addrow}=    Run Keyword And Return Status    Click    ${Sov_addrow}
    # Run Keyword And Continue On Failure    Should Be True    ${click_addrow}    msg=Failed to click 'Add Row' in SOV.

    Set Viewport Size    2560    1440

    # Get all SOV cells
    ${cell}=    Get Elements    ${sov_file_cell}
    ${length}=    Get Length    ${cell}

    # Edit each cell
    FOR    ${index}    IN RANGE    0    ${length}
        Scroll To Element    ${cell}[${index}]
        ${click_cell}=    Run Keyword And Return Status    Click    ${cell}[${index}]
        Run Keyword And Continue On Failure    Should Be True    ${click_cell}    msg=Failed to click SOV cell at index ${index}.
        
        # Second click in case double-click required
        ${click_cell}=    Run Keyword And Return Status    Click    ${cell}[${index}]
        Run Keyword And Continue On Failure    Should Be True    ${click_cell}    msg=Failed to double-click SOV cell at index ${index}.

        Type Text    ${Cell_input}    Test
    END

    # Save SOV file
    ${click_save}=    Run Keyword And Return Status    Click    ${Sov_save}
    Run Keyword And Continue On Failure    Should Be True    ${click_save}    msg=Failed to click 'Save' button in SOV.

    # Verify edits are saved
    FOR    ${index}    IN RANGE    0    ${length}
        ${text}=    Get Text    ${cell}[${index}]
        Run Keyword And Continue On Failure    Should Be Equal    ${text}    Test    msg=SOV cell at index ${index} did not save the edited value.
    END

    # Reset viewport and navigate back
    Set Viewport Size    1280    720
    ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers Tab after verifying SOV.


# verify the colour of the processed and archived
#     [Documentation]    This method is used to verify the colour of the processed and archived in document tab
 
#     Switch to Documents
#     ${Colour}=    Get Style    ${Doc_Processed_loc}    color
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    indigo
#     ${Colour}=    Get Style    ${Doc_Archived_loc}    color
#     Log    ${Colour}
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    grayish-blue
#      ${Colour}=    Get Style    ${Doc_External_links_loc}    color
#     Log    ${Colour}
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    grayish-blue
#     Click    ${Doc_Archived_loc}
#     Click    ${Search_file_loc}
#     ${Colour}=    Get Style    ${Doc_Archived_loc}    color
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    indigo
#     ${Colour}=    Get Style    ${Doc_Processed_loc}    color
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    grayish-blue
#      ${Colour}=    Get Style    ${Doc_External_links_loc}    color
#     Log    ${Colour}
#     ${Colour_name}    Get Colour Name    ${Colour}    
#     Run Keyword And Continue On Failure    Should Be Equal    ${Colour_name}    grayish-blue

verify the colour of the processed and archived
    [Documentation]    Verifies the colour of the Processed, Archived, and External Links documents in the Documents tab.
    
    Switch To Documents
    sleep    3s
    # Verify initial colours
    ${colour}=    Get Style    ${Doc_Processed_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    indigo    msg=Processed document colour mismatch.
    
    ${colour}=    Get Style    ${Doc_Archived_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    grayish-blue    msg=Archived document colour mismatch.

    ${colour}=    Get Style    ${Doc_External_links_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    grayish-blue    msg=External Links document colour mismatch.

    # Click Archived document and search a file to toggle colours
    ${click_archived}=    Run Keyword And Return Status    Click    ${Doc_Archived_loc}
    Run Keyword And Continue On Failure    Should Be True    ${click_archived}    msg=Failed to click Archived document.

    ${click_search}=    Run Keyword And Return Status    Click    ${Search_file_loc}
    Run Keyword And Continue On Failure    Should Be True    ${click_search}    msg=Failed to click Search file after Archived document.
    Sleep    5s
    # Verify colours after interaction
    ${colour}=    Get Style    ${Doc_Archived_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    indigo    msg=Archived document colour did not update to indigo.

    ${colour}=    Get Style    ${Doc_Processed_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    grayish-blue    msg=Processed document colour did not update to grayish-blue.

    ${colour}=    Get Style    ${Doc_External_links_loc}    color
    ${colour_name}=    Get Colour Name    ${colour}
    Run Keyword And Continue On Failure    Should Be Equal    ${colour_name}    grayish-blue    msg=External Links document colour did not remain grayish-blue.

# Verify Schema for policy information and Available in Documents Tab
#     [Documentation]    Verifies that the Policy PDF is generated and listed in the Documents tab.
#     ...    ${expectedText1}     we need to pass the policy Information use in Summary Tab in Previous Stage  
#     [Arguments]     ${expected_headers}    ${expectedText1}
#     ${Expected_Policy_text}    Create List
#     Append To List    ${Expected_Policy_text}    ${expectedText1['premium']}
#     Append To List    ${Expected_Policy_text}    ${expectedText1['AttachmentPoint']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['PolicyNumber']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['ClassOfBusiness']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['PlacementType']}  
#     @{actual_Policy_text}    Create List
#     Switch To Documents
#     Click    ${SchemaSection}
#     FOR    ${element}    IN    @{expected_headers}
#      ${ele_Loc}    Catenate    SEPARATOR=    ${policy_locators1}    ${element}    ${policy_locators2}
#      ${ele_Loc}    Catenate    SEPARATOR=    ${ele_Loc}    ${policy_locators3}
#      ${ele_Loc}    Catenate    SEPARATOR=    ${ele_Loc}    ${element}    ${policy_locators4}
#      Sleep    1s
#      Click     ${poloicy_Data_modification_page}
#     Press Keys    xpath=//*[@class='ace_content']        Control+f
#     Type Text    ${Search_Bar_CtrlF}    ${element}
#         ${result}    Get Text    ${ele_Loc}
#          IF    '"' in '''${result}'''  
#          ${cleaned}=    Evaluate    ${result}.replace('"', '')    modules=builtins
#             Append To List    ${actual_Policy_text}    ${cleaned}
#         ELSE
#              Append To List    ${actual_Policy_text}    ${result}
#         END    
#     END
#     Log    ${actual_Policy_text}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${actual_Policy_text}    ${Expected_Policy_text}  

Verify Schema for Policy Information and Available in Documents Tab
    [Documentation]    Verifies that the Policy PDF is generated and listed in the Documents tab.
    ...    ${expected_headers} are the headers to validate.
    ...    ${expectedText1} contains the policy information used in the Summary tab from the previous stage.
    [Arguments]    ${expected_headers}    ${expectedText1}
    Switch To Documents
    # Prepare expected values
    ${Expected_Policy_text}=    Create List
    Append To List    ${Expected_Policy_text}    ${expectedText1['premium']}
    Append To List    ${Expected_Policy_text}    ${expectedText1['AttachmentPoint']}  
    Append To List    ${Expected_Policy_text}    ${expectedText1['PolicyNumber']}  
    Append To List    ${Expected_Policy_text}    ${expectedText1['ClassOfBusiness']}  
    Append To List    ${Expected_Policy_text}    ${expectedText1['PlacementType']}  

    @{actual_Policy_text}=    Create List

    # Navigate to documents
    Switch To Documents
    ${click_schema}=    Run Keyword And Return Status    Click    ${SchemaSection}
    Run Keyword And Continue On Failure    Should Be True    ${click_schema}    msg=Failed to click Schema Section in Documents tab.

    # Loop through headers and validate text
    FOR    ${element}    IN    @{expected_headers}
        ${ele_Loc}=    Catenate    SEPARATOR=    ${policy_locators1}    ${element}    ${policy_locators2}
        ${ele_Loc}=    Catenate    SEPARATOR=    ${ele_Loc}    ${policy_locators3}
        ${ele_Loc}=    Catenate    SEPARATOR=    ${ele_Loc}    ${element}    ${policy_locators4}

        Sleep    1s
        ${click_page}=    Run Keyword And Return Status    Click    ${poloicy_Data_modification_page}
        Run Keyword And Continue On Failure    Should Be True    ${click_page}    msg=Failed to click Policy Data Modification page.

        Press Keys    xpath=//*[@class='ace_content']    Control+f
        Type Text    ${Search_Bar_CtrlF}    ${element}
        ${Status}    Run Keyword And Return Status    Wait For Elements State    ${ele_Loc}
        Should Be True    ${Status}    msg=Element locator for policy header ${element} not having any value it shoows null like that in schema in Document Tab.
        ${result}=    Get Text    ${ele_Loc}

        IF    '"' in '''${result}'''
            ${cleaned}=    Evaluate    ${result}.replace('"', '')    modules=builtins
            Append To List    ${actual_Policy_text}    ${cleaned}
        ELSE
            Append To List    ${actual_Policy_text}    ${result}
        END
    END

    Log    ${actual_Policy_text}

    # Verify actual values match expected
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${actual_Policy_text}    ${Expected_Policy_text}    msg=Policy Information in Documents tab does not match expected values.


# verify the Files Sov file are editable
#     [Documentation]    This method is used to verify the sov file are editable or not
#     [Arguments]
#     Switch to Documents
#     Click    ${SOV}
#     Click    ${Sov_Driver_option}
#     Click    ${Sov_addrow}
#     Set Viewport Size    2560    1440
#     ${cell}    Get Elements    ${sov_file_cell}
#     ${length}    Get Length    ${cell}
#     FOR    ${element}    IN RANGE    0    ${length}  
#     Scroll To Element    ${cell}[${element}]  
#         Click    ${cell}[${element}]
#         Click    ${cell}[${element}]
#        Type text    ${Cell_input}    Test
#     END
#     Click    ${Sov_save}
#     FOR    ${element}    IN RANGE    0    ${length}
#        ${text}    Get Text    ${cell}[${element}]
#         Run Keyword And Continue On Failure   Should Be Equal    ${text}    Test
#     END
#     Set Viewport Size    1280    720
#     Click Answers Tab
Verify Files Sov Are Editable
    [Documentation]    This method verifies that the SOV file is editable by adding a row, typing text, and saving the changes.

    Switch to Documents

    ${status}=    Run Keyword And Return Status    Click    ${SOV}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on SOV file.

    ${status}=    Run Keyword And Return Status    Click    ${Sov_Driver_option}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on SOV driver option.

    ${status}=    Run Keyword And Return Status    Click    ${Sov_addrow}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Add Row in SOV file.

    Set Viewport Size    2560    1440

    ${cell}=    Get Elements    ${sov_file_cell}
    ${length}=    Get Length    ${cell}

    FOR    ${element}    IN RANGE    0    ${length}
        Scroll To Element    ${cell}[${element}]
        
        ${status}=    Run Keyword And Return Status    Click    ${cell}[${element}]
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on SOV cell index ${element}.

        ${status}=    Run Keyword And Return Status    Click    ${cell}[${element}]
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to focus SOV cell index ${element} for typing.

        Type Text    ${Cell_input}    Test
    END

    ${status}=    Run Keyword And Return Status    Click    ${Sov_save}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Save on SOV file.

    FOR    ${element}    IN RANGE    0    ${length}
        ${text}=    Get Text    ${cell}[${element}]
        Run Keyword And Continue On Failure    Should Be Equal    ${text}    Test    SOV cell index ${element} was not updated correctly.
    END

    Set Viewport Size    1280    720

    ${status}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to switch back to Answers Tab.

 