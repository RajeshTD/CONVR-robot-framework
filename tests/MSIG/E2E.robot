*** Settings ***
Resource    ../../utils/common_keywords.robot
Library    ../../libraries/ScreenshotListener.py    False
Library    ../../libraries/ValidationScreenshotListener.py
Test Setup    Launch URL and Login in to the application
Test Teardown    Run Keywords    Close Context    Close Browser

*** Test Cases ***
TC_E2E_001
    [Tags]    E2E-WithoutSov    
    [Documentation]    End to End Testing for New Submission - In Draft Stage: This stage is primarily for Submission Clearance process
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_001['FileName']}    @{TC_E2E_001['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_1}    ${submission_id}
    IF    '${submission_id_1}' != 'False'
        Select Submission using submission id    ${submission_id_1}    @{TC_E2E_001['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_001['excepted_Field']}
        # Run Keyword And Continue On Failure    verify the Renewal Flag is Should not Present in All Tab    renewal flag
        Switch To Summary Tab    ${TC_E2E_001['SummaryHeader']}
        Run Keyword And Continue On Failure    Verify AttachmentPoint Must Accept Numeric values    ${TC_E2E_001['Attacment_value']}
        Run Keyword And Continue On Failure    Verify Summary Workflow Stages     ${TC_E2E_001['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_001['SummaryTableHeader']}    ${TC_E2E_001['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Fields In Summary Tab     ${TC_E2E_001['PolicyFields']}   
        Run Keyword And Continue On Failure    Verify the Workflow Reflected in Summary Tab    ${TC_E2E_001['AdvanceTo']}
        Click Answers Tab
        Run Keyword And Continue On Failure    verify the forms data is extracted based on risk 360 Tab
        Run Keyword And Continue On Failure    Verify the AM Best card in risk360 tab
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify that Referral is not displayed in the Summary tab    ${TC_E2E_001}
        Run Keyword And Continue On Failure    Verify that the Referral button is not displayed in the Draft stage    ${TC_E2E_001}
        Run Keyword And Continue On Failure    Summary Premium Field Verification    ${TC_E2E_001}
        Run Keyword And Continue On Failure    Fill and Verify Clearance Tab For Acord125    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Click and verify Clearance tab
        # Run Keyword And Continue On Failure    Verify the Error popup when mandate fields left empty    ${TC_E2E_001}
        # Click Insured Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_001['expectedPDFText']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
        # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
        # Fill the data for issue fields    ${TC_E2E_001['SicCode']}    ${TC_E2E_001['SicDescription']}    ${TC_E2E_001['NAICSCode']}
        # Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
        # Click Processing Tab                    
        # Fill the data for issue fields in processing    ${TC_E2E_001['UnderwriterName']}    ${TC_E2E_001['UnderwriterEmail']}    ${TC_E2E_001['OperationsName']}        ${TC_E2E_001['OperationsEmail']}    ${TC_E2E_001['UnderwrittingOffice']}    ${TC_E2E_001['Channel']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_001['expectedTextInProducer']}
        # Fill the data for issues field in Producer    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Click Coverage Tab
        # Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_001['EffectiveDate']}     ${TC_E2E_001['ExpirationDate']}     ${TC_E2E_001['Product']}
        # Fill the data for issues field in Coverage    ${TC_E2E_001['Covered']}    
        # Click Issues Tab
        # @{expectedIssues}    Create List    ${TC_E2E_001['SicCode']}    ${TC_E2E_001['SicDescription']}    ${TC_E2E_001['NAICSCode']}    ${TC_E2E_001['UnderwriterName']}    ${TC_E2E_001['UnderwriterEmail']}    ${TC_E2E_001['UnderwrittingOffice']}     ${TC_E2E_001['OperationsName']}    ${TC_E2E_001['OperationsEmail']}    ${TC_E2E_001['Channel']}    ${TC_E2E_001['ProducerName']}
        # Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
        # Click Finish Tab
        # Run Keyword And Continue On Failure    Verify and click the save and close button
        # Wait For Processing Stage
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        # Run Keyword And Continue On Failure    Verify Schema by downloading the json file    ${TC_E2E_001['queryList']}    @{expectedModification}
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify that System shows Correct Task Number
        # Run Keyword And Continue On Failure    Verify Task Names Listed in Alphatecal Order    ${TC_E2E_001}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Submission/Policy Number in CAT Modeling Request    ${TC_E2E_001}
        # Create New Task    ${TC_E2E_001['taskdata']}
        # Run Keyword And Continue On Failure    Upload File on Created Task    ${TC_E2E_001['FileName']}    ${TC_E2E_001['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_001['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_001['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_001['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_001['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_001['taskupdateddetails']}
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_001}
        # Create New Mail    ${TC_E2E_001['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_001['emailVerify']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_001['emailData']} 
        # Discard the Created Email    ${TC_E2E_001['emailData']}      
        # Create New Mail With Missing Data    ${TC_E2E_001['emailData_Mising']}    ${TC_E2E_001['Expected_PopUp']}  
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_001['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Run Keyword And Continue On Failure    PIF Ceded Reinsurance Verification    ${TC_E2E_001}
        Run Keyword And Continue On Failure    Rating Details Numeric Verification    ${TC_E2E_001}
        Click Answers Tab
        Run Keyword And Continue On Failure    Verify the Score In Answers Tab    ${submission_id_1}    @{TC_E2E_001['SubmissionColumnNames']}  
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
        Run Keyword And Continue On Failure    verify the Sov File Are Available in Email Tab    ${TC_E2E_001['emailData']}    ${TC_E2E_001['FileName']}
    ELSE IF    '${submission_id_1}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_007
    [Tags]    E2E-WithoutSov    
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) with SOV Loss run"
    # Skip if prerequisite failed
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    #    Create User If the User is not present    ${NewUser}
    #     Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${submission_id_1}    @{TC_E2E_007['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage 2
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_007['stage']}
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_007['excepted_Field']}
        Switch To Summary Tab    ${TC_E2E_007['SummaryHeader']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_007['SummaryTableHeader']}    ${TC_E2E_007['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Fields In Summary Tab     ${TC_E2E_007['PolicyFields']}   
        Run Keyword And Continue On Failure    Verify the Workflow Reflected in Summary tab    ${TC_E2E_007['AdvanceTo']}
        Run Keyword And Continue On Failure    Verify Schema section is available in Documents Page
        Click Edit Submission
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_007}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_007['expectedQuestion']}
        # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_007['expectedTitle']}
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_007}
        # Switch to Risk360 tab
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_007['Risk360_Card_Names']}    ${TC_E2E_007['Risk360_Card_Pages_Names']}
        # Run Keyword And Continue On Failure    Verify NAICS is ReUpdated in Risk360 Tab    ${TC_E2E_007}
        # Run Keyword And Continue On Failure    verify the Risk360 social media link
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_007}
        # Create New Task    ${TC_E2E_007['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_007['taskDetails']}
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_007['taskdata']}
        # Run Keyword And Continue On Failure    Edit the created the task    ${TC_E2E_007['taskdata']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_007['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_007['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_007['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_007['taskupdateddetails']}
        Run Keyword And Continue On Failure    Remove Document after Upload     @{TC_E2E_007['FileName']}
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_007}
        # Create New Mail    ${TC_E2E_007['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_007['emailVerify']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_007['emailData']} 
        # Discard the Created Email    ${TC_E2E_007['emailData']}      
        # Create New Mail With Missing Data    ${TC_E2E_007['emailData_Mising']}    ${TC_E2E_007['Expected_PopUp']}
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_007}
        Run Keyword And Continue On Failure    Verify Files Sov Are Editable
        # Upload SOV and Loss Run Documents    @{TC_E2E_007['FileName']}
        # Wait for Upload to Complete
        # Open uploaded SOV File   
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_007['CardName']}    ${TC_E2E_007['expectedAnalysisData']}    ${TC_E2E_007['expectedTableData']}
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_007['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        # Run Keyword And Continue On Failure    Verify that Reactive details are not displayed after reloading
        Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
TC_E2E_011
    [Tags]    E2E-WithoutSov    
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_011 Stage 3 - Under Review.
    END
        # Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${submission_id_1}    @{TC_E2E_011['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_011['stageNo']}    
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_011['stage']}
        Click Edit Submission
        Click and verify Clearance tab
        Create Child submission    ${TC_E2E_011['Covered']}
        ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_011['stageNo']}
        Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
        IF    ${child_submission_status_1} != False
            ${newSubmissionID}    Get New Submission ID After Child Submission
            Set Suite Variable    ${new_submission_id_1}   ${newSubmissionID}  
            Navigate To All Submissions page from submissions 
            Select Submission using submission id    ${newSubmissionID}    @{TC_E2E_011['SubmissionColumnNames']}
            Wait For Processing Stage    ${TC_E2E_011['stageNo']}
            Run Keyword And Continue On Failure    Verify Summary Menu is displayed
            Click Edit Submission
            Switch To Summary Tab    ${TC_E2E_011['SummaryHeader']}
            # Run Keyword And Continue On Failure    Verify Premium Amount    
            Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_011['PolicyInfo']}
            Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_011['SummaryTableData']}
            Run Keyword And Continue On Failure    Verify the Workflow Reflected in Summary tab    ${TC_E2E_011['AdvanceTo']}
            Run Keyword And Continue On Failure    Verify Schema section is available in Documents Page
            Click Answers Tab
            Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
            Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
            Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_011}
            Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_011}
            # Click Answers Tab
            # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_011['expectedQuestion']}
            # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_011['Risk360_Card_Names']}    ${TC_E2E_011['Risk360_Card_Pages_Names']}
            Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_011}
            # Create New Task    ${TC_E2E_011['taskdata']}
            # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_011['taskDetails']}
            # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
            # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_011['priority']}
            # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_011['taskupdateddetails']}
            # Click Answers Tab
            # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_011['taskdata']}
            # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_011['taskupdateddetails']}
            Run Keyword And Continue On Failure    Remove Document after Upload     @{TC_E2E_011['FileName']}
            Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_011}
            # Create New Mail    ${TC_E2E_011['emailData']}
            # Run Keyword And Continue On Failure    Verify Email Sent Successfully
            # Run Keyword And Continue On Failure    verify the time format in email tab after send the mail
            # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_011['emailVerify']}
            # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_011['emailData']} 
            # Discard the Created Email    ${TC_E2E_011['emailData']}      
            # Create New Mail With Missing Data    ${TC_E2E_011['emailData_Mising']}    ${TC_E2E_011['Expected_PopUp']}
            Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_011}
            # Upload SOV and Loss Run Documents    @{TC_E2E_011['FileName']}
            # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_011['stageNo']}
            # Open uploaded SOV File   
            # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
            # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
            # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
            # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
            # # Verify Policies Data From Loss Run File
            # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_011['CardName']}    ${TC_E2E_011['expectedAnalysisData']}    ${TC_E2E_011['expectedTableData']}
            Run Keyword And Continue On Failure    Verify Download Snapshot in Document Tab    ${TC_E2E_011}
            # Verify Schema by downloading the json file
            Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_011['expectedWorkFlowHistory']}
            Run Keyword And Continue On Failure    Save Submission And verify popup
            Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_011['stageNo']}
            # Run Keyword And Continue On Failure    Verify Schema for policy information and Available in Documents Tab    ${TC_E2E_011['policy_headers']}    ${TC_E2E_011['PolicyInfo']}
            Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
            Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_011['PolicyInfo']}
            Run Keyword And Continue On Failure    Verify Decline in under Review Stage
            Run Keyword And Continue On Failure    Verify The Account History Current Stage Status    ${TC_E2E_011}
        ELSE IF    '${child_submission_status_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
        
TC_E2E_017
    [Tags]    E2E-WithoutSov    
    [Documentation]    End to End Testing for New Submission - (Quoted Stage)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
        #    Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_017['stageNo']}
        Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_011['PolicyInfo']}    ${TC_E2E_017['stageNo']}
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_017['stage']}
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_017['SummaryHeader']}
        Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_011['PolicyInfo']}
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_017['PolicyInfo']}   
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_017['SummaryTableHeader']}    ${TC_E2E_017['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify the Workflow Reflected in Summary tab    ${TC_E2E_017['AdvanceTo']}
        Run Keyword And Continue On Failure    Verify Schema section is available in Documents Page
        Run Keyword And Continue On Failure    Verify Schema for policy information and Available in Documents Tab    ${TC_E2E_017['policy_headers']}    ${TC_E2E_017['PolicyInfo']}
        Run Keyword And Continue On Failure    verify the Sov file are editable
        Run Keyword And Continue On Failure    verify the colour of the processed and archived
        Click Answers Tab
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_017}
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_017}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_017['expectedQuestion']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_017['Risk360_Card_Names']}    ${TC_E2E_017['Risk360_Card_Pages_Names']}
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_017}
        # Create New Task    ${TC_E2E_017['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_017['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_017['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_017['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_017['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_017['taskupdateddetails']}
        Run Keyword And Continue On Failure    Remove Document after Upload     @{TC_E2E_017['FileName']}
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_017}
        # Create New Mail    ${TC_E2E_017['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_017['emailVerify']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_017['emailData']} 
        # Discard the Created Email    ${TC_E2E_017['emailData']}      
        # Create New Mail With Missing Data    ${TC_E2E_017['emailData_Mising']}    ${TC_E2E_017['Expected_PopUp']}
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_017}
        # Upload SOV and Loss Run Documents    @{TC_E2E_017['FileName']}
        # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_017['stageNo']}
        # Open uploaded SOV File   
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # # Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_017['CardName']}    ${TC_E2E_017['expectedAnalysisData']}    ${TC_E2E_017['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_017['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_017['stageNo']}
        Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_017['PolicyInfo']}
TC_E2E_023
    [Tags]    E2E-WithoutSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_023 Stage 5 - Bind
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_023 Stage 5 - Bind
    END
        #    Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        # Run Pre-requiste for Step 1 2 3 & 4
        Advance Stage    ${TC_E2E_023['stageNo']}
        Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_017['PolicyInfo']}    ${TC_E2E_023['stageNo']}
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_023['stage']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_023['excepted_Field']}
        # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_017['PolicyInfo']}
        Switch to Summary
        # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_023['stage']}    ${TC_E2E_023['Tab_Name']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_023['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_023['PolicyInfo']}
        #  Verify the Workflow in Summary Tab
        #Issue: The Child Submission in the Summary Tab is not stable.
        #Impact: We are unable to verify if the dependent child is displayed/present as expected
        # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_023['productName']}
        # # Run Keyword And Continue On Failure    verify Account History are Editable    ${TC_E2E_023['PolicyInfo']} 
        # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
        #Complete Forms Tab Details Filling    ${TC_Forms_01}
        Click Answers Tab
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_017}
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_017}
        # Click and verify Clearance tab
        #  Answer Tab
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_023['expectedQuestion']}
        # # Risk360 Tab
        # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_008['expectedTitle']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_008['Risk360_Card_Names']}    ${TC_E2E_008['Risk360_Card_Pages_Names']}
        # Task tab
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_023}
        # Create New Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
        #Email Tab
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
        # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
        # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
        # Document Tab
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_017}
        # Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
        # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_023['stageNo']}
        # Open uploaded SOV File
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
        #Clearance Tab--Verification
        # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_023['ProductName']}
        #WorkFlow History ----Integration needed for execution ,
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_023['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_023['stageNo']}
        Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_023['PolicyInfo']}
TC_E2E_024
    [Tags]    E2E-WithoutSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_024 Stage 6 - Bound
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_024 Stage 6 - Bound
    END
        #    Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_024['stageNo']}
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_024['stage']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_024['excepted_Field']}
        # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_023['PolicyInfo']}
        Switch to Summary
        # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_024['stage']}    ${TC_E2E_024['Tab_Name']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_024['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_023['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_024['PolicyInfo']}
        #Issue: The Child Submission in the Summary Tab is not stable.
        #Impact: We are unable to verify if the dependent child is displayed/present as expected
        # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_023['productName']}
        # Run Keyword And Continue On Failure    verify Account History are Editable    ${TC_E2E_024['PolicyInfo']}
        # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
        Click Answers Tab
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
        # Run Keyword And Continue On Failure    Click and verify Clearance tab
        #  Answer Tab
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_017}
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_017}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_024['expectedQuestion']}
        # # Risk360 Tab
        # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_024['expectedTitle']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_024['Risk360_Card_Names']}    ${TC_E2E_024['Risk360_Card_Pages_Names']}
        # Task tab
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_024}
        # Create New Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
        #Email Tab
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
        # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
        # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
        # Document Tab
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_017}
        # Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
        # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_024['stageNo']}
        # Open uploaded SOV File  
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
        #Clearance Tab--Verification
        # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_024['ProductName']}
        #WorkFlow History ----Integration needed for execution ,
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_024['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_024['stageNo']}
        Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_024['PolicyInfo']}
TC_E2E_025
    [Tags]    E2E-WithoutSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_025 Stage 7 - Booked
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_025 Stage 7 - Booked
    END
        #    Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        # Run Pre-requiste for Step 1 2 3 & 4
        Advance Stage    ${TC_E2E_025['stageNo']} 
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_025['stage']}
        # Task Tab
        Click Answers Tab
        # Wait For Elements State    ${TaskClick}    visible
        # Click    ${TaskClick}
        # Click Tasks
        # Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_025['taskDetails1']}
        # Run Keyword And Continue On Failure    Complete Task with the given reason for Booking stage    ${TC_E2E_025['taskreason']}
        # Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason for booking    ${TC_E2E_025['taskreason']}
        Run Keyword And Continue On Failure    Click Edit Submission
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_025['excepted_Field']}
        # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_024['PolicyInfo']}
        Run Keyword And Continue On Failure    Switch to Summary
        # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_025['stage']}    ${TC_E2E_025['Tab_Name']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_025['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_024['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_025['PolicyInfo']}
        Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_025['PolicyInfo']}
        # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_023['productName']}
        # Run Keyword And Continue On Failure    verify Account History are Editable    ${TC_E2E_024['PolicyInfo']} 
        # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
        Click Answers Tab
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
        #  Answer Tab
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_025['expectedQuestion']}
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_017}
        # Risk360 Tab
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_025['expectedTitle']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_025['Risk360_Card_Names']}    ${TC_E2E_025['Risk360_Card_Pages_Names']}
        # Task tab
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_025}
        # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_025['taskdata']}
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_025['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_025['taskupdateddetails']} 
        #Email Tab 
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_025['DraftemailData']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_025['DraftemailData']}
        # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_025['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
        # Document Tab
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
        # Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_025['stageNo']}
        # Run Keyword And Continue On Failure    Open uploaded SOV File   
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    #Clearance Tab--Verification
        # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_025['ProductName']} 
        # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_025['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_025['stageNo']}
        Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_025['PolicyInfo']}
TC_E2E_026
    [Tags]    E2E-WithoutSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${submission_id_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_026 Stage 8 - Issued
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_026 Stage 8 - Issued
    END
        #    Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_026['stageNo']}
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_026['stage']}
        Click Edit Submission
        Verify Summary Menu is displayed
        Run Keyword And Continue On Failure    Verify All Side menu options are Displayed    ${TC_E2E_026['excepted_Field']}
        # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_025['PolicyInfo']}
        Run Keyword And Continue On Failure    Switch to Summary
        # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_026['stage']}    ${TC_E2E_026['Tab_Name']}
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_026['SummaryTableHeader']}    ${TC_E2E_026['SummaryTableData']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_025['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_026['PolicyInfo']}
        Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_026['PolicyInfo']}
        # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_023['productName']}
        # Run Keyword And Continue On Failure    verify Account History are Editable    ${TC_E2E_026['PolicyInfo']} 
        #  Answer Tab
        Run Keyword And Continue On Failure    Answer Tab Verifications    ${TC_E2E_017}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_026['expectedQuestion']}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
        Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
        Click Answers Tab
        Run Keyword And Continue On Failure    Risk360 Tab Verifications    ${TC_E2E_017}
        # Risk360 Tab
        # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_026['expectedTitle']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_026['Risk360_Card_Names']}    ${TC_E2E_026['Risk360_Card_Pages_Names']}
    # Task tab
        Click Answers Tab
        Run Keyword And Continue On Failure    Create and Verify Task In Task Tab    ${TC_E2E_026}
        # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_026['taskdata']}
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskDetails']}
        # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_026['priority']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskupdateddetails']}
        # Click Answers Tab
        # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
        # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_026['taskupdateddetails']}
        #Email Tab
        Run Keyword And Continue On Failure    Create and Verify Mail In Email Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_026['DraftemailData']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_026['DraftemailData']}
        # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_026['emailData_Mising']}    ${TC_E2E_026['Expected_PopUp']}
        # Document Tab
        Run Keyword And Continue On Failure    Upload and Verify SOV and LR File In Documents Tab    ${TC_E2E_017}
        # Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
        # Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_026['stageNo']}
        # Run Keyword And Continue On Failure    Open uploaded SOV File   
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}  
        # clearance tab
        # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_026['ProductName']}
        # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_026['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Advance Stage is InActive
        Run Keyword And Continue On Failure    Verify multiple edit functionality in the Summary tab    ${TC_E2E_026['PolicyInfo']}

TC_E2E_002
    [Tags]    E2E-Reject
    [Documentation]    End to End Testing for Reject Submission - In Draft Stage: This stage is primarily for Submission Clearance process
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_002['FileName']}    @{TC_E2E_002['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_reject}    ${submission_id}
    IF    '${submission_id_reject}' != 'False'
    Select Submission using submission id    ${submission_id}    @{TC_E2E_002['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Edit Submission
    # Run Keyword And Continue On Failure    Click and verify Clearance tab
    # Click Insured Tab
    # Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_002['expectedPDFText']}
    # Fill the data for issue fields    ${TC_E2E_002['SicCode']}    ${TC_E2E_002['SicDescription']}    ${TC_E2E_002['NAICSCode']}
    # Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
    # Click Processing Tab
    # Fill the data for issue fields in processing    ${TC_E2E_002['UnderwriterName']}    ${TC_E2E_002['UnderwriterEmail']}    ${TC_E2E_002['OperationsName']}      
    # ...    ${TC_E2E_002['OperationsEmail']}    ${TC_E2E_002['UnderwrittingOffice']}    ${TC_E2E_002['Channel']}
    # Click Producer Tab
    # Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_002['expectedTextInProducer']}
    # Fill the data for issues field in Producer    ${TC_E2E_002['ProducerName']}      ${TC_E2E_002['ProducerEmail']}
    # Click Coverage Tab
    # Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_002['EffectiveDate']}     ${TC_E2E_002['ExpirationDate']}     ${TC_E2E_002['Product']}
    # Fill the data for issues field in Coverage    ${TC_E2E_002['Covered']}
    # Click Issues Tab
    #  @{expectedIssues}    Create List    ${TC_E2E_002['SicCode']}    ${TC_E2E_002['SicDescription']} 
    #  ...    ${TC_E2E_002['NAICSCode']}    ${TC_E2E_002['UnderwriterName']}    ${TC_E2E_002['UnderwriterEmail']} 
    #  ...    ${TC_E2E_002['UnderwrittingOffice']}     ${TC_E2E_002['OperationsName']}    ${TC_E2E_002['OperationsEmail']}    ${TC_E2E_002['Channel']}    ${TC_E2E_002['ProducerName']}
    # Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
    # Click Finish Tab
    # Run Keyword And Continue On Failure    Verify and click the save and close button
    # Switch to Documents
    #  @{expectedModification}    Create List    "${TC_E2E_002['SicCode']}"    "${TC_E2E_002['SicDescription']}"  
    #  ...    "${TC_E2E_002['NAICSCode']}"    "${TC_E2E_002['UnderwriterName']}"    "${TC_E2E_002['UnderwriterEmail']}"   
    #  ...    "${TC_E2E_002['UnderwrittingOffice']}"     "${TC_E2E_002['OperationsName']}"    "${TC_E2E_002['OperationsEmail']}"    "${TC_E2E_002['Channel']}"   
    #  ...    "${TC_E2E_002['ProducerName']}"    "${TC_E2E_002['ProducerEmail']}"    "${TC_E2E_002['Covered']['Product']}"    "${TC_E2E_002['Covered']['ProductSegment']}" 
    # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
    # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
    # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
    # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
    # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
    # Wait For Processing Stage
    # Switch to Documents
    # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
    # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    Fill and Verify Clearance Tab For Acord125    ${TC_E2E_001}
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    # Run Keyword And Continue On Failure    Reject Submission and Verify the Tag name    ${TC_E2E_002['FailureReasons']}    ${TC_E2E_002['FailureDetails']}    ${TC_E2E_002['Action']}
    Run Keyword And Continue On Failure    Reject Submission and Verify the error msg    ${TC_E2E_002['FailureReasons']}    ${TC_E2E_002['FailureDetails']}     
    Run Keyword And Continue On Failure    Reject Submission via summary tab    ${TC_E2E_002['FailureReasons']}    ${TC_E2E_002['FailureDetails']}    ${TC_E2E_002['Action']}
    Wait For Processing Stage
    Run Keyword And Continue On Failure    Verify WorkFlow History for Rejection    ${TC_E2E_002['WorkFlowHistory']}
    # Reactive the Rejected Submission
    Run Keyword And Continue On Failure    Reactive the Submission via summary tab    ${TC_E2E_002['FailureDetails']}    ${TC_E2E_002['Action']}  
    Run Keyword And Continue On Failure    verify Reactive the Rejected Submission error msg appear
    Wait For Processing Stage
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated
    ELSE IF    '${submission_id_reject}' == 'False'
        FAIL    New Reject Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END

TC_E2E_009
    [Tags]    E2E-Reject
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) with Reject & Reactivate"
    IF    '${submission_id_reject}' == 'False'
        Skip    New Reject Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END 
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_reject}    @{TC_E2E_009['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_009['stage']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_009['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_009['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_009['Risk360_Card_Names']}    ${TC_E2E_009['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_009['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_009['taskDetails']}
    # Create New Mail    ${TC_E2E_009['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_009['emailVerify']}
    Upload SOV and Loss Run Documents    @{TC_E2E_009['FileName']}
    Wait for Upload to Complete
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_009['CardName']}    ${TC_E2E_009['expectedAnalysisData']}    ${TC_E2E_009['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_009['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Reject Submission and Verify the Tag name    ${TC_E2E_002['FailureReasons']}    ${TC_E2E_002['FailureDetails']}    ${TC_E2E_002['Action']}
    Reactive the Rejected Submission
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject

TC_E2E_013
    [Tags]    E2E-Reject
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  Reject and Reactivate Submission"
    IF    '${submission_id_reject}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
        # Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${submission_id_reject}    @{TC_E2E_013['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_013['stageNo']}    
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_013['stage']}
        Click Edit Submission
        Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_013['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_reject}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_reject}    @{TC_E2E_013['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_013['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_013['SummaryHeader']}
        # Run Keyword And Continue On Failure    Verify Premium Amount    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_013['SummaryTableHeader']}    ${TC_E2E_013['SummaryTableData']}
        Click Answers Tab
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_013['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_013['Risk360_Card_Names']}    ${TC_E2E_013['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_013['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_013['taskDetails']}
        # Create New Mail    ${TC_E2E_013['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_013['emailVerify']}
        Upload SOV and Loss Run Documents    @{TC_E2E_013['FileName']}
        Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_013['stageNo']}
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_013['CardName']}    ${TC_E2E_013['expectedAnalysisData']}    ${TC_E2E_013['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_013['expectedWorkFlowHistory']}
        Reject Submission and Verify the Tag name    ${TC_E2E_002['FailureReasons']}    ${TC_E2E_002['FailureDetails']}    ${TC_E2E_002['Action']}
        Reactive the Rejected Submission
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_013['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${child_submission_status_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_003
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - In Draft Stage: SOV Losss run
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create new submission with SOV and Loss run    ${TC_E2E_003['FileName']}    @{TC_E2E_003['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_sov}    ${submission_id}
    IF    '${submission_id_sov}' != 'False'
        Select Submission using submission id   ${submission_id}    @{TC_E2E_003['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Click Edit Submission
        Run Keyword And Continue On Failure    Click and verify Clearance tab
        #    Click Insured Tab
        #    Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_003['expectedPDFText']}
        #    Fill the data for issue fields    ${TC_E2E_003['SicCode']}    ${TC_E2E_003['SicDescription']}    ${TC_E2E_003['NAICSCode']}
        #    Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
        #    Click Processing Tab
        #     Fill the data for issue fields in processing    ${TC_E2E_003['UnderwriterName']}    ${TC_E2E_003['UnderwriterEmail']}    ${TC_E2E_003['OperationsName']}      
        #     ...    ${TC_E2E_003['OperationsEmail']}    ${TC_E2E_003['UnderwrittingOffice']}    ${TC_E2E_003['Channel']}
        #    Click Producer Tab
        #    Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_003['expectedTextInProducer']}
        #    Fill the data for issues field in Producer    ${TC_E2E_003['ProducerName']}      ${TC_E2E_003['ProducerEmail']}
        #    Click Coverage Tab
        #    Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_003['EffectiveDate']}     ${TC_E2E_003['ExpirationDate']}     ${TC_E2E_003['Product']}
        #     Fill the data for issues field in Coverage    ${TC_E2E_003['Covered']}
        #    Click Issues Tab
        #    @{expectedIssues}    Create List    ${TC_E2E_003['SicCode']}    ${TC_E2E_003['SicDescription']} 
        #      ...    ${TC_E2E_003['NAICSCode']}    ${TC_E2E_003['UnderwriterName']}    ${TC_E2E_003['UnderwriterEmail']} 
        #      ...    ${TC_E2E_003['UnderwrittingOffice']}     ${TC_E2E_003['OperationsName']}    ${TC_E2E_003['OperationsEmail']}    ${TC_E2E_003['Channel']}    ${TC_E2E_003['ProducerName']}
        #    Click Finish Tab
        #    Run Keyword And Continue On Failure    Verify and click the save and close button
        #    Switch to Documents
        #     @{expectedModification}    Create List    "${TC_E2E_003['SicCode']}"    "${TC_E2E_003['SicDescription']}"  
        #      ...    "${TC_E2E_003['NAICSCode']}"    "${TC_E2E_003['UnderwriterName']}"    "${TC_E2E_003['UnderwriterEmail']}"   
        #      ...    "${TC_E2E_003['UnderwrittingOffice']}"     "${TC_E2E_003['OperationsName']}"    "${TC_E2E_003['OperationsEmail']}"    "${TC_E2E_003['Channel']}"   
        #      ...    "${TC_E2E_003['ProducerName']}"    "${TC_E2E_003['ProducerEmail']}"    "${TC_E2E_003['Covered']['Product']}"    "${TC_E2E_003['Covered']['ProductSegment']}" 
        #    Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Fill and Verify Clearance Tab For Acord125    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
        # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
        # Wait For Processing Stage
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Loss run file is pending for stage 2
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${submission_id_sov}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_008
    [Tags]    E2E-WithSov
    IF    '${submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) without SOV Loss run upload in Stage 2, since we have uploaded in Stage 1"
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_sov}    @{TC_E2E_008['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_008['stage']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_008['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_008['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_008['Risk360_Card_Names']}    ${TC_E2E_008['Risk360_Card_Pages_Names']}
    # Create New Task    ${TC_E2E_008['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_008['taskDetails']}
    Create New Mail    ${TC_E2E_008['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_008['emailVerify']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_008['CardName']}    ${TC_E2E_008['expectedAnalysisData']}    ${TC_E2E_008['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_008['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Verify Loss run file is pending for stage 2
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject

TC_E2E_012
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  without SOV and LR upload"
    IF    '${submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
        #     Create User If the User is not present    ${NewUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${submission_id_sov}    @{TC_E2E_012['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_012['stageNo']}    
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_012['stage']}
        Click Edit Submission
        Click and verify Clearance tab
        Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_012['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_sov}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_012['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_012['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_012['SummaryHeader']}
        # Run Keyword And Continue On Failure    Verify Premium Amount    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_012['SummaryTableHeader']}    ${TC_E2E_012['SummaryTableData']}
        Click Edit Submission
        Click Answers Tab
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_012['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_012['expectedTitle']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_012['Risk360_Card_Names']}    ${TC_E2E_012['Risk360_Card_Pages_Names']}
        # Create New Task    ${TC_E2E_012['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_012['taskDetails']}
        Create New Mail    ${TC_E2E_012['emailData']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_012['emailVerify']}
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_012['CardName']}    ${TC_E2E_012['expectedAnalysisData']}    ${TC_E2E_012['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_012['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_012['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${child_submission_status_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_018
    [Tags]    E2E-WithSov    
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  with SOV and LR upload"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_018['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_018['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_018['PolicyInfo']}    ${TC_E2E_018['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_018['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_018['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_018['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_018['SummaryTableHeader']}    ${TC_E2E_018['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_018['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_018['Risk360_Card_Names']}    ${TC_E2E_018['Risk360_Card_Pages_Names']}
    # Create New Task    ${TC_E2E_018['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_018['taskDetails']}
    Create New Mail    ${TC_E2E_018['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_018['emailVerify']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_018['CardName']}    ${TC_E2E_018['expectedAnalysisData']}    ${TC_E2E_018['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_018['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_018['stageNo']}

TC_E2E_027
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Pre-requiste for Step 1 2 3 & 4
    Advance Stage    ${TC_E2E_027['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_027['PolicyInfo']}    ${TC_E2E_027['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_027['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_023['PolicyInfo']}
    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_023['stage']}    ${TC_E2E_023['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_023['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_023['PolicyInfo']}
    #  Verify the Workflow in Summary Tab
    #Issue: The Child Submission in the Summary Tab is not stable.
    #Impact: We are unable to verify if the dependent child is displayed/present as expected
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']} 
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
       #Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Click and verify Clearance tab
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_008['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_008['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_008['Risk360_Card_Names']}    ${TC_E2E_008['Risk360_Card_Pages_Names']}
    # Task tab
    # Create New Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
    # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
    # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_027['stageNo']}
    Open uploaded SOV File
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_027['ProductName']}
    #WorkFlow History ----Integration needed for execution ,
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_027['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_027['stageNo']}

TC_E2E_028
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_028['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_028['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_024['PolicyInfo']}
    # Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_024['stage']}    ${TC_E2E_024['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_024['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_024['PolicyInfo']}
    #Issue: The Child Submission in the Summary Tab is not stable.
    #Impact: We are unable to verify if the dependent child is displayed/present as expected
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']}
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Click and verify Clearance tab
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_024['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_028['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_024['Risk360_Card_Names']}    ${TC_E2E_024['Risk360_Card_Pages_Names']}
    # Task tab
    # Create New Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
    # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
    # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_028['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_024['ProductName']}
    #WorkFlow History ----Integration needed for execution ,
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_028['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_028['stageNo']}

TC_E2E_029
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Pre-requiste for Step 1 2 3 & 4
    Advance Stage    ${TC_E2E_029['stageNo']} 
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_029['stage']}
    # Task Tab
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}
    Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_029['taskDetails1']}
    Run Keyword And Continue On Failure    Complete Task without the reason
    Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason for booking    ${TC_E2E_029['taskreason']}
    Run Keyword And Continue On Failure    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_024['PolicyInfo']}
    # Run Keyword And Continue On Failure    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_025['stage']}    ${TC_E2E_025['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_025['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']} 
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_025['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_029['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_025['Risk360_Card_Names']}    ${TC_E2E_025['Risk360_Card_Pages_Names']}
    # Task tab
    # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_025['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_025['taskupdateddetails']} 
    #Email Tab 
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_025['DraftemailData']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_025['DraftemailData']}
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_025['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_029['stageNo']}
    Run Keyword And Continue On Failure    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
   #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_025['ProductName']} 
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_029['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_029['stageNo']}

TC_E2E_030
    [Tags]    E2E-WithSov
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_030['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_030['stage']}
    Click Edit Submission
    # Verify Summary Menu is displayed
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_026['stage']}    ${TC_E2E_026['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_026['SummaryTableHeader']}    ${TC_E2E_026['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_026['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_026['PolicyInfo']}
    # Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_026['PolicyInfo']}
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_026['stage']} 
    #  Answer Tab
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_026['expectedQuestion']}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    Click Answers Tab
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_030['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_026['Risk360_Card_Names']}    ${TC_E2E_026['Risk360_Card_Pages_Names']}
   # Task tab
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_026['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_026['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_026['DraftemailData']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_026['DraftemailData']}
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_026['emailData_Mising']}    ${TC_E2E_026['Expected_PopUp']}
    # Document Tab
    Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_030['stageNo']}
    Run Keyword And Continue On Failure    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}  
    # clearance tab
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_026['ProductName']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_030['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Advance Stage is InActive

TC_E2E_010
    [Tags]    E2E-Email_Verification
    [Documentation]    End to End Testing for New Submission - With Mail Verifications
    ${submision_id}    Run Pre-requiste Steps for Stage 1
    Set Suite Variable    ${submission_id_email}    ${submision_id}
    IF    '${submission_id_email}' != 'False' 
        Advance Stage 2
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_010['stage']}
        Click Edit Submission
        Click Answers Tab
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_010['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_010['Risk360_Card_Names']}    ${TC_E2E_010['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_010['taskdata']}
        Select Task Card     ${TC_E2E_010['taskdata']['taskName']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_010['taskDetails']}
        Create New Mail For Upload 40 MB File    ${TC_E2E_010['emailData_Upload_40_MB_File']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_010['emailVerifyFor40Mb']}    Upload with <40mb file
        Create New Mail For Upload Multiple Files    ${TC_E2E_010['emailData_Upload_Multiple_Files']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_010['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
        Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_010['emailData_Upload_Multiple_Submission_Assets']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_010['emailVerifyMultipleAssets']}    Upload with muliple assets
        Upload SOV and Loss Run Documents    @{TC_E2E_010['FileName']}
        Wait for Upload to Complete
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_010['CardName']}    ${TC_E2E_010['expectedAnalysisData']}    ${TC_E2E_010['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Save Submission And verify popup
         Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${submission_id_email}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_014
    [Tags]    E2E-Email_Verification
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with Email Verifications"
    IF    '${submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_email}    @{TC_E2E_014['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_014['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_014['stage']}
    Click Edit Submission
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_014['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_email}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_014['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_014['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_014['SummaryHeader']}
        # Run Keyword And Continue On Failure    Verify Premium Amount    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_014['SummaryTableHeader']}    ${TC_E2E_014['SummaryTableData']}
        Click Answers Tab
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_011['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_011['Risk360_Card_Names']}    ${TC_E2E_014['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_014['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_014['taskDetails']}
        Create New Mail For Upload 40 MB File    ${TC_E2E_014['emailData_Upload_40_MB_File']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_014['emailVerifyFor40Mb']}    Upload with <40mb file
        Create New Mail For Upload Multiple Files    ${TC_E2E_014['emailData_Upload_Multiple_Files']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_014['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
        Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_014['emailData_Upload_Multiple_Submission_Assets']}
        Run Keyword And Continue On Failure    Verify Email Sent Successfully
        Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_014['emailVerifyMultipleAssets']}    Upload with muliple assets
        Upload SOV and Loss Run Documents    @{TC_E2E_014['FileName']}
        Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_014['stageNo']}
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_014['CardName']}    ${TC_E2E_014['expectedAnalysisData']}    ${TC_E2E_014['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_014['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_014['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${child_submission_status_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_019
    [Tags]    E2E-Email_Verification   
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  Email Verifications"
    IF    '${new_submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_019['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_019['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_019['PolicyInfo']}    ${TC_E2E_019['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_019['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_019['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_019['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_019['SummaryTableHeader']}    ${TC_E2E_019['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_019['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_019['Risk360_Card_Names']}    ${TC_E2E_019['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_019['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_019['taskDetails']}
    Create New Mail For Upload 40 MB File    ${TC_E2E_019['emailData_Upload_40_MB_File']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_019['emailVerifyFor40Mb']}    Upload with <40mb file
    Create New Mail For Upload Multiple Files    ${TC_E2E_019['emailData_Upload_Multiple_Files']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_019['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
    Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_019['emailData_Upload_Multiple_Submission_Assets']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_019['emailVerifyMultipleAssets']}    Upload with muliple assets
    Upload SOV and Loss Run Documents    @{TC_E2E_019['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_019['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_019['CardName']}    ${TC_E2E_019['expectedAnalysisData']}    ${TC_E2E_019['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_019['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_019['stageNo']}

TC_E2E_038
    [Tags]    E2E-Email_Verification   
    [Documentation]    End to End Testing for New Submission - (Bind stage)  Email Verifications"
    IF    '${new_submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_038['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_038['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_038['PolicyInfo']}    ${TC_E2E_038['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_038['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_038['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_038['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_038['SummaryTableHeader']}    ${TC_E2E_038['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_038['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_038['Risk360_Card_Names']}    ${TC_E2E_038['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_038['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_038['taskDetails']}
    Create New Mail For Upload 40 MB File    ${TC_E2E_038['emailData_Upload_40_MB_File']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_038['emailVerifyFor40Mb']}    Upload with <40mb file
    Create New Mail For Upload Multiple Files    ${TC_E2E_038['emailData_Upload_Multiple_Files']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_038['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
    Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_038['emailData_Upload_Multiple_Submission_Assets']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_038['emailVerifyMultipleAssets']}    Upload with muliple assets
    Upload SOV and Loss Run Documents    @{TC_E2E_038['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_038['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_038['CardName']}    ${TC_E2E_038['expectedAnalysisData']}    ${TC_E2E_038['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_038['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_038['stageNo']}

TC_E2E_039
    [Tags]    E2E-Email_Verification   
    [Documentation]    End to End Testing for New Submission - (Bind stage)  Email Verifications"
    IF    '${new_submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_039['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_039['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_039['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_039['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_039['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_039['SummaryTableHeader']}    ${TC_E2E_039['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_039['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_039['Risk360_Card_Names']}    ${TC_E2E_039['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_039['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_039['taskDetails']}
    Create New Mail For Upload 40 MB File    ${TC_E2E_039['emailData_Upload_40_MB_File']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_039['emailVerifyFor40Mb']}    Upload with <40mb file
    Create New Mail For Upload Multiple Files    ${TC_E2E_039['emailData_Upload_Multiple_Files']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_039['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
    Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_039['emailData_Upload_Multiple_Submission_Assets']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_039['emailVerifyMultipleAssets']}    Upload with muliple assets
    Upload SOV and Loss Run Documents    @{TC_E2E_039['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_039['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_039['CardName']}    ${TC_E2E_039['expectedAnalysisData']}    ${TC_E2E_039['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_039['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_039['stageNo']}

TC_E2E_040
    [Tags]    E2E-Email_Verification   
    [Documentation]    End to End Testing for New Submission - (Bind stage)  Email Verifications"
    IF    '${new_submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_040['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_040['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_040['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_040['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_040['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_040['SummaryTableHeader']}    ${TC_E2E_040['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_040['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_040['Risk360_Card_Names']}    ${TC_E2E_040['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_040['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_040['taskDetails']}
    Create New Mail For Upload 40 MB File    ${TC_E2E_040['emailData_Upload_40_MB_File']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_040['emailVerifyFor40Mb']}    Upload with <40mb file
    Create New Mail For Upload Multiple Files    ${TC_E2E_040['emailData_Upload_Multiple_Files']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_040['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
    Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_040['emailData_Upload_Multiple_Submission_Assets']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_040['emailVerifyMultipleAssets']}    Upload with muliple assets
    Upload SOV and Loss Run Documents    @{TC_E2E_040['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_040['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_040['CardName']}    ${TC_E2E_040['expectedAnalysisData']}    ${TC_E2E_040['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_040['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_040['stageNo']}

TC_E2E_041
    [Tags]    E2E-Email_Verification   
    [Documentation]    End to End Testing for New Submission - (Bind stage)  Email Verifications"
    IF    '${new_submission_id_email}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_email}    @{TC_E2E_041['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_041['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_041['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_041['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_041['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_041['SummaryTableHeader']}    ${TC_E2E_041['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_041['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_041['Risk360_Card_Names']}    ${TC_E2E_041['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_041['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_041['taskDetails']}
    Create New Mail For Upload 40 MB File    ${TC_E2E_041['emailData_Upload_40_MB_File']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_041['emailVerifyFor40Mb']}    Upload with <40mb file
    Create New Mail For Upload Multiple Files    ${TC_E2E_041['emailData_Upload_Multiple_Files']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_041['emailVerifyForMultipleFiles']}    Upload with mulitiple file types
    Create New Mail For Upload Multiple Submission Assets    ${TC_E2E_041['emailData_Upload_Multiple_Submission_Assets']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email Data    ${TC_E2E_041['emailVerifyMultipleAssets']}    Upload with muliple assets
    Upload SOV and Loss Run Documents    @{TC_E2E_041['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_041['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_041['CardName']}    ${TC_E2E_041['expectedAnalysisData']}    ${TC_E2E_041['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_041['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_041['stageNo']}

TC_E2E_070
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Cleared stage)  with Referral Submission"
    ${submission}    Run Pre-requiste Steps for Stage 1 
    IF    '${submission}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
        Set Suite Variable    ${submission_id_Referral}   ${submission}
        Advance Stage    ${TC_E2E_070['stageNo']}    
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_070['stage']}
        Click Edit Submission
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_070['SummaryHeader']}
        # Run Keyword And Continue On Failure    Verify Premium Amount   
        # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_070['SummaryTableHeader']}    ${TC_E2E_070['SummaryTableData']}
        Click Answers Tab
        Click Edit Submission
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_070['expectedQuestion']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_070['Risk360_Card_Names']}    ${TC_E2E_070['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_070['taskdata']}
        Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_070['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_070['taskDetails']}
        Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_070['taskupdateddetails']}
        Create New Mail    ${TC_E2E_070['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_070['emailVerify']}
        # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_070['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_070['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
        Run Keyword And Continue On Failure    Verify Referral Button 
        Create New Refer Submission    ${TC_E2E_070['Refer']}
        Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_070['Refer']['expectedText']}    
        Run Keyword And Continue On Failure    Verify Referral Pending
        Run Keyword And Continue On Failure    Verify Advance Stage Disable When Referral Pending    ${TC_E2E_070['stage']}
        Decline New Refer Submission From Pending Using Referral User    ${submission_id_Referral}    @{TC_E2E_070['SubmissionColumnNames']}

TC_E2E_015
    [Tags]       E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with Referral"
    # ${submission}    Run Pre-requiste Steps for Stage 1 & 2 
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
        # Create User If the User is not present    ${NewUser}
        # Create User If the User is not present    ${ReferralUser}
        # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
        Click All submissions option
        Select Submission using submission id    ${submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Advance Stage    ${TC_E2E_015['stageNo']}    
        Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_015['stage']}
        Click Edit Submission
        Click and verify Clearance tab
        Create Child submission    ${TC_E2E_011['Covered']}
        ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_015['stageNo']}
        Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
        IF    ${child_submission_status_1} != False
            ${newSubmissionID}    Get New Submission ID After Child Submission
            Set Suite Variable    ${new_submission_id_Referral}   ${newSubmissionID}
            Navigate To All Submissions page from submissions 
            Select Submission using submission id    ${newSubmissionID}    @{TC_E2E_015['SubmissionColumnNames']}
            Wait For Processing Stage    ${TC_E2E_015['stageNo']}
            Run Keyword And Continue On Failure    Verify Summary Menu is displayed
            Switch To Summary Tab    ${TC_E2E_015['SummaryHeader']}
            # Run Keyword And Continue On Failure    Verify Premium Amount   
            Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_015['SummaryTableHeader']}    ${TC_E2E_015['SummaryTableData']}
            Click Answers Tab
            Click Edit Submission
            Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_015['expectedQuestion']}
            Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_015['Risk360_Card_Names']}    ${TC_E2E_015['Risk360_Card_Pages_Names']}
            Create New Task    ${TC_E2E_015['taskdata']}
            Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_015['taskdata']}
            Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_015['taskDetails']}
            #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_042['taskdata']}
            Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_015['taskupdateddetails']}
            Create New Mail    ${TC_E2E_015['emailData']}
            Run Keyword And Continue On Failure    Verify Email Sent Successfully
            Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_015['emailVerify']}
            Upload SOV and Loss Run Documents    @{TC_E2E_015['FileName']}
            Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_015['stageNo']}
            Open uploaded SOV File   
            Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
            ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
            Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
            Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
            # Verify Policies Data From Loss Run File
            Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_015['CardName']}    ${TC_E2E_015['expectedAnalysisData']}    ${TC_E2E_015['expectedTableData']}
            # Verify Schema by downloading the json file
            Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_015['expectedWorkFlowHistory']}
            Run Keyword And Continue On Failure    Save Submission And verify popup
            Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_015['stageNo']}
            Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
            Run Keyword And Continue On Failure    Verify Referral Button 
            Create New Refer Submission    ${TC_E2E_015['Refer']}
            Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_015['Refer']['expectedText']}    
            Run Keyword And Continue On Failure    Verify Referral Pending
            Run Keyword And Continue On Failure    Verify Advance Stage Disable When Referral Pending    ${TC_E2E_015['stage']}
            Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_015['SubmissionColumnNames']}
        ELSE IF    '${child_submission_status_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_020  
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  with Referral Submission"
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_020['expectedWorkFlowHistory']}
    # Save Submission And verify popup
    # Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_020['stageNo']}
    Advance Stage    ${TC_E2E_020['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_020['PolicyInfo']}    ${TC_E2E_020['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_020['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_020['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_020['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_020['SummaryTableHeader']}    ${TC_E2E_020['SummaryTableData']}
    Click Answers Tab
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_020['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_020['Risk360_Card_Names']}    ${TC_E2E_020['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_020['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_020['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_020['taskDetails']}
    #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_042['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_020['taskupdateddetails']}
    Create New Mail    ${TC_E2E_020['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_020['emailVerify']}
    Upload SOV and Loss Run Documents    @{TC_E2E_020['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_020['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_020['CardName']}    ${TC_E2E_020['expectedAnalysisData']}    ${TC_E2E_020['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_020['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_020['stageNo']}
    Run Keyword And Continue On Failure    Verify Referral Button 
    Create New Refer Submission    ${TC_E2E_020['Refer']}
    Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_020['Refer']['expectedText']}    
    Run Keyword And Continue On Failure    Verify Referral Pending
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}

TC_E2E_042
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Bind stage)  with Referral Submission"
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_Referral}    @{TC_E2E_042['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_042['expectedWorkFlowHistory']}
    # Save Submission And verify popup
    # Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_042['stageNo']}
    Advance Stage    ${TC_E2E_042['stageNo']}
    Run Keyword And Continue On Failure    Re Enter the Policy Information details    ${TC_E2E_042['PolicyInfo']}    ${TC_E2E_042['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_042['stage']}
    Run Keyword And Continue On Failure     Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_042['SummaryHeader']}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_042['PolicyInfo']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_042['PolicyInfo']}    ${TC_Forms_01}
    #Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_042['PolicyInfo']}  
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_042['SummaryTableHeader']}    ${TC_E2E_042['SummaryTableData']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_042['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_042['Risk360_Card_Names']}    ${TC_E2E_042['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_042['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_042['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_042['taskDetails']}
    #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_042['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_042['taskupdateddetails']}
    # Create New Mail    ${TC_E2E_042['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_042['emailVerify']}
    # Upload SOV and Loss Run Documents    @{TC_E2E_042['FileName']}
    # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_042['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_042['CardName']}    ${TC_E2E_042['expectedAnalysisData']}    ${TC_E2E_042['expectedTableData']}
    #Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_042['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_042['stageNo']}
    Run Keyword And Continue On Failure    Verify Referral Button
    Create New Refer Submission    ${TC_E2E_042['Refer']}
    Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_042['Refer']['expectedText']}    
    Run Keyword And Continue On Failure    Verify Referral Pending
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}

TC_E2E_043
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Bind stage)  with Referral Submission"
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_Referral}    @{TC_E2E_043['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_043['expectedWorkFlowHistory']}
    # Save Submission And verify popup
    # Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_043['stageNo']}
    Advance Stage    ${TC_E2E_043['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_043['stage']}
    Run Keyword And Continue On Failure     Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_043['SummaryHeader']}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_043['PolicyInfo']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_043['PolicyInfo']}    ${TC_Forms_01}
    #Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_043['PolicyInfo']}  
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_043['SummaryTableHeader']}    ${TC_E2E_043['SummaryTableData']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_043['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_043['Risk360_Card_Names']}    ${TC_E2E_043['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_043['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_043['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_043['taskDetails']}
    #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_043['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    # Create New Mail    ${TC_E2E_043['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_043['emailVerify']}
    # Upload SOV and Loss Run Documents    @{TC_E2E_043['FileName']}
    # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_043['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_043['CardName']}    ${TC_E2E_043['expectedAnalysisData']}    ${TC_E2E_043['expectedTableData']}
    #Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_043['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_043['stageNo']}
    Run Keyword And Continue On Failure    Verify Referral Button
    Create New Refer Submission    ${TC_E2E_043['Refer']}
    Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_043['Refer']['expectedText']}    
    Run Keyword And Continue On Failure    Verify Referral Pending
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}

TC_E2E_044
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Bind stage)  with Referral Submission"
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_Referral}    @{TC_E2E_044['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_044['expectedWorkFlowHistory']}
    # Save Submission And verify popup
    # Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_044['stageNo']}
    Advance Stage    ${TC_E2E_044['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_044['stage']}
    Run Keyword And Continue On Failure     Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_044['SummaryHeader']}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_044['PolicyInfo']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_044['PolicyInfo']}    ${TC_Forms_01}
    #Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_044['PolicyInfo']}  
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_044['SummaryTableHeader']}    ${TC_E2E_044['SummaryTableData']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_044['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_044['Risk360_Card_Names']}    ${TC_E2E_044['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_044['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_044['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_044['taskDetails']}
    #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_044['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    # Create New Mail    ${TC_E2E_044['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_044['emailVerify']}
    # Upload SOV and Loss Run Documents    @{TC_E2E_044['FileName']}
    # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_044['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_044['CardName']}    ${TC_E2E_044['expectedAnalysisData']}    ${TC_E2E_044['expectedTableData']}
    #Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_044['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_044['stageNo']}
    Run Keyword And Continue On Failure    Verify Referral Button
    Create New Refer Submission    ${TC_E2E_044['Refer']}
    Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_044['Refer']['expectedText']}    
    Run Keyword And Continue On Failure    Verify Referral Pending
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}

TC_E2E_045
    [Tags]    E2E-Referral
    [Documentation]    End to End Testing for New Submission - (Bind stage)  with Referral Submission"
    IF    '${submission_id_Referral}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_Referral}    @{TC_E2E_045['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_045['expectedWorkFlowHistory']}
    # Save Submission And verify popup
    # Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_045['stageNo']}
    Advance Stage    ${TC_E2E_045['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_045['stage']}
    Run Keyword And Continue On Failure     Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_045['SummaryHeader']}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_045['PolicyInfo']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_045['PolicyInfo']}    ${TC_Forms_01}
    #Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_045['PolicyInfo']}  
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_045['SummaryTableHeader']}    ${TC_E2E_045['SummaryTableData']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_045['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_045['Risk360_Card_Names']}    ${TC_E2E_045['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_045['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_045['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_045['taskDetails']}
    #Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_045['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    # Create New Mail    ${TC_E2E_045['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_045['emailVerify']}
    # Upload SOV and Loss Run Documents    @{TC_E2E_045['FileName']}
    # Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_045['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_045['CardName']}    ${TC_E2E_045['expectedAnalysisData']}    ${TC_E2E_045['expectedTableData']}
    #Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_045['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_045['stageNo']}
    Run Keyword And Continue On Failure    Verify Referral Button
    Create New Refer Submission    ${TC_E2E_045['Refer']}
    Run Keyword And Continue On Failure    Verify the Refer Submission data    ${TC_E2E_045['Refer']['expectedText']}    
    Run Keyword And Continue On Failure    Verify Referral Pending
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}
    Decline New Refer Submission From Pending Using Referral User    ${new_submission_id_Referral}    @{TC_E2E_020['SubmissionColumnNames']}

TC_E2E_016
    [Tags]    E2E-LostSubmission   
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with Lost"
    ${submission}    Run Pre-requiste Steps for Stage 1 & 2 
    IF    '${submission}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    Advance Stage    ${TC_E2E_016['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_016['stage']}
    Click Edit Submission
    # Click and verify Clearance tab
    # Create Child submission    ${TC_E2E_011['Covered']}
    # Wait For Processing Stage    ${TC_E2E_016['stageNo']}
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_016['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_1}   ${newSubmissionID}  
    Navigate To All Submissions page from submissions 
    Select Submission using submission id    ${newSubmissionID}    @{TC_E2E_016['SubmissionColumnNames']}
    Wait For Processing Stage    ${TC_E2E_016['stageNo']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_016['SummaryHeader']}
    # Run Keyword And Continue On Failure    Verify Premium Amount
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_016['SummaryTableHeader']}    ${TC_E2E_016['SummaryTableData']}
    Click Answers Tab
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_016['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_016['Risk360_Card_Names']}    ${TC_E2E_016['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_016['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_016['taskDetails']}
    Create New Mail    ${TC_E2E_016['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_016['emailVerify']}
    Upload SOV and Loss Run Documents    @{TC_E2E_016['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_016['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_016['CardName']}    ${TC_E2E_016['expectedAnalysisData']}    ${TC_E2E_016['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_016['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_016['stageNo']}
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    Lost Submission    ${TC_E2E_016['lost']}
    Run Keyword And Continue On Failure    Verify lost Tagname
    Reactive the Rejected Submission
    ELSE IF    '${child_submission_status_1}' == 'False'
        FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_016 Stage 3 - Under Review.
    END

TC_E2E_021  
    [Tags]    E2E-LostSubmission
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  with Lost Submission"
    ${submission_id}    Run Pre-requiste for Step 1 2 & 3
    IF    '${submission_id}' == 'False'
        Skip    New LostSubmission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    Advance Stage    ${TC_E2E_021['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_021['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_021['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_021['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_021['SummaryTableHeader']}    ${TC_E2E_021['SummaryTableData']}
    Click Answers Tab
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_021['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_021['Risk360_Card_Names']}    ${TC_E2E_021['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_021['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_021['taskDetails']}
    Create New Mail    ${TC_E2E_021['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_021['emailVerify']}
    Upload SOV and Loss Run Documents    @{TC_E2E_021['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_021['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_021['CardName']}    ${TC_E2E_021['expectedAnalysisData']}    ${TC_E2E_021['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_021['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_021['stageNo']}
    Lost Submission    ${TC_E2E_021['lost']}
    Run Keyword And Continue On Failure    Verify lost Tagname

TC_E2E_022  
    [Tags]    E2E-NotTaken
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  with Not Taken"
    ${submission_id}    Run Pre-requiste for Step 1 2 & 3
    IF    '${submission_id}' == 'False'
        Skip    New LostSubmission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    Navigate To All Submissions page from submissions 
    Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_011['SubmissionColumnNames']}
    Wait For Processing Stage    ${TC_E2E_011['stageNo']}
    Advance Stage    ${TC_E2E_022['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_022['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_022['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_022['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_022['SummaryTableHeader']}    ${TC_E2E_022['SummaryTableData']}
    Click Answers Tab
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_022['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_022['Risk360_Card_Names']}    ${TC_E2E_022['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_022['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_022['taskDetails']}
    Create New Mail    ${TC_E2E_022['emailData']}
    Run Keyword And Continue On Failure    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_022['emailVerify']}
    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_022['stageNo']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_022['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_022['stageNo']}
    # Run Keyword And Continue On Failure    Verify the Error popup when mandate fields left empty    ${TC_E2E_022['NotTakenReasons']}    ${TC_E2E_022['NotTakenDetails']}    ${TC_E2E_022['Action']}


TC_E2E_004
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - In Draft Stage: Sanction Screening Flagged with "False Positive"
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_004['FileName']}    @{TC_E2E_004['SubmissionColumnNames']}   
    Select Submission using submission id     ${submission_id}    @{TC_E2E_004['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_ss_1}    ${submission_id}
    IF    '${submission_id_ss_1}' != 'False'
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Click Edit Submission
        # Click and verify Clearance tab
        #     Click Insured Tab
        #     Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_004['expectedPDFText']}
        #     Fill the data for issue fields    ${TC_E2E_004['SicCode']}    ${TC_E2E_004['SicDescription']}    ${TC_E2E_004['NAICSCode']}
        #     Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
        #     Click Processing Tab
        #     Fill the data for issue fields in processing    ${TC_E2E_004['UnderwriterName']}    ${TC_E2E_004['UnderwriterEmail']}    ${TC_E2E_004['OperationsName']}      
        #     ...    ${TC_E2E_004['OperationsEmail']}    ${TC_E2E_004['UnderwrittingOffice']}    ${TC_E2E_004['Channel']}
        #     Click Producer Tab
        #     Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_004['expectedTextInProducer']}
        #     Fill the data for issues field in Producer    ${TC_E2E_004['ProducerName']}      ${TC_E2E_004['ProducerEmail']}    ${TC_E2E_004['ProducerCode']}
        #     Click Coverage Tab
        #     Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_004['EffectiveDate']}     ${TC_E2E_004['ExpirationDate']}     ${TC_E2E_004['Product']}
        #     Fill the data for issues field in Coverage    ${TC_E2E_004['Covered']}
        #     Click Issues Tab
        #    @{expectedIssues}    Create List    ${TC_E2E_004['SicCode']}    ${TC_E2E_004['SicDescription']} 
        #      ...    ${TC_E2E_004['NAICSCode']}    ${TC_E2E_004['UnderwriterName']}    ${TC_E2E_004['UnderwriterEmail']} 
        #      ...    ${TC_E2E_004['UnderwrittingOffice']}     ${TC_E2E_004['OperationsName']}    ${TC_E2E_004['OperationsEmail']}   
        #      ...    ${TC_E2E_004['Channel']}    ${TC_E2E_004['ProducerName']}
        #     Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
        #     Click Finish Tab
        #     Run Keyword And Continue On Failure    Verify and click the save and close button
        #     Switch to Documents
        #    @{expectedModification}    Create List    "${TC_E2E_004['SicCode']}"    "${TC_E2E_004['SicDescription']}"  
        #      ...    "${TC_E2E_004['NAICSCode']}"    "${TC_E2E_004['UnderwriterName']}"    "${TC_E2E_004['UnderwriterEmail']}"   
        #      ...    "${TC_E2E_004['UnderwrittingOffice']}"     "${TC_E2E_004['OperationsName']}"    "${TC_E2E_004['OperationsEmail']}"    "${TC_E2E_004['Channel']}"   
        #      ...    "${TC_E2E_004['ProducerName']}"    "${TC_E2E_004['ProducerCode']}"    "${TC_E2E_004['ProducerEmail']}"    "${TC_E2E_004['Covered']['Product']}"    "${TC_E2E_004['Covered']['ProductSegment']}" 
        #     Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
        # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
        # Wait For Processing Stage
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Fill and Verify Clearance Tab For 11420Corp    ${TC_E2E_004}
        Run Keyword And Continue On Failure    Verify WorkFlow History is Empty For Draft stage
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Navigate To All Submissions page from submissions
        Select Submission using submission id    ${submission_id_ss_1}    @{TC_E2E_004['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Run Keyword And Continue On Failure    Verify Sanction Screening Flagged is visible in the submission
        Run Keyword And Continue On Failure    Verify Task Number in the submission    ${TC_E2E_004['taskNumber']}
        Run Keyword And Continue On Failure    Verify and click the Task In Submission
        Run Keyword And Continue On Failure    Verify the auto generated task details sanction screening    ${TC_E2E_004['taskDetails']}
        Run Keyword And Continue On Failure    Complete Task with the given reason    ${TC_E2E_004['reason']}
        Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason    ${TC_E2E_004['reason']}
        Run Keyword And Continue On Failure    Verify Sanction Screening Flagged is not visible
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_004['expectedWorkFlowHistory']}
    ELSE IF    '${submission_id_ss_1}' == 'False'
        FAIL    New SanctionScreening is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_031
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) without SOV Loss run upload in Stage 2, since we have uploaded in Stage 1"
    IF    '${submission_id_ss_1}' == 'False'
        Skip    New SanctionScreening is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_031['stage']}
    Click Edit Submission
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_031['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_031['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_031['Risk360_Card_Names']}    ${TC_E2E_031['Risk360_Card_Pages_Names']}
    # Create New Task    ${TC_E2E_031['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_031['taskDetails']}
    # Create New Mail    ${TC_E2E_031['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_031['emailVerify']}
    # Open uploaded SOV File   
    # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_031['CardName']}    ${TC_E2E_031['expectedAnalysisData']}    ${TC_E2E_031['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_031['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject

TC_E2E_032
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  without SOV and LR upload"
    IF    '${submission_id_ss_1}' == 'False'
        Skip    New SanctionScreening is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_032['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_032['stage']}
    Click Edit Submission
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_032['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_ss_1}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_032['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_032['SummaryHeader']}
        # Run Keyword And Continue On Failure    Verify Premium Amount    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_032['SummaryTableHeader']}    ${TC_E2E_032['SummaryTableData']}
        Click Edit Submission
        Click Answers Tab
        # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_032['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_032['expectedTitle']}
        # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_032['Risk360_Card_Names']}    ${TC_E2E_032['Risk360_Card_Pages_Names']}
        # Create New Task    ${TC_E2E_032['taskdata']}
        # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_032['taskDetails']}
        # Create New Mail    ${TC_E2E_032['emailData']}
        # Run Keyword And Continue On Failure    Verify Email Sent Successfully
        # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_032['emailVerify']}
        # Open uploaded SOV File   
        # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
        # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
        # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_032['CardName']}    ${TC_E2E_032['expectedAnalysisData']}    ${TC_E2E_032['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_032['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_032['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${new_submission_id_ss_1}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_033
    [Tags]    E2E-SanctionScreening    
    [Documentation]    End to End Testing for New Submission - (Quoted stage)  with SOV and LR upload"
    IF    '${new_submission_id_ss_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_033['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_033['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Switch To Summary Tab    ${TC_E2E_033['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information In Summary Tab    ${TC_E2E_033['PolicyInfo']}   
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_033['SummaryTableHeader']}    ${TC_E2E_033['SummaryTableData']}
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_033['expectedQuestion']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_033['Risk360_Card_Names']}    ${TC_E2E_033['Risk360_Card_Pages_Names']}
    # Create New Task    ${TC_E2E_033['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_033['taskDetails']}
    # Create New Mail    ${TC_E2E_033['emailData']}
    # Run Keyword And Continue On Failure    Verify Email Sent Successfully
    # Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_033['emailVerify']}
    # Open uploaded SOV File   
    # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_003['SOVFile']}
    # ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_033['CardName']}    ${TC_E2E_033['expectedAnalysisData']}    ${TC_E2E_033['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_033['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_033['stageNo']}

TC_E2E_034
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_ss_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Pre-requiste for Step 1 2 3 & 4
    Advance Stage    ${TC_E2E_027['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_027['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_023['PolicyInfo']}
    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_023['stage']}    ${TC_E2E_023['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_023['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_034['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_023['PolicyInfo']}
    #  Verify the Workflow in Summary Tab
    #Issue: The Child Submission in the Summary Tab is not stable.
    #Impact: We are unable to verify if the dependent child is displayed/present as expected
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_034['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']} 
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
       #Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Click and verify Clearance tab
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_031['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_031['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_008['Risk360_Card_Names']}    ${TC_E2E_008['Risk360_Card_Pages_Names']}
    # Task tab
    # Create New Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
    # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
    # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_027['stageNo']}
    Open uploaded SOV File
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_027['ProductName']}
    #WorkFlow History ----Integration needed for execution ,
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_027['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_027['stageNo']}

TC_E2E_035
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_ss_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_035['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_035['stage']}
    Run Keyword And Continue On Failure    Verify Summary Menu is displayed
    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_024['PolicyInfo']}
    # Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_024['stage']}    ${TC_E2E_024['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_024['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_024['PolicyInfo']}
    #Issue: The Child Submission in the Summary Tab is not stable.
    #Impact: We are unable to verify if the dependent child is displayed/present as expected
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']}
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Click and verify Clearance tab
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_024['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_035['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_024['Risk360_Card_Names']}    ${TC_E2E_024['Risk360_Card_Pages_Names']}
    # Task tab
    # Create New Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_024['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_024['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_024['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_024['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_Email_001['DraftemailData']}
    # Save and verify mail in Draft    ${TC_Email_001['DraftemailData']}
    # Create New Mail With Missing Data    ${TC_Email_001['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_035['stageNo']}
    Open uploaded SOV File  
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
    #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_024['ProductName']}
    #WorkFlow History ----Integration needed for execution ,
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_035['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_035['stageNo']}

TC_E2E_036
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_ss_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    # Run Pre-requiste for Step 1 2 3 & 4
    Advance Stage    ${TC_E2E_036['stageNo']} 
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_036['stage']}
    # Task Tab
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}
    # Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_036['taskDetails1']}
    # Run Keyword And Continue On Failure    Complete Task with the given reason for Booking stage    ${TC_E2E_036['taskreason']}
    Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason for booking    ${TC_E2E_036['taskreason']}
    Run Keyword And Continue On Failure    Click Edit Submission
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_024['PolicyInfo']}
    # Run Keyword And Continue On Failure    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_025['stage']}    ${TC_E2E_025['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_011['SummaryTableHeader']}    ${TC_E2E_025['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_017['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_024['stage']} 
    # Step No 11 to 13[Forms Verification Pending, Changes need to be done]
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    #  Answer Tab
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_025['expectedQuestion']}
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_029['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_025['Risk360_Card_Names']}    ${TC_E2E_025['Risk360_Card_Pages_Names']}
    # Task tab
    # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_025['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_025['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_025['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_025['taskupdateddetails']} 
    #Email Tab 
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_025['DraftemailData']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_025['DraftemailData']}
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_025['emailData_Mising']}    ${TC_Email_001['Expected_PopUp']}
    # Document Tab
    Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_029['stageNo']}
    Run Keyword And Continue On Failure    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}
   #Clearance Tab--Verification
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_025['ProductName']} 
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_036['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_036['stageNo']}

TC_E2E_037
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  with SOV and LR upload"
    IF    '${new_submission_id_ss_1}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_ss_1}    @{TC_E2E_017['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_037['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_037['stage']}
    Click Edit Submission
    # Verify Summary Menu is displayed
    # Run Keyword And Continue On Failure    Verify All Side menu options are Displayed
    # Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_025['PolicyInfo']}
    # Run Keyword And Continue On Failure    Switch to Summary
    # Run Keyword And Continue On Failure    verify Header Displayed    ${TC_E2E_026['stage']}    ${TC_E2E_026['Tab_Name']}
    # Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_026['SummaryTableHeader']}    ${TC_E2E_026['SummaryTableData']}
    # Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_026['PolicyInfo']}    ${TC_Forms_01}    
    # Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_026['PolicyInfo']}
    # Run Keyword And Continue On Failure    verify the entered Policy Information    ${TC_E2E_026['PolicyInfo']}
    # Run Keyword And Continue On Failure    Verify Child Submission Should be Displayed in Summary Tab    ${TC_E2E_017['product']}
    # # Run Keyword And Continue On Failure    verify Account History are Editable    ${new_submission_id_1}    ${TC_E2E_026['stage']} 
    #  Answer Tab
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_026['expectedQuestion']}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_01}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Filling    ${TC_Forms_02}
    # Run Keyword And Continue On Failure    Complete Forms Tab Details Verification    ${TC_Forms_02}
    Click Answers Tab
    # Risk360 Tab
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_030['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_026['Risk360_Card_Names']}    ${TC_E2E_026['Risk360_Card_Pages_Names']}
   # Task tab
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Create New Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_026['priority']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_026['taskupdateddetails']}
    # Click Answers Tab
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_026['taskdata']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_026['taskupdateddetails']}
    #Email Tab
    # Run Keyword And Continue On Failure    Verify Discard Button visible    ${TC_E2E_026['DraftemailData']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_026['DraftemailData']}
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_026['emailData_Mising']}    ${TC_E2E_026['Expected_PopUp']}
    # Document Tab
    Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    @{TC_E2E_022['FileName']}
    Run Keyword And Continue On Failure    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_037['stageNo']}
    Run Keyword And Continue On Failure    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_022['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_022['CardName']}    ${TC_E2E_022['expectedAnalysisData']}    ${TC_E2E_022['expectedTableData']}  
    # clearance tab
    # Run Keyword And Continue On Failure    verify Clearance Tab    ${TC_E2E_026['ProductName']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_037['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Advance Stage is InActive

TC_E2E_005
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - In Draft Stage: Sanction Screening Flagged with "Confirmed – TRUE HIT"
    
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_005['FileName']}    @{TC_E2E_005['SubmissionColumnNames']}
    IF    '${submission_id}' != 'False'
        Select Submission using submission id     ${submission_id}    @{TC_E2E_005['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Click Edit Submission
        # Click and verify Clearance tab
        # Click Insured Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_005['expectedPDFText']}
        # Fill the data for issue fields    ${TC_E2E_005['SicCode']}    ${TC_E2E_005['SicDescription']}    ${TC_E2E_005['NAICSCode']}
                # Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
                    # Click Processing Tab
        #  Fill the data for issue fields in processing    ${TC_E2E_005['UnderwriterName']}    ${TC_E2E_005['UnderwriterEmail']} 
            #  ...    ${TC_E2E_005['OperationsName']}    ${TC_E2E_005['OperationsEmail']}    ${TC_E2E_005['UnderwrittingOffice']}    ${TC_E2E_005['Channel']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_005['expectedTextInProducer']}
        # Fill the data for issues field in Producer    ${TC_E2E_005['ProducerName']}      ${TC_E2E_005['ProducerEmail']}    ${TC_E2E_005['ProducerCode']}
        # Click Coverage Tab
        # Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_005['EffectiveDate']}     ${TC_E2E_005['ExpirationDate']}     ${TC_E2E_005['Product']}
        # Fill the data for issues field in Coverage    ${TC_E2E_005['Covered']}
        # Click Issues Tab
        #  @{expectedIssues}    Create List    ${TC_E2E_005['SicCode']}    ${TC_E2E_005['SicDescription']} 
        #  ...    ${TC_E2E_005['NAICSCode']}    ${TC_E2E_005['UnderwriterName']}    ${TC_E2E_005['UnderwriterEmail']} 
        #  ...    ${TC_E2E_005['UnderwrittingOffice']}     ${TC_E2E_005['OperationsName']}    ${TC_E2E_005['OperationsEmail']}   
            #  ...    ${TC_E2E_005['Channel']}    ${TC_E2E_005['ProducerName']}
        # Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
        # Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
        # Click Finish Tab
        # Run Keyword And Continue On Failure    Verify and click the save and close button
        # Switch to Documents
        #  @{expectedModification}    Create List    "${TC_E2E_005['SicCode']}"    "${TC_E2E_005['SicDescription']}"  
        #  ...    "${TC_E2E_005['NAICSCode']}"    "${TC_E2E_005['UnderwriterName']}"    "${TC_E2E_005['UnderwriterEmail']}"   
        #  ...    "${TC_E2E_005['UnderwrittingOffice']}"     "${TC_E2E_005['OperationsName']}"    "${TC_E2E_005['OperationsEmail']}"    "${TC_E2E_005['Channel']}"   
        #  ...    "${TC_E2E_005['ProducerName']}"    "${TC_E2E_005['ProducerCode']}"     "${TC_E2E_005['ProducerEmail']}"    "${TC_E2E_005['Covered']['Product']}"    "${TC_E2E_005['Covered']['ProductSegment']}" 
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
            # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
        # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
        # Wait For Processing Stage
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Fill and Verify Clearance Tab For 11420Corp    ${TC_E2E_004}
        Run Keyword And Continue On Failure    Verify WorkFlow History is Empty For Draft stage
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Navigate To All Submissions page from submissions
        Select Submission using submission id    ${submission_id}     @{TC_E2E_005['SubmissionColumnNames']}    
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Run Keyword And Continue On Failure    Verify Sanction Screening Flagged is visible in the submission
        Run Keyword And Continue On Failure    Verify Task Number in the submission    ${TC_E2E_005['taskNumber']}
        Run Keyword And Continue On Failure    Verify and click the Task In Submission
        Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_005['taskDetails']}
        Run Keyword And Continue On Failure    Complete Task with the given reason    ${TC_E2E_005['reason']}
        Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason    ${TC_E2E_005['reason']}
    ELSE IF    '${submission_id}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_006
    [Tags]    E2E-SanctionScreening
    [Documentation]    End to End Testing for New Submission - In Draft Stage: Sanction Screening Flagged with "Confirmed – NO HIT"
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_006['FileName']}    @{TC_E2E_006['SubmissionColumnNames']}
    IF    '${submission_id}' != 'False'
        Select Submission using submission id     ${submission_id}    @{TC_E2E_006['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Click Edit Submission
        # Click and verify Clearance tab
        # Click Insured Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_006['expectedPDFText']}
        # Fill the data for issue fields    ${TC_E2E_006['SicCode']}    ${TC_E2E_006['SicDescription']}    ${TC_E2E_006['NAICSCode']}
        # Run Keyword And Continue On Failure    Verify User Mod is message for updated fields
        # Click Processing Tab
        # Fill the data for issue fields in processing    ${TC_E2E_006['UnderwriterName']}    ${TC_E2E_006['UnderwriterEmail']} 
        #  ...    ${TC_E2E_006['OperationsName']}    ${TC_E2E_006['OperationsEmail']}    ${TC_E2E_006['UnderwrittingOffice']}    ${TC_E2E_006['Channel']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify PDF Data in Producer Tab    @{TC_E2E_006['expectedTextInProducer']}
        # Fill the data for issues field in Producer    ${TC_E2E_006['ProducerName']}      ${TC_E2E_006['ProducerEmail']}    ${TC_E2E_006['ProducerCode']}
        # Click Coverage Tab
        # Run Keyword And Continue On Failure    Verify the Coverage data    ${TC_E2E_006['EffectiveDate']}     ${TC_E2E_006['ExpirationDate']}     ${TC_E2E_006['Product']}
        # Fill the data for issues field in Coverage    ${TC_E2E_006['Covered']}
        # Click Issues Tab
        #  @{expectedIssues}    Create List    ${TC_E2E_006['SicCode']}    ${TC_E2E_006['SicDescription']} 
        #  ...    ${TC_E2E_006['NAICSCode']}    ${TC_E2E_006['UnderwriterName']}    ${TC_E2E_006['UnderwriterEmail']} 
        #  ...    ${TC_E2E_006['UnderwrittingOffice']}     ${TC_E2E_006['OperationsName']}    ${TC_E2E_006['OperationsEmail']}   
        #  ...    ${TC_E2E_006['Channel']}    ${TC_E2E_006['ProducerName']}
        # Run Keyword And Continue On Failure    Verify updated datas in Issues Tab    @{expectedIssues}
        # Click Finish Tab
        # Run Keyword And Continue On Failure    Verify and click the save and close button
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_006['SicCode']}"    "${TC_E2E_006['SicDescription']}"  
        #  ...    "${TC_E2E_006['NAICSCode']}"    "${TC_E2E_006['UnderwriterName']}"    "${TC_E2E_006['UnderwriterEmail']}"   
        #  ...    "${TC_E2E_006['UnderwrittingOffice']}"     "${TC_E2E_006['OperationsName']}"    "${TC_E2E_006['OperationsEmail']}"    "${TC_E2E_006['Channel']}"   
        #  ...    "${TC_E2E_006['ProducerName']}"    "${TC_E2E_006['ProducerCode']}"     "${TC_E2E_006['ProducerEmail']}"    "${TC_E2E_006['Covered']['Product']}"    "${TC_E2E_006['Covered']['ProductSegment']}" 
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
            # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
        # Wait For Processing Stage
        # Switch to Documents
        # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Fill and Verify Clearance Tab For 11420Corp    ${TC_E2E_004}
        Run Keyword And Continue On Failure    Verify WorkFlow History is Empty For Draft stage
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Navigate To All Submissions page from submissions
        Select Submission using submission id    ${submission_id}    @{TC_E2E_006['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Run Keyword And Continue On Failure    Verify Sanction Screening Flagged is visible in the submission
        Run Keyword And Continue On Failure    Verify Task Number in the submission    ${TC_E2E_006['taskNumber']}
        Run Keyword And Continue On Failure    Verify and click the Task In Submission
        Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_006['taskDetails']}
        Run Keyword And Continue On Failure    Complete Task with the given reason    ${TC_E2E_006['reason']}
        Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason    ${TC_E2E_006['reason']}
        Run Keyword And Continue On Failure    Verify Sanction Screening Flagged is not visible
    ELSE IF    '${submission_id}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END


TC_E2E_048
    [Tags]    E2E-Email_Submission
    [Documentation]    draft stage
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_048['FileName']}    @{TC_E2E_006['SubmissionColumnNames']}
    Set Suite Variable    ${Email_submission_id}    ${submission_id}
    IF    '${Email_submission_id}' != 'False'
        Select Submission using submission id     ${Email_submission_id}    @{TC_E2E_006['SubmissionColumnNames']}
        Click Edit Submission
        Run Keyword And Continue On Failure    verify Email Body Document    ${TC_E2E_048['Expected_email_Msg']}
        Click Answers Tab
        Switch to Documents
        Run Keyword And Continue On Failure    Wait For Elements State    ${Acord_125_loc}    visible
        Run Keyword And Continue On Failure    Wait For Elements State    ${Acord_140_loc}    visible
        Run Keyword And Continue On Failure    Wait For Elements State    ${SOV}    visible
        Run Keyword And Continue On Failure    Wait For Elements State    ${Broker_form_loc}    visible
        Run Keyword And Continue On Failure    Wait For Elements State    ${Loss_run_EASTERNALLIANCE}    visible
        Run Keyword And Continue On Failure    Wait For Elements State    ${LossRunFile}    visible
        Click Answers Tab    
        Verify All Side menu options are Displayed    ${TC_E2E_048['excepted_Field']}    
        Run Keyword And Continue On Failure    Verify datas in Underwriter Reference file    ${TC_E2E_048['Expected_UnderWriter_Value']}   
        Click and verify Clearance tab
            # Run Keyword And Continue On Failure    Verify PDF Data in Insured Tab    ${TC_E2E_048['Excepted_InsuredValue']}
        # Scroll To    ${InsuredNAICSCode}    top
        # Run Keyword And Continue On Failure    Wait For Elements State    ${InsuredNAICSCode}    validate    value & visible    'InsuredNAICSCode should be visible.'
        # Click With Options    ${InsuredNAICSCode}    clickCount=2
        # Sleep    2s
        # Type Text    ${InsuredNAICSInput}    ${TC_E2E_048['excepted_Insured_Value']}
        # Click Processing Tab
        # Run Keyword And Continue On Failure    Fill the data for issue fields in processing    ${TC_E2E_048['UnderwriterName']}    ${TC_E2E_048['UnderwriterEmail']}    ${TC_E2E_048['OperationsName']}        ${TC_E2E_048['OperationsEmail']}    ${TC_E2E_048['UnderwrittingOffice']}    ${TC_E2E_048['Channel']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify EML PDF Data in Producer Tab    ${TC_E2E_048['expected_Producer_Value']}
        # Click Coverage Tab
        # Run Keyword And Continue On Failure    Verify EML Data the Coverage Tab     ${TC_E2E_048['Coverage_eff_date']}     ${TC_E2E_048['Coverage_exp_date']}     ${TC_E2E_048['property_Value']}     ${TC_E2E_048['Property_Segment_value']}     ${TC_E2E_048['Facultative_Reinsurance_value']}
        # Click Finish Tab
        # Run Keyword And Continue On Failure    Verify and click the save and close button
        Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_048['Clearance2.0Data']['InsuredTabData']}
        Run Keyword And Continue On Failure    Enter their Clearance SIC and NAIC Code    ${TC_E2E_048['SICCodeData']}    ${TC_E2E_048['NAICSCodeData']}
        Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_048}
        Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_048['expectedTextInProducer']}
        # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
        Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_048['Covered']}
        Wait For Processing Stage    ${TC_E2E_048['stageNo']}
        Switch to Documents
        @{expectedModification}    Create List    "${TC_E2E_048['UnderwriterName']}"    "${TC_E2E_048['UnderwriterEmail']}"    "${TC_E2E_048['UnderwrittingOffice']}"     "${TC_E2E_048['OperationsName']}"    "${TC_E2E_048['OperationsEmail']}"    "${TC_E2E_048['RepOffice']}"    "${TC_E2E_048['RepEmail']}"    "${TC_E2E_048['Channel']}"    "${TC_E2E_048['SubChannelValue']}"    
        # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
    ELSE IF    '${Email_submission_id}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END

TC_E2E_049
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) with SOV Loss run upload in Stage 2"
    IF    '${Email_submission_id}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    # Set Suite Variable    ${Email_submission_id}    6c04611e-f803-4467-a379-a24d93870ad7
    Select Submission using submission id    ${Email_submission_id}    @{TC_E2E_049['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_049['stage']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_049['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_049['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_049['Risk360_Card_Names']}    ${TC_E2E_049['Risk360_Card_Pages_Names']}
    # Upload SOV and Loss Run Documents    @{TC_E2E_049['FileNames']}
    # Wait for Upload to Complete
    # Open uploaded SOV File   
    # Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_049['SOVFile']}
    # ${length}    Get Length    ${TC_E2E_049['dropdownOptions']}
    # Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    # Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    # Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_049['CardName']}    ${TC_E2E_049['expectedAnalysisData']}    ${TC_E2E_049['expectedTableData']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_049['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject


TC_E2E_050
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  without SOV and LR upload"
    IF    '${Email_submission_id}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${Email_submission_id}    @{TC_E2E_050['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_050['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_050['stage']}
    Click Edit Submission
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_050['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_eml}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_050['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_050['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_050['SummaryHeader']}
        #Run Keyword And Continue On Failure    Verify Premium Amount
        Click Edit Submission
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_050['PolicyInfo']}
        Click Answers Tab
        Switch To Summary Tab    ${TC_E2E_050['SummaryHeader']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_050['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_050['SummaryTableHeader']}    ${TC_E2E_050['SummaryTableData']}
        Click Answers Tab
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_050['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_050['expectedTitle']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_050['Risk360_Card_Names']}    ${TC_E2E_050['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_050['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_050['taskDetails']}
        Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_050['priority']}
        Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_050['taskupdateddetails']}
        # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_050['emailData']} 
        # Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_050['emailData']}      
        # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_050['emailData_Mising']}    ${TC_E2E_050['Expected_PopUp']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_050['stageNo']}
        # Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${new_submission_id_eml}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_051
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Quotedstage)"
    IF    '${new_submission_id_eml}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_051['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_051['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_051['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_051['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_051['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_051['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_051['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_051['SummaryTableHeader']}    ${TC_E2E_051['SummaryTableData']}
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_051['expectedQuestion']}
    # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_051['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_051['Risk360_Card_Names']}    ${TC_E2E_051['Risk360_Card_Pages_Names']}
    # Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_051['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_051['stageNo']}

TC_E2E_052
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Bindstage)"
    IF    '${new_submission_id_eml}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_052['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_052['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_052['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_052['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_052['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_052['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_052['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_052['SummaryTableHeader']}    ${TC_E2E_052['SummaryTableData']}
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_052['expectedQuestion']}
    # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_052['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_052['Risk360_Card_Names']}    ${TC_E2E_052['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_052['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_052['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_052['priority']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_052['taskupdateddetails']}
    Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_052['emailData']} 
    Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_052['emailData']}      
    Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_052['emailData_Mising']}    ${TC_E2E_052['Expected_PopUp']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_052['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_052['stageNo']}

TC_E2E_053
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Boundstage)"
    IF    '${new_submission_id_eml}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_053['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_053['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_053['stage']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_053['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_053['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_053['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_053['SummaryTableHeader']}    ${TC_E2E_053['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_053['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_053['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_053['Risk360_Card_Names']}    ${TC_E2E_053['Risk360_Card_Pages_Names']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_053['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_053['stageNo']}


TC_E2E_054
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Bookedstage)"
    IF    '${new_submission_id_eml}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_054['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_054['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_054['stage']}
    # Task Tab
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}
    Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_054['taskDetails1']}
    Run Keyword And Continue On Failure    Complete Task with the given reason for Booking stage    ${TC_E2E_054['taskreason']}
    Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason for booking    ${TC_E2E_054['taskreason']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_054['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_054['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_054['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_054['SummaryTableHeader']}    ${TC_E2E_054['SummaryTableData']}
    Click Answers Tab
    # Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_054['expectedQuestion']}
    # Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_054['expectedTitle']}
    # Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_054['Risk360_Card_Names']}    ${TC_E2E_054['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_054['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_054['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_054['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_054['priority']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_054['taskupdateddetails']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_054['emailData']} 
    # Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_054['emailData']}      
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_054['emailData_Mising']}    ${TC_E2E_054['Expected_PopUp']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_054['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_054['stageNo']}

TC_E2E_055
    [Tags]    E2E-Email_Submission
    [Documentation]    End to End Testing for New Submission - (Issuedstage)"
    IF    '${new_submission_id_eml}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_eml}    @{TC_E2E_055['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_055['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_055['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_055['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_055['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_055['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_055['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_055['SummaryTableHeader']}    ${TC_E2E_055['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_055['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_055['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_055['Risk360_Card_Names']}    ${TC_E2E_055['Risk360_Card_Pages_Names']}
    # Create New Task    ${TC_E2E_055['taskdata']}
    # Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_055['taskdata']}
    # Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_055['taskDetails']}
    # Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    # Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_055['priority']}
    # Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_055['taskupdateddetails']}
    # Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_055['emailData']} 
    # Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_055['emailData']}      
    # Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_055['emailData_Mising']}    ${TC_E2E_055['Expected_PopUp']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_055['SOVFile']}
    ${length}    Get Length    ${TC_E2E_055['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_055['CardName']}    ${TC_E2E_055['expectedAnalysisData']}    ${TC_E2E_055['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_055['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_055['stageNo']}
    Run Keyword And Continue On Failure    Verify Advance Stage is InActive

TC_E2E_046
    [Tags]   E2E-Email_Submission 
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_046['FileName']}    @{TC_E2E_046['SubmissionColumnNames']}
    IF    '${submission_id}' != 'False'
        Select Submission using submission id     ${submission_id}    @{TC_E2E_046['SubmissionColumnNames']}
        Click Answers Tab
        Verify All Side menu options are Displayed    ${TC_E2E_046['excepted_Field']}
        Run Keyword And Continue On Failure    verify Email Body Document    ${TC_E2E_046['Expected_email_Msg']}
        Switch to Summary    
        Run Keyword And Continue On Failure    Verify datas in Underwriter Reference file    ${TC_E2E_046['Expected_UnderWriter_Value']}   
        Click and verify Clearance tab 
        # Click Processing Tab
        # ${elements}    Get Elements    ${underwriter_reference_lookup}
        # ${Actual_length}    Get Length    ${elements}
        # ${Expected_Length}    Convert To Integer    ${TC_E2E_046['Expected_length']}
        # Run Keyword And Continue On Failure    Should Be Equal    ${Expected_Length}    ${Actual_length}
        # Run Keyword And Continue On Failure    Verify the Eml data in processing tab    ${TC_E2E_046['Expected_Processing_Value']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify Eml Data in Producer Tab    ${TC_E2E_046['Expected_Producer_Value']} 
        # Click Coverage Tab
        # ${Product_Name}    Get Text    ${CoverageProductButton}  
        # Run Keyword And Continue On Failure    Should Be Equal    ${TC_E2E_046['property_Value']}    ${Product_Name} 
        # ${Product_Segment_Name}    Get Text    ${Clearance_Product_Segment}  
        # Run Keyword And Continue On Failure    Should Be Equal    ${TC_E2E_046['Property_Segment_value']}    ${Product_Segment_Name}
    ELSE IF    '${submission_id}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_047
    [Tags]    E2E-Email_Submission
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_047['FileName']}    @{TC_E2E_006['SubmissionColumnNames']}
    IF    '${submission_id}' != 'False'
        Select Submission using submission id     ${submission_id}    @{TC_E2E_006['SubmissionColumnNames']}
        Click Answers Tab
        Verify All Side menu options are Displayed    ${TC_E2E_047['excepted_Field']}
        Run Keyword And Continue On Failure    verify Email Body Document    ${TC_E2E_047['Expected_email_Msg']}
        Switch to Summary    
        Run Keyword And Continue On Failure    Verify datas in Underwriter Reference file    ${TC_E2E_047['Expected_UnderWriter_Value']}   
        Run Keyword And Continue On Failure    verify the Sidebar label colour    ${TC_E2E_047['colurname']}
        Click and verify Clearance tab 
        # Click Insured Tab
        # ${Actual_InsuredName}    Get Text    ${InsuredName}
        # Run Keyword And Continue On Failure    Should Be Equal    ${TC_E2E_047['Expected_InsuredName']}    ${Actual_InsuredName}
        # Click Processing Tab
        # ${elements}    Get Elements    ${underwriter_reference_lookup}
        # ${Actual_length}    Get Length    ${elements}
        # ${Expected_Length}    Convert To Integer    ${TC_E2E_047['Expected_length']}
        # Run Keyword And Continue On Failure    Should Be Equal    ${Expected_Length}    ${Actual_length}
        # Run Keyword And Continue On Failure    Verify the Eml data in processing tab    ${TC_E2E_047['Expected_Processing_Value']}
        # Click Producer Tab
        # Run Keyword And Continue On Failure    Verify Eml Data in Producer Tab    ${TC_E2E_047['Expected_Producer_Value']}
        # Click Coverage Tab
        # ${elements}    Get Elements    ${underwriter_reference_lookup}
        # ${Actual_length}    Get Length    ${elements}
        # ${Expected_Length}    Convert To Integer    ${TC_E2E_047['Expected_length']}
        # ${Product_Name}    Get Text    ${EmptyProductType}  
        # Run Keyword And Continue On Failure    Should Be Equal    ${TC_E2E_047['property_Value']}    ${Product_Name} 
        # ${Product_Segment_Name}    Get Text    ${ProductSegment}  
        # Run Keyword And Continue On Failure    Should Be Equal    ${TC_E2E_047['Property_Segment_value']}    ${Product_Segment_Name}
    ELSE IF    '${submission_id}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END

TC_E2E_056
    [Tags]    E2E-Accord127-withAttachment
     [Documentation]    End to End Testing for New Submission - In Draft Stage:
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    # Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
   ${submission_id}    Create new submission with SOV and Loss run    ${TC_E2E_056['FileName']}    @{TC_E2E_056['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_sov}    ${submission_id}
    IF    '${submission_id_sov}' != 'False'
        Select Submission using submission id   ${submission_id}    @{TC_E2E_056['SubmissionColumnNames']}
        Run Keyword And Continue On Failure    Verify Submission page is displayed
        Click Edit Submission
        Run Keyword And Continue On Failure    Fill and Verify Clearance Tab For Acord125    ${TC_E2E_001}
        Create New Task    ${TC_E2E_056['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_056['taskDetails']}
        Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_056['priority']}
        Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_056['taskupdateddetails']}
        Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_056['emailData']} 
        Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_056['emailData']}      
        Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_056['emailData_Mising']}    ${TC_E2E_056['Expected_PopUp']}
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_056['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${submission_id_sov}' == 'False'
        FAIL    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft.
    END
TC_E2E_057
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Cleared to Under Review Stage) with SOV Loss run upload in Stage 2"
    IF    '${submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    # Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_sov}    @{TC_E2E_057['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_057['stage']}
    Click Edit Submission
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_057['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_057['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_057['Risk360_Card_Names']}    ${TC_E2E_057['Risk360_Card_Pages_Names']}
    Upload SOV and Loss Run Documents    @{TC_E2E_057['FileNames']}
    Wait for Upload to Complete
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_057['SOVFile']}
    ${length}    Get Length    ${TC_E2E_057['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_057['CardName']}    ${TC_E2E_057['expectedAnalysisData']}    ${TC_E2E_057['expectedTableData']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_057['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject


TC_E2E_058
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Under Review stage + Child submission)  without SOV and LR upload"
    IF    '${submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after 60s seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_007 Stage 2 - Cleared.
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    # Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${submission_id_sov}    @{TC_E2E_058['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_058['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_058['stage']}
    Click Edit Submission
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_058['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_sov}   ${newSubmissionID}  
        Navigate To All Submissions page from submissions 
        Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_058['SubmissionColumnNames']}
        Wait For Processing Stage    ${TC_E2E_058['stageNo']}
        Run Keyword And Continue On Failure    Verify Summary Menu is displayed
        Switch To Summary Tab    ${TC_E2E_058['SummaryHeader']}
        #Run Keyword And Continue On Failure    Verify Premium Amount
        Click Edit Submission
        Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_058['PolicyInfo']}
        Click Answers Tab
        Switch To Summary Tab    ${TC_E2E_058['SummaryHeader']}
        Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_058['PolicyInfo']}    ${TC_Forms_01}    
        Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_058['SummaryTableHeader']}    ${TC_E2E_058['SummaryTableData']}
        Click Answers Tab
        Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_058['expectedQuestion']}
        Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_058['expectedTitle']}
        Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_058['Risk360_Card_Names']}    ${TC_E2E_058['Risk360_Card_Pages_Names']}
        Create New Task    ${TC_E2E_058['taskdata']}
        Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_058['taskDetails']}
        Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
        Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_058['priority']}
        Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_058['taskupdateddetails']}
        Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_058['emailData']} 
        Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_058['emailData']}      
        Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_058['emailData_Mising']}    ${TC_E2E_058['Expected_PopUp']}
        Open uploaded SOV File   
        Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_058['SOVFile']}
        ${length}    Get Length    ${TC_E2E_058['dropdownOptions']}
        Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
        Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
        # Verify Policies Data From Loss Run File
        Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_058['CardName']}    ${TC_E2E_058['expectedAnalysisData']}    ${TC_E2E_058['expectedTableData']}
        # Verify Schema by downloading the json file
        Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_058['expectedWorkFlowHistory']}
        Run Keyword And Continue On Failure    Save Submission And verify popup
        Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_058['stageNo']}
        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
    ELSE IF    '${new_submission_id_sov}' == 'False'
            FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review.
        END
TC_E2E_059
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Quotedstage)"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    # Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_059['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_059['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_059['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_059['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_059['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_059['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_059['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_059['SummaryTableHeader']}    ${TC_E2E_059['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_059['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_059['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_059['Risk360_Card_Names']}    ${TC_E2E_059['Risk360_Card_Pages_Names']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_059['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_059['stageNo']}

TC_E2E_060
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Bindstage)"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_060['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_060['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_060['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_060['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_060['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_060['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_060['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_060['SummaryTableHeader']}    ${TC_E2E_060['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_060['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_060['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_060['Risk360_Card_Names']}    ${TC_E2E_059['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_060['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_060['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_060['priority']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_060['taskupdateddetails']}
    Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_060['emailData']} 
    Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_060['emailData']}      
    Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_060['emailData_Mising']}    ${TC_E2E_060['Expected_PopUp']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_060['SOVFile']}
    ${length}    Get Length    ${TC_E2E_060['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_060['CardName']}    ${TC_E2E_060['expectedAnalysisData']}    ${TC_E2E_060['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_060['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_060['stageNo']}

TC_E2E_061
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Boundstage)"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_061['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_061['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_061['stage']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_061['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_061['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_061['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_061['SummaryTableHeader']}    ${TC_E2E_061['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_061['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_061['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_061['Risk360_Card_Names']}    ${TC_E2E_061['Risk360_Card_Pages_Names']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_061['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_061['stageNo']}


TC_E2E_062
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Bookedstage)"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_062['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_062['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_062['stage']}
    # Task Tab
    Click Answers Tab
    Wait For Elements State    ${TaskClick}    visible
    Click    ${TaskClick}
    Run Keyword And Continue On Failure    Verify the auto generated task details    ${TC_E2E_062['taskDetails1']}
    Run Keyword And Continue On Failure    Complete Task with the given reason for Booking stage    ${TC_E2E_062['taskreason']}
    Run Keyword And Continue On Failure    Verify the task is completed and sanction label is appears as per the reason for booking    ${TC_E2E_062['taskreason']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_062['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_062['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_062['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_062['SummaryTableHeader']}    ${TC_E2E_062['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_062['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_062['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_062['Risk360_Card_Names']}    ${TC_E2E_062['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_062['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_062['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_062['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_062['priority']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_062['taskupdateddetails']}
    Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_062['emailData']} 
    Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_062['emailData']}      
    Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_062['emailData_Mising']}    ${TC_E2E_062['Expected_PopUp']}
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_062['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_062['stageNo']}

TC_E2E_063
    [Tags]    E2E-Accord127-withAttachment
    [Documentation]    End to End Testing for New Submission - (Issuedstage)"
    IF    '${new_submission_id_sov}' == 'False'
        Skip    New Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${upload_procesing_timeout} seconds. Aborting test case TC_E2E_001 Stage 1 - InDraft , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    ELSE IF    '${child_submission_status_1}' == 'False'
        Skip    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case TC_E2E_011 Stage 3 - Under Review , Hence skipping the test case TC_E2E_017 Stage 4 - Quoted
    END
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    Select Submission using submission id    ${new_submission_id_sov}    @{TC_E2E_063['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Advance Stage    ${TC_E2E_063['stageNo']}    
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_063['stage']}
    Run Keyword And Continue On Failure    Verify Policy PDF is Generated and Available in Documents Tab    ${TC_E2E_063['PolicyInfo']}
    Click Edit Submission
    Switch To Summary Tab    ${TC_E2E_063['SummaryHeader']}
    Run Keyword And Continue On Failure    Verify Policy Information Details from Summary Tab    ${TC_E2E_063['PolicyInfo']}    ${TC_Forms_01}
    Run Keyword And Continue On Failure    Enter the Policy Information    ${TC_E2E_063['PolicyInfo']}    
    Run Keyword And Continue On Failure    Verify Summary Table Data    ${TC_E2E_063['SummaryTableHeader']}    ${TC_E2E_063['SummaryTableData']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_063['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_063['expectedTitle']}
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_063['Risk360_Card_Names']}    ${TC_E2E_063['Risk360_Card_Pages_Names']}
    Create New Task    ${TC_E2E_063['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_063['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_063['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_063['priority']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_063['taskupdateddetails']}
    Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_063['emailData']} 
    Run Keyword And Continue On Failure    Discard the Created Email    ${TC_E2E_063['emailData']}      
    Run Keyword And Continue On Failure    Create New Mail With Missing Data    ${TC_E2E_063['emailData_Mising']}    ${TC_E2E_063['Expected_PopUp']}
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_063['SOVFile']}
    ${length}    Get Length    ${TC_E2E_063['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    # Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_063['CardName']}    ${TC_E2E_063['expectedAnalysisData']}    ${TC_E2E_063['expectedTableData']}
    # Verify Schema by downloading the json file
    Run Keyword And Continue On Failure    Verify WorkFlow History    ${TC_E2E_063['expectedWorkFlowHistory']}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_063['stageNo']}
    Run Keyword And Continue On Failure    Verify Advance Stage is InActive

TC_E2E_064
    [Tags]    200_BugFixes
    [Documentation]    End to End Testing for New Submission - (Processing stage)
    verify email composer attachement is not presnt    msig
    # verify email composer attachement is not presnt    msig
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    verify the delete Submission is not available for the Client Admin Role
    Run Keyword And Continue On Failure    Verify System displays task reassignment pop-up for completed tasks    ${TC_E2E_064['Column_Name']}    ${TC_E2E_064['Cant_Reassign_msg']}    ${TC_E2E_064['Assign_To']}
    Run Keyword And Continue On Failure    verify the Effective date in Convr Task Tab    ${TC_E2E_064['Column_Name']}    ${TC_E2E_064['Date']}    ${TC_E2E_064['date1']}
    ${submission_id}    Create new submission in processing    ${TC_E2E_064['FileName']}    @{TC_E2E_064['SubmissionColumnNames']}
    Select Submission using submission id     ${submission_id}    @{TC_E2E_064['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    verify that the Reprocess button is not Available in Document Tab    ${TC_E2E_064['New_Asset_Option']}
    
TC_E2E_068
    [Tags]    E2E-Schema_Generation_Skipped    
    [Documentation]    End to End Testing for New Submission - In Draft Stage to under Review Stage for client Admin Role- Schema skipped
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ClientUser}
    # Select Impersonate option from the actions    ${ClientUser['email']}    ${ClientUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_068['FileName']}    @{TC_E2E_068['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_1}    ${submission_id}
    Select Submission using submission id    ${submission_id}    @{TC_E2E_068['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Edit Submission
    #New Method for Bug fixes -201[clearance tab]
    Run Keyword And Continue On Failure    Verify Switching From Clearance Tab To All Other tabs
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    1
    Click Answers Tab
    Advance Stage    ${TC_E2E_068['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_068['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_068['stageNo']}
    Advance Stage    ${TC_E2E_011['stageNo']}
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_011['stage']}
    Verify Log History    ${TC_E2E_068['expectedLogHistory']}
TC_E2E_069
    [Documentation]    This test cases for create new Renewal Submission 
    [Tags]    Renewal_Submission
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # ${submission_id}    Create New Submission    ${TC_E2E_069['FileName']}    @{TC_E2E_069['SubmissionColumnNames']}
    Set Suite Variable   ${submission_id_1}    307074b0-5548-42c7-bb45-97a758a2e058
    Select Submission using submission id    ${submission_id_1}    @{TC_E2E_069['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed 
    Click Edit Submission
    Navigate to Form
    switch to NY Underwriting Eligibility Guidelines Form
    Run Keyword And Continue On Failure    Verify NYUEG Average Ratio        ${TC_E2E_069['NYUEGAverageratio']}
    Run Keyword And Continue On Failure    Click and verify Clearance tab
    Run Keyword And Continue On Failure    Select the Underwritername in clearance    ${TC_E2E_069}    
    Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab based on Underwriter name    ${TC_E2E_069['Excepted_Processingdata']}
    Run Keyword And Continue On Failure    Verify Slider Value in Forms Tab
    # Run Keyword And Continue On Failure    uplod the file via air template    ${TC_E2E_069['FileName']}

TC_E2E_207
    [Documentation]    This test case for the msig 207 bug fix testcases 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # ${submission_id}    Create New Submission    ${TC_E2E_068['FileName']}    @{TC_E2E_068['SubmissionColumnNames']}
    # Set Suite Variable   ${submission_id_1}    ${submission_id}
    Select Submission using submission id    e22c2d1c-5b29-40c1-8f8a-6bed22f3065d    @{TC_E2E_068['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Edit Submission
    Run Keyword And Continue On Failure    verify that click on side detials policy saved popup should not be appear
    Click and verify Clearance tab
    Delete and add the SIC and Naics code in clearance tab    444190
    Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_207['Clearance2.0Data']['InsuredTabData']}
    Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_207['Clearance2.0Data']['ProcessingTabData']}
    Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_207['Clearance2.0Data']['ProducerTabData']['expectedTextInProducer']}    ${TC_E2E_207['Clearance2.0Data']['ProducerTabData']['ProducerName']}      ${TC_E2E_207['Clearance2.0Data']['ProducerTabData']['ProducerEmail']} 
    Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_207['Clearance2.0Data']['Covered']}
    Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_207['Clearance2.0Data']['Covered']}
    Run Keyword And Continue On Failure    Veify That Empty NAICS and SIC box should not be present in the clearance
    Run Keyword And Continue On Failure    verify The Reprocess should be disabled for HITL User
    Run Keyword And Continue On Failure    Verify Error msg in CAT Modeling Request form in task tab    ${TC_E2E_207['CAT_moduleing']}    
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File for Total claims extraction
    
TC_email_060
    [Documentation]    upload the different email submission 
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    # ${submission_id}    Create New Submission    ${TC_E2E_001['FileName']}    @{TC_E2E_001['SubmissionColumnNames']}
    # Set Suite Variable   ${submission_id_1}    ${submission_id}    
    Select Submission using submission id    9d366237-9bff-44f4-9b57-13e0b5ef33b6    @{TC_E2E_001['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Edit Submission
    Switch to Documents
    Run Keyword And Continue On Failure    Upload given Documents in document tab    ${TC_email_060['eml_no_data']['file_name']}    ${TC_email_060['eml_no_data']['sub_attachement']}    False    
    # Run Keyword And Continue On Failure    Remove Document after Upload    ${TC_email_060['eml_no_data']['file_name']}
    # Run Keyword And Continue On Failure    Upload SOV and Loss Run Documents    ${TC_email_060['eml_no_data']['file_name']}
    Wait For Processing Stage
    # Run Keyword And Continue On Failure    verify the Email Body Document    ${TC_email_060['eml_no_data']['file_name']}    ${TC_email_060['eml_no_data']['Expected_email_Msg']}
    Run Keyword And Continue On Failure    delete the given file in processed Tab    @{TC_email_060['eml_no_data']['document_type']}
    Run Keyword And Continue On Failure    verify files are deleted    @{TC_email_060['eml_no_data']['document_type']}
    Run Keyword And Continue On Failure    delete the archived files
#   
    # Run Keyword And Continue On Failure    Remove Document after Upload    ${TC_email_060['eml_normal_data']['file_name']}          
    Run Keyword And Continue On Failure    Upload given Documents in document tab    ${TC_email_060['eml_normal_data']['file_name']}    ${TC_email_060['eml_no_data']['sub_attachement']}    False
    Wait For Processing Stage
    # Run Keyword And Continue On Failure    verify the Email Body Document    ${TC_email_060['eml_normal_data']['file_name']}    ${TC_email_060['eml_normal_data']['Expected_email_Msg']}
    # Run Keyword And Continue On Failure    verify the file info details    ${TC_email_060['eml_normal_data']['file_name']}    ${TC_email_060['eml_normal_data']}
    Run Keyword And Continue On Failure    delete the given file in processed Tab    @{TC_email_060['eml_normal_data']['document_type']}
    Run Keyword And Continue On Failure    verify files are deleted    @{TC_email_060['eml_normal_data']['document_type']}
    Run Keyword And Continue On Failure    delete the archived files
# eml_pdf_plus_nameless
    # Run Keyword And Continue On Failure    Remove Document after Upload    ${TC_email_060['eml_pdf_plus_nameless']['file_name']}
    Run Keyword And Continue On Failure    Upload given Documents in document tab    ${TC_email_060['eml_pdf_plus_nameless']['file_name']}    ${TC_email_060['eml_no_data']['sub_attachement']}    True
    Wait For Processing Stage
    # Run Keyword And Continue On Failure    verify the Email Body Document    ${TC_email_060['eml_pdf_plus_nameless']['file_name']}    ${TC_email_060['eml_pdf_plus_nameless']['Expected_email_Msg']}
    # Run Keyword And Continue On Failure    verify the file info details    ${TC_email_060['eml_pdf_plus_nameless']['file_name']}    ${TC_email_060['eml_pdf_plus_nameless']}
    Run Keyword And Continue On Failure    delete the given file in processed Tab    @{TC_email_060['eml_pdf_plus_nameless']['document_type']}
    Run Keyword And Continue On Failure    verify files are deleted    @{TC_email_060['eml_pdf_plus_nameless']['document_type']}
    Run Keyword And Continue On Failure    delete the archived files
    # eml_normal_plus
    Run Keyword And Continue On Failure    Remove Document after Upload    ${TC_email_060['eml_normal_plus']['file_name']}
    Run Keyword And Continue On Failure    Upload given Documents in document tab    ${TC_email_060['eml_normal_plus']['file_name']}    ${TC_email_060['eml_no_data']['sub_attachement']}    False
    
    # Run Keyword And Continue On Failure    verify the Email Body Document    ${TC_email_060['eml_normal_plus']['file_name']}    ${TC_email_060['eml_normal_plus']['Expected_email_Msg']}
    # Run Keyword And Continue On Failure    verify the file info details    ${TC_email_060['eml_normal_plus']['file_name']}    ${TC_email_060['eml_normal_plus']}
    Run Keyword And Continue On Failure    delete the given file in processed Tab    @{TC_email_060['eml_normal_plus']['document_type']}
    Run Keyword And Continue On Failure    verify files are deleted    @{TC_email_060['eml_normal_plus']['document_type']}
    Run Keyword And Continue On Failure    delete the archived files
    # Run Keyword And Continue On Failure    verify the no of files in Archived    0    

TC_E2E_071
    [Documentation]    This testcase is to verify E2E_071    
    # Create User If the User is not present    ${NewUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']} 
        Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    
        # verify the Transation Type filter in Convr Submission page    ${TC_E2E_071['Transaction_value']}
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Submission page    Submission    display_name      

        # verify the Checkbox Type filter in Convr Submission page    Transaction Type    submission.renewalFlag    ${TC_E2E_071['Transaction_value']}
        # verify the Checkbox Type filter in Convr Submission page    Created By    createdBy.name    ${TC_E2E_071['Transaction_value']}
        # verify the Checkbox Type filter in Convr Submission page    Created By    createdBy.name    ${TC_E2E_071['Transaction_value']}
        # verify the Checkbox Type filter in Convr Submission page    Created By    createdBy.name    ${TC_E2E_071['Transaction_value']}
        # Run Keyword And Continue On Failure    verify the Checkbox Type filter in Convr Task page    Created By    createdBy.name
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Task page    Account #    referenceId
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Task page    Task    name
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Task page    Submission    submission.displayName
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Task page    Status    status
        # Run Keyword And Continue On Failure    Verify the filter option in Convr Task page    Details    body
        # Switch to Convr Task tab
        # ${before_created_task_length}    Get the length of the created task in the Convr Task Tab
        # ${before_Assign_task_length}    Get the length of the Assigned task in the Convr Task Tab
        # Click All tasks option
        # sleep    2s
        # Verify that Detials should be Hidden    ${TC_E2E_071['Details']}  
        # Click    ${Convr_submission_button}
        # sleep    2s
        # ${submission_id}    Create New Submission    ${TC_E2E_071['FileName']}    @{TC_E2E_071['SubmissionColumnNames']}   
        Select Submission using submission id    e7a957c7-dfc6-4c60-b020-cfd7026736c3    @{TC_E2E_071['SubmissionColumnNames']}
        Click Edit Submission
        verify that added comment should be displayed    Stage 2
        Verify that user can cancel the comment    ${TC_E2E_071['Comment_user']}    Stage 2
        Verify user can add the comment in the Summary page    ${TC_E2E_071['Comment_user']}    Stage 2     
        Verify user can recive the comment notification in the Summary page
        click Answers Tab
        Cancel the New Task    ${TC_E2E_071['taskdata']}
        Create New Task    ${TC_E2E_071['taskdata']}
        click Answers Tab
        Navigate To All Submissions page from submissions
        Switch to Convr Task tab
        ${After_created_task_length}    Get the length of the created task in the Convr Task Tab
        # ${After_Assign_task_length}    Get the length of the Assigned task in the Convr Task Tab
        # ${status}    Run Keyword And Return    Should Not Be Equal    ${before_Assign_task_length}    ${After_Assign_task_length}
        # Run Keyword And Continue On Failure    Should Be True    ${status}    Assigned task is not updated in the convr task page
        # Navigate To All Submissions page from submissions
        # Sleep    2s
        # ${submission_id1}    Create New Submission    ${TC_E2E_071['FileName']}    @{TC_E2E_071['SubmissionColumnNames']}   
        # Select Submission using submission id    ${submission_id1}    @{TC_E2E_071['SubmissionColumnNames']}
        # Click Edit Submission
        # click Answers Tab
        # Switch To Documents
        
*** Keywords ***
Run Pre-requiste Steps for Stage 1
    # Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_001['FileName']}    @{TC_E2E_001['SubmissionColumnNames']}
    Select Submission using submission id    ${submission_id}    @{TC_E2E_001['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Edit Submission
    Click and verify Clearance tab
    # Click Insured Tab
    # Fill the data for issue fields    ${TC_E2E_001['SicCode']}    ${TC_E2E_001['SicDescription']}    ${TC_E2E_001['NAICSCode']}
    # Click Processing Tab
    # Fill the data for issue fields in processing    ${TC_E2E_001['UnderwriterName']}    ${TC_E2E_001['UnderwriterEmail']}    ${TC_E2E_001['OperationsName']}        ${TC_E2E_001['OperationsEmail']}    ${TC_E2E_001['UnderwrittingOffice']}    ${TC_E2E_001['Channel']}
    # Click Producer Tab
    # Fill the data for issues field in Producer    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']}
    # Click Coverage Tab
    # Fill the data for issues field in Coverage    ${TC_E2E_001['Covered']} 
    # Click Finish Tab
    # Run Keyword And Continue On Failure    Verify and click the save and close button
    Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
    Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
    Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
    Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
    Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
    Wait For Processing Stage
    Switch to Documents
    @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
    Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated
    RETURN    ${submission_id}

Run Pre-requiste Steps for Stage 1 & 2
    #     Create User If the User is not present    ${NewUser}
    # Create User If the User is not present    ${ReferralUser}
    # Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Run Keyword And Continue On Failure    Verify My Assignments Tab is displayed as a default tab
    ${submission_id}    Create New Submission    ${TC_E2E_001['FileName']}    @{TC_E2E_001['SubmissionColumnNames']}
    Select Submission using submission id    ${submission_id}    @{TC_E2E_001['SubmissionColumnNames']}
    Run Keyword And Continue On Failure    Verify Submission page is displayed
    Click Answers Tab
    Click Edit Submission
    # Click and verify Clearance tab
    # Click Insured Tab
    # Fill the data for issue fields    ${TC_E2E_001['SicCode']}    ${TC_E2E_001['SicDescription']}    ${TC_E2E_001['NAICSCode']}
    # Click Processing Tab
    # Fill the data for issue fields in processing    ${TC_E2E_001['UnderwriterName']}    ${TC_E2E_001['UnderwriterEmail']}    ${TC_E2E_001['OperationsName']}        ${TC_E2E_001['OperationsEmail']}    ${TC_E2E_001['UnderwrittingOffice']}    ${TC_E2E_001['Channel']}
    # Click Producer Tab
    # Fill the data for issues field in Producer    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']}
    # Click Coverage Tab
    # Fill the data for issues field in Coverage    ${TC_E2E_001['Covered']} 
    # Click Finish Tab
    # Run Keyword And Continue On Failure    Verify and click the save and close button
    # Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_001['Clearance2.0Data']['InsuredTabData']}
    # Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_001}
    # Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_001['expectedTextInProducer']}    ${TC_E2E_001['ProducerName']}      ${TC_E2E_001['ProducerEmail']} 
    # Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_001['Covered']}
    # Run Keyword And Continue On Failure    Complete Clearance and Verify Popup    ${TC_E2E_001['Covered']}
    # Wait For Processing Stage
    # Switch to Documents
    # @{expectedModification}    Create List    "${TC_E2E_001['UnderwriterName']}"    "${TC_E2E_001['UnderwriterEmail']}"    "${TC_E2E_001['UnderwrittingOffice']}"     "${TC_E2E_001['OperationsName']}"    "${TC_E2E_001['OperationsEmail']}"    "${TC_E2E_001['RepOffice']}"    "${TC_E2E_001['RepEmail']}"    "${TC_E2E_001['Channel']}"    "${TC_E2E_001['SubChannelValue']}"    "${TC_E2E_001['Covered']['ProductSegment']}"    "${TC_E2E_001['ProducerName']}"    "${TC_E2E_001['ProducerEmail']}"    "${TC_E2E_001['Covered']['Product']}"    
    # Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    Run Keyword And Continue On Failure    Fill and Verify Clearance Tab For Acord125    ${TC_E2E_001}
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated
    Advance Stage 2
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_007['stage']}
    Click Edit Submission
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in Stage 2
    RETURN    ${submission_id}

Run Pre-requiste for Step 1 2 & 3
    ${submission_id}    Run Pre-requiste Steps for Stage 1 & 2
    Click Answers Tab
    Advance Stage    ${TC_E2E_011['stageNo']}    
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Stage is updated in the submission    ${TC_E2E_011['stage']}
    Click Edit Submission
    # Click and verify Clearance tab
    # Create Child submission    ${TC_E2E_011['Covered']}
    # Wait For Processing Stage    ${TC_E2E_011['stageNo']} 
    Click and verify Clearance tab
    Create Child submission    ${TC_E2E_011['Covered']}
    ${ChildSubmissionStatus}    Wait For Processing Stage    ${TC_E2E_016['stageNo']}
    Set Suite Variable    ${child_submission_status_1}    ${ChildSubmissionStatus}
    IF    ${child_submission_status_1} != False
        ${newSubmissionID}    Get New Submission ID After Child Submission
        Set Suite Variable    ${new_submission_id_1}   ${newSubmissionID}  
    Navigate To All Submissions page from submissions 
    Select Submission using submission id    ${new_submission_id_1}    @{TC_E2E_011['SubmissionColumnNames']}
    Wait For Processing Stage    ${TC_E2E_011['stageNo']}
    Click Answers Tab
    Click Edit Submission
    Run Keyword And Continue On Failure    Save Submission And verify popup
    Run Keyword And Continue On Failure    Verify Submission updated in the Current Stage    ${TC_E2E_011['stageNo']}
    # ${newSubmissionID}    Get New Submission ID After Child Submission
    RETURN    ${new_submission_id_1}
    ELSE IF    '${child_submission_status_1}' == 'False'
        FAIL    Child Submission is not created. Processing stage should be hidden within the time. The submission is still processing even after ${processing_stage_timeout} seconds. Aborting test case Stage 3 - Under Review.
    END
Create and Verify Task In Task Tab
    [Arguments]    ${TC_E2E_Data}
    Run Keyword And Continue On Failure    Verify that System shows Correct Task Number
    Run Keyword And Continue On Failure    Verify Task Names Listed in Alphabetical Order    ${TC_E2E_001}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Submission/Policy Number in CAT Modeling Request    ${TC_E2E_001}
    Create New Task    ${TC_E2E_001['taskdata']}
    Run Keyword And Continue On Failure    Upload File on Created Task    ${TC_E2E_001['TaskFileName']}    ${TC_E2E_001['taskdata']}
    Run Keyword And Continue On Failure    Select the Created Task     ${TC_E2E_001['taskdata']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_001['taskDetails']}
    Run Keyword And Continue On Failure    verify Edit Delete and Complete task Buttons are present on the right side of task list
    Run Keyword And Continue On Failure    Verify Edit Icon is Clickable and Functional    ${TC_E2E_001['priority']}
    Run Keyword And Continue On Failure    Verify Created Task Details    ${TC_E2E_001['taskupdateddetails']}
    Click Answers Tab
    Run Keyword And Continue On Failure    Select the Created Task    ${TC_E2E_001['taskdata']}
    Run Keyword And Continue On Failure    Verify Delete Icon is Clickable and Functional    ${TC_E2E_001['taskupdateddetails']}
    
Fill and Verify Clearance Tab For Acord125
    [Arguments]    ${TC_E2E_Data}
    Sleep    5s
    Click and verify Clearance tab
    Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_Data['Clearance2.0Data']['InsuredTabData']}
    Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_Data}
    Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab    ${TC_E2E_Data['expectedTextInProducer']}    ${TC_E2E_Data['ProducerName']}      ${TC_E2E_Data['ProducerEmail']} 
    Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_Data['Covered']}
    Complete Clearance and Verify Popup    ${TC_E2E_Data['Covered']}
    Wait For Processing Stage
    Switch to Documents
    @{expectedModification}    Create List    "${TC_E2E_Data['UnderwriterName']}"    "${TC_E2E_Data['UnderwriterEmail']}"    "${TC_E2E_Data['UnderwrittingOffice']}"     "${TC_E2E_Data['OperationsName']}"    "${TC_E2E_Data['OperationsEmail']}"    "${TC_E2E_Data['RepOffice']}"    "${TC_E2E_Data['RepEmail']}"    "${TC_E2E_Data['Channel']}"    "${TC_E2E_Data['SubChannelValue']}"    "${TC_E2E_Data['Covered']['ProductSegment']}"    "${TC_E2E_Data['ProducerName']}"    "${TC_E2E_Data['ProducerEmail']}"    "${TC_E2E_Data['Covered']['Product']}"    
    Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    Run Keyword And Continue On Failure    Verify Schema by downloading the json file    ${TC_E2E_Data['queryList']}    @{expectedModification}
    # Click and verify Clearance tab
    # Remove the State from the clearance Tab
    # verify the projectadress and vessels    ${TC_E2E_069['Excepted_project_field']}    ${TC_E2E_069['excepted_vessels_field']}    
    
Create and Verify Mail In Email Tab
    [Arguments]    ${TC_E2E_Data}
    Create New Mail    ${TC_E2E_Data['emailData']}
    Verify Email Sent Successfully
    Run Keyword And Continue On Failure    Verify Sent Email    ${TC_E2E_Data['emailVerify']}
    Run Keyword And Continue On Failure    Save and verify mail in Draft    ${TC_E2E_Data['emailData']} 
    Discard the Created Email    ${TC_E2E_Data['emailData']}      
    Create New Mail With Missing Data    ${TC_E2E_Data['emailData_Mising']}    ${TC_E2E_Data['Expected_PopUp']}  
    
Answer Tab Verifications
    [Arguments]    ${TC_E2E_Data}
    Click Answers Tab
    Run Keyword And Continue On Failure    Verify Answers Lists    ${TC_E2E_Data['expectedQuestion']}
    Run Keyword And Continue On Failure    Verify Company Website Link    ${TC_E2E_Data['expectedTitle']}

Risk360 Tab Verifications
    [Arguments]    ${TC_E2E_Data}
    Switch to Risk360 tab
    Run Keyword And Continue On Failure    Verify Risk360 Card Pages Navigation    ${TC_E2E_Data['Risk360_Card_Names']}    ${TC_E2E_007['Risk360_Card_Pages_Names']}
    # Run Keyword And Continue On Failure    Verify NAICS is ReUpdated in Risk360 Tab    ${TC_E2E_Data}
    Run Keyword And Continue On Failure    Verify Risk360 Social Media Link
    Run Keyword And Continue On Failure    Verify Elements Are Alphabetically Ordered    ${Resorce_link}

Upload and Verify SOV and LR File In Documents Tab
    [Arguments]    ${TC_E2E_Data}
    Upload SOV and Loss Run Documents    @{TC_E2E_Data['FileName']}
    Wait for Upload to Complete for SOV and Loss Run    ${TC_E2E_Data['stageNo']}
    # Wait for Upload to Complete
    Open uploaded SOV File   
    Run Keyword And Continue On Failure    Verify datas are matching for the uploaded SOV file    ${TC_E2E_Data['SOVFile']}
    ${length}    Get Length    ${TC_E2E_003['dropdownOptions']}
    Run Keyword And Continue On Failure    Verify Properties datas for the given dropdown options    ${length}
    Run Keyword And Continue On Failure    Verify Claims Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Policies Data From Loss Run File
    Run Keyword And Continue On Failure    Verify Analysis Data From Loss Run File    ${TC_E2E_Data['CardName']}    ${TC_E2E_Data['expectedAnalysisData']}    ${TC_E2E_Data['expectedTableData']}
    
Fill and Verify Clearance Tab For 11420Corp
    [Arguments]    ${TC_E2E_Data}
    Run Keyword And Continue On Failure    Click and verify Clearance tab
    Sleep    5s
    Run Keyword And Continue On Failure    Verify Clearance Data in Insured Tab    ${TC_E2E_Data['Clearance2.0Data']['InsuredTabData']}
    Enter their Clearance SIC and NAIC Code    ${TC_E2E_Data['SICCodeData']}    ${TC_E2E_Data['NAICSCodeData']}
    Run Keyword And Continue On Failure    Verify Clearance Data in Processing Tab    ${TC_E2E_Data}
    Run Keyword And Continue On Failure    Verify Clearance Data in Producer Tab 11420Corp    ${TC_E2E_Data['expectedTextInProducer']}    ${TC_E2E_Data['ProducerName']}      ${TC_E2E_Data['ProducerEmail']}      ${TC_E2E_Data['ProducerCode']} 
    Run Keyword And Continue On Failure    Verify Clearance Data in Coverage Tab    ${TC_E2E_Data['Covered']}
    # Remove the State from the clearance Tab
    # verify the projectadress and vessels    ${TC_E2E_069['Excepted_project_field']}    ${TC_E2E_069['excepted_vessels_field']}    
    Complete Clearance and Verify Popup    ${TC_E2E_Data['Covered']}
    Wait For Processing Stage
    Switch to Documents
    @{expectedModification}=    Create List
    
    @{code_lists}=    Create List    ${TC_E2E_Data['SICCodeData']}    ${TC_E2E_Data['NAICSCodeData']}

    FOR    ${code_list}    IN    @{code_lists}
        FOR    ${value}    IN    @{code_list}
            Append To List    ${expectedModification}    "${value}"
        END
    END
    Append To List    ${expectedModification}    "${TC_E2E_Data['ProducerName']}"    "${TC_E2E_Data['ProducerEmail']}"      "${TC_E2E_Data['ProducerCode']}"    "${TC_E2E_Data['Covered']['Product']}"    "${TC_E2E_Data['UnderwriterName']}"    "${TC_E2E_Data['UnderwriterEmail']}"    "${TC_E2E_Data['UnderwrittingOffice']}"    "${TC_E2E_Data['OperationsName']}"    "${TC_E2E_Data['OperationsEmail']}"    "${TC_E2E_Data['RepOffice']}"    "${TC_E2E_Data['RepEmail']}"    "${TC_E2E_Data['Channel']}"    "${TC_E2E_Data['SubChannelValue']}"    "${TC_E2E_Data['Covered']['ProductSegment']}"
    Run Keyword And Continue On Failure    Verify datas in UserModification file    @{expectedModification}
    Run Keyword And Continue On Failure    Verify Schema by downloading the json file    ${TC_E2E_Data['queryList']}    @{expectedModification}
