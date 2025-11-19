*** Settings ***
Resource   ../../utils/common_keywords.robot
Variables  ../locators/submissions.py
Variables  ../locators/all_submissions.py
Variables    ../locators/summary_locators.py

*** Keywords ***

# Verify All Side menu options are Displayed
#    [Documentation]    verify that All tabs Are Displayed
#    [Arguments]    ${expected_Value}
#    ${Allfields}    Get Elements    ${Loc_AllField}
#    ${lenth}    Get Length   ${Allfields}
#    Log To Console    the lenth is : ${lenth}
#    ${summary_list}    Create List  
#    FOR    ${counter}    IN    @{Allfields}
#        ${fieldname}=    Get Text    ${counter}
#        Append To List    ${summary_list}     ${fieldname}
#        Log To Console    The Field is : ${summary_list}
#    END
#    Run Keyword And Continue On Failure    Lists Should Be Equal    ${summary_list}    ${expected_Value}
Verify All Side menu options are Displayed
    [Documentation]    Verifies that all side menu tabs/options are displayed as expected.
    [Arguments]    ${expected_Value}

    ${all_fields}=    Get Elements    ${Loc_AllField}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${all_fields}    msg=Verify All Side Menu: No fields were found on the side menu.

    ${field_count}=    Get Length    ${all_fields}
    Log To Console    Verify All Side Menu: Total number of fields found: ${field_count}

    ${summary_list}=    Create List
    FOR    ${field}    IN    @{all_fields}
        ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${field}    visible    timeout=${element_timeout}
		Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Side bar field is not visible on the page. 
        ${field_name}=    Get Text    ${field}
        # Run Keyword And Continue On Failure    Should Not Be Empty   ${field_name}    msg=Verify All Side Menu: Failed to get text for a side menu field element.
        Append To List    ${summary_list}    ${field_name}
        Log To Console    Verify All Side Menu: Added field '${field_name}' to summary list.
    END

    ${lists_equal}=    Run Keyword And Return Status    Lists Should Be Equal    ${summary_list}    ${expected_Value}
    Run Keyword And Continue On Failure    Should Be True    ${lists_equal}    msg=Verify All Side Menu: Actual side menu fields ${summary_list} do not match expected ${expected_Value}.

Verify Header Displayed 
     [Documentation]    verify that All Header Are Displayed 
    ...
    ...    *Arguments:*
    ...       The Expected Stage ${expected_Stage}
    ...       The Expected Tab  ${Expected_Tab}
    [Arguments]   ${expected_Stage}    ${Expected_Tab}
   ${headers}    Get Elements    ${Headers_Loc}
   ${lenth}    Get Length   ${Headers_Loc}
   Log To Console    the lenth is : ${lenth}
   FOR    ${counter}    IN    @{headers} 
       ${headerName}=    Get Text    ${counter}
       Append To List    ${TC_Summary_001['acutual_Header_List']}     ${headerName}
       Log    The field is : ${TC_Summary_001['acutual_Header_List']}
       Log To Console    The Field is : ${TC_Summary_001['acutual_Header_List']}
   END
    ${Header_Text}    Get Text    ${Loc_Header_Status}
    ${Header_Text1}    Get Text    ${page_header_Loc}
    Append To List    ${TC_Summary_001['acutual_Header_List']}    ${Header_Text}   
    Append To List    ${TC_Summary_001['acutual_Header_List']}    ${Header_Text1}     
    Append To List    ${TC_Summary_001['excepted_Headers']}    ${expected_Stage}   
    Append To List    ${TC_Summary_001['excepted_Headers']}    ${Expected_Tab}     
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${TC_Summary_001['excepted_Headers']}    ${TC_Summary_001['acutual_Header_List']}       

# Switch to Summary
#     [Documentation]  Switch to Summary       
#     Run Keyword And Continue On Failure    Wait For Element With Message    SummaryTab    ${SummaryTab_loc}    visible    To verify the Summary Tab is present
#     # Wait For Elements State    ${SummaryTab_loc}    visible    5s
#     Click    ${SummaryTab_loc}
Switch To Summary
    [Documentation]    Switches to the 'Summary' tab within a submission and ensures it is displayed.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SummaryTab_loc}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Switch To Summary: 'Summary' tab is not visible in the side menu. Cannot proceed to open it.

    ${clicked}=    Run Keyword And Return Status    Click    ${SummaryTab_loc}
    Should Be True    ${clicked}    msg=Switch To Summary: Failed to click the 'Summary' tab. Ensure it is enabled and not obscured.

verify Summary Sub Header Displayed
     [Documentation]  check the Sub Header Displayed
     ...    *argument*
     ...    ${Expected_Header}  the Expected Sub Header "WIN-CON ENTERPRISES, INC"
     [Arguments]     ${Expected_Header}   
     ${Actual_Sum_Header}    Get Text    ${Sum_Header_loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${TC_Summary_001['expected_Sum_Header']}    ${Actual_Sum_Header}   

verify Address is Displayed 
    [Documentation]    verify the Address is Displayed 
    ...    *Argument*
    ...    ${expected_Header}    give the Expected Address
    [Arguments]    ${expected_Header}
     ${sum_Adress_element}    Get Elements    ${Sum_Address_loc}
    FOR    ${element}    IN    @{sum_Adress_element}
        ${lines}    Get Text    ${element}
        Append To List    ${TC_Summary_001['Actual_Adress']}    ${lines}
    END
    ${final_Adress}    Catenate    SEPARATOR=,    @{TC_Summary_001['Actual_Adress']}
    Log    ${final_Adress}
    Run Keyword And Continue On Failure    Should Be Equal    ${final_Adress}     ${expected_Header}

# Enter the Policy Information
#     [Documentation]    This is used to enter the Policy Information 
#     ...    ${policy_Info}     here We need to pass the policy Information which we need to Enter
#     [Arguments]    ${policy_Info}  
 
#     Click    ${permium_Btn_Loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    premium_field_loc    ${premium_field_loc}    visible    premium_field_loc is not avilable Summary tab
#     # Wait For Elements State    ${premium_field_loc}    visible    5s
#     Fill Text    ${premium_field_loc}    ${policy_Info['premium']}
#     Click    ${Attachement_point_btn_loc}
#     # Wait For Elements State    ${Attachement_point_field_loc}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Attachement_point_field_loc    ${Attachement_point_field_loc}    visible    Attachement_point_field_loc is not avilable Summary tab
#     Fill Text    ${Attachement_point_field_loc}    ${policy_Info['AttachmentPoint']}
#     Click    ${policy_Btn_Loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    policy_field_Loc    ${policy_field_Loc}    visible    policy_field_Loc is not avilable Summary tab
#     # Wait For Elements State    ${policy_field_Loc}    visible    5s
#     Fill Text    ${policy_field_Loc}    ${policy_Info['PolicyNumber']}
#     click    ${loc_ClassOf_Business}
#     ${element}    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['ClassOfBusiness']}    ']    
#     click    ${element} 
#     click    ${Loc_Placement_Button}
#     ${place_element}    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['PlacementType']}    ']    
#     click    ${place_element}

# Enter the Policy Information
#     [Documentation]    Enters Policy Information details in the Summary tab.
#     ...    *Arguments:*
#     ...    - `${policy_Info}`: Dictionary containing policy details to enter.

#     [Arguments]    ${policy_Info}

#     ${clickStatus}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
#     Should Be True    ${clickStatus}    'Failed to click Premium button.'

#     ${premiumVisible}=    Run Keyword And Return Status    Wait For Elements State    ${premium_field_loc}    visible    timeout=${element_timeout}
#     Should Be True    ${premiumVisible}    'Premium field not visible in Summary tab.'
#     ${premiumFillStatus}=    Run Keyword And Return Status    Fill Text    ${premium_field_loc}    ${policy_Info['premium']}
#     Should Be True    ${premiumFillStatus}    'Failed to fill Premium field.'

#     ${attachClick}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_loc}
#     Should Be True    ${attachClick}    'Failed to click Attachment Point button.'

#     ${attachVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_field_loc}    visible    timeout=${element_timeout}
#     Should Be True    ${attachVisible}    'Attachment Point field not visible in Summary tab.'
#     ${attachFillStatus}=    Run Keyword And Return Status    Fill Text    ${Attachement_point_field_loc}    ${policy_Info['AttachmentPoint']}
#     Should Be True    ${attachFillStatus}    'Failed to fill Attachment Point field.'

#     ${policyClick}=    Run Keyword And Return Status    Click    ${policy_Btn_Loc}
#     Should Be True    ${policyClick}    'Failed to click Policy button.'

#     ${policyVisible}=    Run Keyword And Return Status    Wait For Elements State    ${policy_field_Loc}    visible    timeout=${element_timeout}
#     Should Be True    ${policyVisible}    'Policy Number field not visible in Summary tab.'
#     ${policyFillStatus}=    Run Keyword And Return Status    Fill Text    ${policy_field_Loc}    ${policy_Info['PolicyNumber']}
#     Should Be True    ${policyFillStatus}    'Failed to fill Policy Number field.'

#     ${classClick}=    Run Keyword And Return Status    Click    ${loc_ClassOf_Business}
#     Should Be True    ${classClick}    'Failed to click Class of Business dropdown.'
#     ${classElement}=    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['ClassOfBusiness']}    ']    
#     ${classSelect}=    Run Keyword And Return Status    Click    ${classElement}
#     Should Be True    ${classSelect}    'Failed to select Class of Business.'

#     ${placementClick}=    Run Keyword And Return Status    Click    ${Loc_Placement_Button}
#     Should Be True    ${placementClick}    'Failed to click Placement Type dropdown.'
#     ${placementElement}=    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['PlacementType']}    ']    
#     ${placementSelect}=    Run Keyword And Return Status    Click    ${placementElement}
#     Should Be True    ${placementSelect}    'Failed to select Placement Type.'

#     Log    Policy Information entered successfully.    INFO
Enter the Policy Information
    [Documentation]    Enters Policy Information details in the Summary tab.
    ...    *Arguments:*
    ...    - `${policy_Info}`: Dictionary containing policy details to enter.

    [Arguments]    ${policy_Info}

    ${clickStatus}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    Should Be True    ${clickStatus}    'Failed to click Premium button.'

    ${premiumVisible}=    Run Keyword And Return Status    Wait For Elements State    ${premium_field_loc}    visible    timeout=${element_timeout}
    Should Be True    ${premiumVisible}    'Premium field not visible in Summary tab.'
    ${premiumFillStatus}=    Run Keyword And Return Status    Fill Text    ${premium_field_loc}    ${policy_Info['premium']}
    Should Be True    ${premiumFillStatus}    'Failed to fill Premium field.'

    ${attachClick}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_loc}
    Should Be True    ${attachClick}    'Failed to click Attachment Point button.'

    ${attachVisible}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_field_loc}    visible    timeout=${element_timeout}
    Should Be True    ${attachVisible}    'Attachment Point field not visible in Summary tab.'
    ${attachFillStatus}=    Run Keyword And Return Status    Fill Text    ${Attachement_point_field_loc}    ${policy_Info['AttachmentPoint']}
    Should Be True    ${attachFillStatus}    'Failed to fill Attachment Point field.'

    ${policyClick}=    Run Keyword And Return Status    Click    ${policy_Btn_Loc}
    Should Be True    ${policyClick}    'Failed to click Policy button.'

    ${policyVisible}=    Run Keyword And Return Status    Wait For Elements State    ${policy_field_Loc}    visible    timeout=${element_timeout}
    Should Be True    ${policyVisible}    'Policy Number field not visible in Summary tab.'
    ${policyFillStatus}=    Run Keyword And Return Status    Fill Text    ${policy_field_Loc}    ${policy_Info['PolicyNumber']}
    Should Be True    ${policyFillStatus}    'Failed to fill Policy Number field.'

    ${classClick}=    Run Keyword And Return Status    Click    ${loc_ClassOf_Business}
    Should Be True    ${classClick}    'Failed to click Class of Business dropdown.'
    ${classElement}=    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['ClassOfBusiness']}    ']    
    ${classSelect}=    Run Keyword And Return Status    Click    ${classElement}
    Should Be True    ${classSelect}    'Failed to select Class of Business.'

    ${placementClick}=    Run Keyword And Return Status    Click    ${Loc_Placement_Button}
    Should Be True    ${placementClick}    'Failed to click Placement Type dropdown.'
    ${placementElement}=    Catenate    SEPARATOR=    ${loc1_Select_Type}    ${policy_Info['PlacementType']}    ']    
    ${placementSelect}=    Run Keyword And Return Status    Click    ${placementElement}
    Should Be True    ${placementSelect}    'Failed to select Placement Type.'

    Log    Policy Information entered successfully.    INFO


# Re Enter the Policy Information details
#     [Documentation]    This method is used to the Re Enter the Policy Information details If the error message occured
#     ...    ${PolicyInfo}    we need to pass the Policy Information details as dictionary
#     [Arguments]    ${PolicyInfo}    ${stageNo}
#     ${states}=    Get Element States    ${Workflow_Advance_Stage}
#     ${isEnabled}=    Run Keyword And Return Status    List Should Contain Value    ${states}    enabled
#     ${isVisible}=    Run Keyword And Return Status    List Should Contain Value    ${states}    visible
#     IF    ${isEnabled} and ${isVisible}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Workflow_Advance_Stage    ${Workflow_Advance_Stage}    visible    Wait for the Workflow Advance Stage button and verify that it is visible.
#     Click    ${Workflow_Advance_Stage}
#         ${states}=    Get Element States    ${schemaNotFoundError}
#         ${errormsgState}=    Run Keyword And Return Status    List Should Contain Value    ${states}    visible
#         IF    ${errormsgState}
#             Run Keyword And Continue On Failure    Fail    Schema Not Found Error is Displayed. Policy Information Values not Saved
#             Click Edit Submission
#             Switch To Summary
#             Enter the Policy Information    ${PolicyInfo}
#             Run Keyword And Continue On Failure    Save Submission And verify popup
#             Click Answers Tab
#             Advance Stage    ${stageNo}
#         END
#     END

Re Enter the Policy Information details
    [Documentation]    Re-enters the Policy Information details if a schema error message occurs.
    ...    ${PolicyInfo} should be passed as a dictionary.
    ...    ${stageNo} is the current workflow stage number.
    [Arguments]    ${PolicyInfo}    ${stageNo}

    ${states}=    Get Element States    ${Workflow_Advance_Stage}
    ${isEnabled}=    Run Keyword And Return Status    List Should Contain Value    ${states}    enabled
    ${isVisible}=    Run Keyword And Return Status    List Should Contain Value    ${states}    visible

    IF    ${isEnabled} and ${isVisible}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Advance_Stage}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Wait for the Workflow Advance Stage button and verify that it is visible.
        ${clicked}=    Run Keyword And Return Status    Click    ${Workflow_Advance_Stage}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Re Enter Policy Info: Failed to click Workflow Advance Stage button.

        ${error_states}=    Get Element States    ${schemaNotFoundError}
        ${errormsg_visible}=    Run Keyword And Return Status    List Should Contain Value    ${error_states}    visible

        IF    ${errormsg_visible}
            Run Keyword And Continue On Failure    Fail    Schema Not Found Error is displayed. Policy Information values were not saved.

            ${edit_clicked}=    Run Keyword And Return Status    Click Edit Submission
            Run Keyword And Continue On Failure    Should Be True    ${edit_clicked}    msg=Re Enter Policy Info: Failed to click Edit Submission.

            ${switch_summary}=    Run Keyword And Return Status    Switch To Summary
            Run Keyword And Continue On Failure    Should Be True    ${switch_summary}    msg=Re Enter Policy Info: Failed to switch to Summary tab.

            Enter the Policy Information    ${PolicyInfo}
            Run Keyword And Continue On Failure    Save Submission And verify popup

            ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
            Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Re Enter Policy Info: Failed to click Answers tab.

            Advance Stage    ${stageNo}
        END
    END


# Verify Policy Information Details from Summary Tab
#     [Documentation]    the Given Policy Informaton Should be listed
#     ...    ${expected_Policy_Field}    here We need to Pass the Expected policy Information Along with We need to pass the Key field in Summary tab     

#     [Arguments]    ${expected_Policy_Field}    ${Expected_Forms_PolicyInormation}   
#     # ${Premium_value}=    Evaluate    '"$ {:,}".format(${Expected_Forms_PolicyInormation['TC_Forms_002']['DocumentationData']['PolicyPremium']}) 
#     # ${AttachmentPoint_value}=    Evaluate    '"$ {:,}".format(${expected_Policy_Field['AttachmentPoint']})     
#     ${Actual_Policy_Text}    Get Text    ${policy_btn_Loc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Policy_Text}    ${Expected_Forms_PolicyInormation['TC_Forms_002']['DocumentationData']['PolicyNumber']}
#     ${Actual_Premium_Text}    Get Text    ${permium_Btn_Loc}
#     ${Actual_Premium_Text}    Replace String    ${Actual_Premium_Text}    $    ${EMPTY}
#     ${Actual_Premium_Text}    Replace String    ${Actual_Premium_Text}    ,    ${EMPTY}
#     ${Actual_Premium_Text}    Strip String    ${Actual_Premium_Text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Premium_Text}    ${Expected_Forms_PolicyInormation['TC_Forms_002']['DocumentationData']['PolicyPremium']}
#     ${Actual_Attachment_Text}    Get Text    ${Attachement_point_btn_loc}
#     ${Actual_Attachment_Text}    Replace String    ${Actual_Attachment_Text}    $    ${EMPTY}
#     ${Actual_Attachment_Text}    Replace String    ${Actual_Attachment_Text}    ,    ${EMPTY}
#     ${Actual_Attachment_Text}    Strip String    ${Actual_Attachment_Text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Attachment_Text}    ${expected_Policy_Field['AttachmentPoint']}
#     ${Actual_ClassOf_Business}    Get Text    ${loc_ClassOf_Business}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_ClassOf_Business}    ${expected_Policy_Field['ClassOfBusiness']}
#     ${Actual_Placement_Text}    Get Text    ${Loc_Placement_Button}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Placement_Text}    ${expected_Policy_Field['PlacementType']}
#     ${Actual_Policy_Field}    Create List
#     ${Actual_Policy_Field_Text}    Get Text    ${policy_Field}
#     ${Actual_Premium_Field}    Get Text    ${permium_Field}
#     ${Actual_Business_Field}    Get Text    ${loc_ClassOf_Business_Field}
#     ${Actual_Attachement_Field}    Get Text    ${Attachement_point_Field}
#     ${Actual_Mailed_Field}    Get Text    ${loc_Mailed_Date_Field}
#     ${Actual_Placement_Field}    Get Text    ${Loc_Placement_Field}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Premium_Field}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Attachement_Field}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Policy_Field_Text}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Business_Field}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Placement_Field}
#     Append To List    ${Actual_Policy_Field}    ${Actual_Mailed_Field}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_Policy_Field}    ${expected_Policy_Field['PolicyFields']}

Verify Policy Information Details from Summary Tab
    [Documentation]    Verifies that the given Policy Information is correctly listed in the Summary tab.
    ...    ${expected_Policy_Field} should be passed as a dictionary of expected policy values.
    ...    ${Expected_Forms_PolicyInformation} should contain expected forms policy information.
    [Arguments]    ${expected_Policy_Field}    ${Expected_Forms_PolicyInformation}

    # Verify Policy Number
    ${policy_text}=    Get Text    ${policy_btn_Loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${policy_text}    ${Expected_Forms_PolicyInformation['TC_Forms_002']['DocumentationData']['PolicyNumber']}    msg=Policy Number mismatch in Summary tab.
    # Verify Policy Premium
    ${premium_text}=    Get Text    ${permium_Btn_Loc}
    ${premium_text}=    Replace String    ${premium_text}    $    ${EMPTY}
    ${premium_text}=    Replace String    ${premium_text}    ,    ${EMPTY}
    ${premium_text}=    Strip String    ${premium_text}
    Run Keyword And Continue On Failure    Should Be Equal    ${premium_text}    ${Expected_Forms_PolicyInformation['TC_Forms_002']['DocumentationData']['PolicyPremium']}    msg=Policy Premium mismatch in Summary tab.
    # Verify Attachment Point
    ${attachment_text}=    Get Text    ${Attachement_point_btn_loc}
    ${attachment_text}=    Replace String    ${attachment_text}    $    ${EMPTY}
    ${attachment_text}=    Replace String    ${attachment_text}    ,    ${EMPTY}
    ${attachment_text}=    Strip String    ${attachment_text}
    Run Keyword And Continue On Failure    Should Be Equal    ${attachment_text}    ${expected_Policy_Field['AttachmentPoint']}    msg=Attachment Point mismatch in Summary tab.
    # Verify Class of Business
    ${class_text}=    Get Text    ${loc_ClassOf_Business}
    Run Keyword And Continue On Failure    Should Be Equal    ${class_text}    ${expected_Policy_Field['ClassOfBusiness']}    msg=Class of Business mismatch in Summary tab.
    # Verify Placement Type
    ${placement_text}=    Get Text    ${Loc_Placement_Button}
    Run Keyword And Continue On Failure    Should Be Equal    ${placement_text}    ${expected_Policy_Field['PlacementType']}    msg=Placement Type mismatch in Summary tab.
    # Verify all other fields collectively
    ${actual_fields}=    Create List
    ${policy_field}=    Get Text    ${policy_Field}
    ${premium_field}=    Get Text    ${permium_Field}
    ${business_field}=    Get Text    ${loc_ClassOf_Business_Field}
    ${attachment_field}=    Get Text    ${Attachement_point_Field}
    ${mailed_field}=    Get Text    ${loc_Mailed_Date_Field}
    ${placement_field}=    Get Text    ${Loc_Placement_Field}
    Append To List    ${actual_fields}    ${premium_field}
    Append To List    ${actual_fields}    ${attachment_field}
    Append To List    ${actual_fields}    ${policy_field}
    Append To List    ${actual_fields}    ${business_field}
    Append To List    ${actual_fields}    ${placement_field}
    Append To List    ${actual_fields}    ${mailed_field}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${actual_fields}    ${expected_Policy_Field['PolicyFields']}    msg=Policy fields in Summary tab do not match expected values.

# Verify Policy PDF is Generated and Available in Documents Tab
#     [Documentation]    Verifies that the Policy PDF is generated and listed in the Documents tab.
#     ...    ${expectedText1}     we need to pass the policy Information use in Summary Tab in Previous Stage  
#     [Arguments]     ${expectedText1}
#     ${Expected_Policy_text}    Create List
#     Append To List    ${Expected_Policy_text}    ${expectedText1['premium']}
#     Append To List    ${Expected_Policy_text}    ${expectedText1['AttachmentPoint']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['PolicyNumber']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['ClassOfBusiness']}  
#     Append To List    ${Expected_Policy_text}    ${expectedText1['PlacementType']}  
#     @{actual_Policy_text}    Create List
#     Switch To Documents
#     Run Keyword And Continue On Failure    Wait For Element With Message    Document_options    ${Document_options}    visible    Document_options is not avilable in side Menu 
#     # Wait For Elements State    ${Document_options}    visible 
#     Click    ${Document_options}
#     Click    ${Show_Documents}
#     ${elements}=    Get Elements    ${PolicyDataModification}
#     ${last_Element}=    Set Variable    ${elements}[-1]
#     Scroll To Element    ${last_Element}
#     Run Keyword And Continue On Failure    Wait For Element With Message    last_Element    ${last_Element}    visible    Policy modification file  is not Created by the System 
#     # Wait For Elements State    ${last_Element}    visible    timeout=${element_timeout}
#     Click    ${last_Element}
#     # ${Length}    Get Length    ${TC_Summary_001['Doc_Loc']}
#     FOR    ${element}    IN    @{TC_Summary_001['Doc_Loc']}
#      ${ele_Loc}    Catenate    SEPARATOR=    ${policy_locators1}    ${element}    ${policy_locators2}
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

Verify Policy PDF is Generated and Available in Documents Tab
    [Documentation]    Verifies that the Policy PDF is generated and listed in the Documents tab.
    ...    ${expectedText1}: Policy information used in Summary tab in previous stage.
    [Arguments]    ${expectedText1}

    # Prepare expected policy values list
    ${Expected_Policy_text}=    Create List
    Append To List    ${Expected_Policy_text}    ${expectedText1['premium']}
    Append To List    ${Expected_Policy_text}    ${expectedText1['AttachmentPoint']}
    Append To List    ${Expected_Policy_text}    ${expectedText1['PolicyNumber']}
    Append To List    ${Expected_Policy_text}    ${expectedText1['ClassOfBusiness']}
    Append To List    ${Expected_Policy_text}    ${expectedText1['PlacementType']}

    @{actual_Policy_text}=    Create List

    # Switch to Documents tab
    ${switch_docs}=    Run Keyword And Return Status    Switch To Documents
    Run Keyword And Continue On Failure    Should Be True    ${switch_docs}    msg=Failed to switch to Documents tab.

    ${doc_options_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Document_options}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${doc_options_visible}

    ${click_doc_options}=    Run Keyword And Return Status    Click    ${Document_options}
    Run Keyword And Continue On Failure    Should Be True    ${click_doc_options}    msg=Failed to click Document Options.

    ${click_show_docs}=    Run Keyword And Return Status    Click    ${Show_Documents}
    Run Keyword And Continue On Failure    Should Be True    ${click_show_docs}    msg=Failed to click Show Documents.

    # Scroll to the last Policy PDF element
    ${elements}=    Get Elements    ${PolicyDataModification}
    ${last_element}=    Set Variable    ${elements}[-1]
    Scroll To Element    ${last_element}

    Run Keyword And Continue On Failure    Wait For Elements State    ${last_element}    visible    timeout=${element_timeout}

    ${click_last_element}=    Run Keyword And Return Status    Click    ${last_element}
    Run Keyword And Continue On Failure    Should Be True    ${click_last_element}    msg=Failed to click last Policy PDF element.

    # Iterate through expected document locators and verify content
    FOR    ${element}    IN    @{TC_Summary_001['Doc_Loc']}
        ${ele_Loc}=    Catenate    SEPARATOR=    ${policy_locators1}    ${element}    ${policy_locators2}
        Sleep    1s

        ${click_policy_page}=    Run Keyword And Return Status    Click    ${poloicy_Data_modification_page}
        Run Keyword And Continue On Failure    Should Be True    ${click_policy_page}    msg=Failed to click Policy Data Modification page.

        Press Keys    xpath=//*[@class='ace_content']    Control+f
        Type Text    ${Search_Bar_CtrlF}    ${element}

        ${result}=    Get Text    ${ele_Loc}

        IF    '"' in '''${result}'''
            ${cleaned}=    Evaluate    ${result}.replace('"', '')    modules=builtins
            Append To List    ${actual_Policy_text}    ${cleaned}
        ELSE
            Append To List    ${actual_Policy_text}    ${result}
        END
    END

    Log    ${actual_Policy_text}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${actual_Policy_text}    ${Expected_Policy_text}    msg=Policy PDF content does not match expected values.

# Verify Child Submission Should be Displayed in Summary Tab
#     [Documentation]    this method is used to verify the Child Submission detials in Summary tab
#     ...    ${Expected_Product_type}     This We need to Pass the Child Submission Product Type 
#     [Arguments]    ${Expected_Product_type}    
#    ${Product_type}    Get Text    ${Expected_Product_Type_Loc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Product_type}    ${Expected_Product_type}
#    ${Status_type}    Get Text    ${Expected_Status_Type_Loc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Status_type}   ${TC_Summary_001['Child_Sub_Stage']}
#    ${EffectiveDate_type}    Get Text    ${Expected_Eff_date_loc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${EffectiveDate_type}    ${TC_E2E_001['EffectiveDate']}
#    ${exp_type}    Get Text    ${Expected_Exp_date_loc}  
#     Run Keyword And Continue On Failure    Should Be Equal    ${exp_type}    ${TC_E2E_001['ExpirationDate']}
 
Verify Child Submission Should be Displayed in Summary Tab
    [Documentation]    Verifies the Child Submission details in the Summary tab.
    ...    ${Expected_Product_type}: Child Submission Product Type to verify.
    [Arguments]    ${Expected_Product_type}

    # Verify Product Type
    ${Product_type}=    Get Text    ${Expected_Product_Type_Loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${Product_type}    ${Expected_Product_type}    msg=Child Submission Product Type mismatch.

    # Verify Status
    ${Status_type}=    Get Text    ${Expected_Status_Type_Loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${Status_type}    ${TC_Summary_001['Child_Sub_Stage']}    msg=Child Submission Stage/Status mismatch.

    # Verify Effective Date
    ${EffectiveDate_type}=    Get Text    ${Expected_Eff_date_loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${EffectiveDate_type}    ${TC_E2E_001['EffectiveDate']}    msg=Child Submission Effective Date mismatch.

    # Verify Expiration Date
    ${exp_type}=    Get Text    ${Expected_Exp_date_loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${exp_type}    ${TC_E2E_001['ExpirationDate']}    msg=Child Submission Expiration Date mismatch.


# verify Account History are editable
#     [Documentation]    this Method is used to The Account History  Editable or not
#     ...   ${policy_Detials}     we need to pass the Policy data      
#     [Arguments]    ${policy_Detials}
   
#     Switch To Email Tab
#     ${elements}    Get Elements    //aside//a
#     ${parent_length}    Get Length    ${elements}
#     Click Answers Tab
#     Switch to Summary
#     Run Keyword And Continue On Failure    verify the entered Policy Information    ${policy_Detials}
#     Click    ${Expected_Product_Type_Loc}
#     ${element}    Catenate    SEPARATOR=    ${Expected_Product_Type_Loc}    //span    
#     ${Product_type1}    Get Text    ${element}
#     Run Keyword And Continue On Failure    Should Contain    ${Product_type1}    Current
#     Switch To Email Tab
#     ${elements}    Get Elements    //aside//a
#     ${child_length}    Get Length    ${elements}
#     Run Keyword And Continue On Failure    Should Be Equal    ${parent_length}    ${child_length}
#     Click Answers Tab
#     Switch to Summary
#     click    ${Excepted_parent_product_type}
#     ${element}    Catenate    SEPARATOR=    ${Excepted_parent_product_type}    //span    
#     ${Product_type1}    Get Text    ${element}
#     Run Keyword And Continue On Failure    Should Contain    ${Product_type1}    Current
#     # Select Submission using submission id    ${Submission_Id}    @{TC_E2E_001['SubmissionColumnNames']}

verify Account History are editable
    [Documentation]    Verifies whether the Account History is editable.
    ...    ${policy_Detials}: Policy data to verify in Summary and Answers tabs.
    [Arguments]    ${policy_Detials}

    # Switch to Email Tab and get initial number of elements
    ${switch_email}=    Run Keyword And Return Status    Switch To Email Tab
    Run Keyword And Continue On Failure    Should Be True    ${switch_email}    msg=Failed to switch to Email tab.

    ${elements}=    Get Elements    //aside//a
    ${parent_length}=    Get Length    ${elements}

    # Switch back to Answers Tab and Summary, then verify Policy Information
    ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers Tab.

    ${switch_summary}=    Run Keyword And Return Status    Switch to Summary
    Run Keyword And Continue On Failure    Should Be True    ${switch_summary}    msg=Failed to switch to Summary tab.

    Run Keyword And Continue On Failure    verify the entered Policy Information    ${policy_Detials}

    # Verify Child Product Type
    ${click_product}=    Run Keyword And Return Status    Click    ${Expected_Product_Type_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${click_product}    msg=Failed to click Expected Product Type location.

    ${element}=    Catenate    SEPARATOR=    ${Expected_Product_Type_Loc}    //span
    ${Product_type1}=    Get Text    ${element}
    Run Keyword And Continue On Failure    Should Contain    ${Product_type1}    Current    msg=Child Product Type does not contain 'Current'.

    # Switch to Email Tab and verify element count remains same
    ${switch_email}=    Run Keyword And Return Status    Switch To Email Tab
    Run Keyword And Continue On Failure    Should Be True    ${switch_email}    msg=Failed to switch to Email tab.

    ${elements}=    Get Elements    //aside//a
    ${child_length}=    Get Length    ${elements}
    Run Keyword And Continue On Failure    Should Be Equal    ${parent_length}    ${child_length}    msg=Element count changed between parent and child.

    # Switch back to Answers Tab and Summary, verify Parent Product Type
    ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers Tab.

    ${switch_summary}=    Run Keyword And Return Status    Switch to Summary
    Run Keyword And Continue On Failure    Should Be True    ${switch_summary}    msg=Failed to switch to Summary tab.

    ${click_parent}=    Run Keyword And Return Status    Click    ${Excepted_parent_product_type}
    Run Keyword And Continue On Failure    Should Be True    ${click_parent}    msg=Failed to click Expected Parent Product Type.

    ${element}=    Catenate    SEPARATOR=    ${Excepted_parent_product_type}    //span
    ${Product_type1}=    Get Text    ${element}
    Run Keyword And Continue On Failure    Should Contain    ${Product_type1}    Current    msg=Parent Product Type does not contain 'Current'.

# Verify the workflow panel
#     [Documentation]    This method is used verify the Workflow_Lists
#     [Arguments]     ${Expected_Workflow_Lists} 
#     ${Actual_Workflow_Lists}    Create List   
#     Click Answers Tab
#     ${WorkFlow_Side_Panel}    Get Elements     ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#     ${WorkFlow_text}    Get Text    ${element}
#     Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text}    
#     END  
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_Workflow_Lists}    ${Expected_Workflow_Lists}

Verify the Workflow Panel
    [Documentation]    Verifies that the Workflow panel displays the expected list of workflow items.
    [Arguments]    ${Expected_Workflow_Lists}

    ${Actual_Workflow_Lists}=    Create List

    # Click Answers Tab
    ${click_answers}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers Tab.

    # Get all workflow elements
    ${WorkFlow_Side_Panel}=    Get Elements    ${Workflow_Lists}

    # Iterate through workflow elements and store text
    FOR    ${element}    IN    @{WorkFlow_Side_Panel}
        ${WorkFlow_text}=    Get Text    ${element}
        Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text}
    END

    # Compare actual vs expected workflow list
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_Workflow_Lists}    ${Expected_Workflow_Lists}    msg=Workflow panel items do not match expected list.

verify the WorkFlow in Summary Tab 
    [Documentation]    This method is used verify the Workflow_Lists is present in Summary Tab
    [Arguments]    ${Expected_Workflow_Lists}
    ${Actual_Workflow_Lists}    Create List
    Switch to Summary
    Click    ${Loc_Header_Status}
    ${WorkFlow_SummaryTab}    Get Elements     ${Summary_Workflow_Lists}
    FOR    ${element1}    IN    @{WorkFlow_SummaryTab}
        ${WorkFlow_text1}    Get Text    ${element1}
        Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text1}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${Actual_Workflow_Lists}    ${Expected_Workflow_Lists}

# Verify the Workflow Reflected in Summary tab
#     [Documentation]    This method is used verify the Workflow_Lists
#     ...    ${Stage_Type} Here we need to Pass the Advance Stage (eg:if Draft Stage means we need to pass cleared Stage )   

#     [Arguments]    ${Stage_Type} 
#      ${Actual_Workflow_Lists}    Create List   
#     ${Expected_Workflow_Lists}    Create List
#     ${text}    Catenate    Advance to    ${Stage_Type}    
#      Append To List    ${Actual_Workflow_Lists}    ${text}    
#     Click Answers Tab
#     ${WorkFlow_Side_Panel}    Get Elements     ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#     ${WorkFlow_text_Panel}    Get Text    ${element}
#     ${WorkFlow_text_Panel1}    Strip String    ${WorkFlow_text_Panel}
#     Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text_Panel1}           
#     END  
#     Switch to Summary
#     Click    ${Loc_Header_Status}
#     ${WorkFlow_SummaryTab}    Get Elements     ${Summary_Workflow_Lists}
#     FOR    ${element1}    IN    @{WorkFlow_SummaryTab}
#         ${WorkFlow_text2}    Get Text    ${element1}
#         ${WorkFlow_text1}    Strip String    ${WorkFlow_text2}
#         Append To List    ${Expected_Workflow_Lists}    ${WorkFlow_text1}
        
#     END
#     FOR    ${value}    IN    @{Expected_Workflow_Lists}
#         Run Keyword And Continue On Failure     Should Contain    ${Actual_Workflow_Lists}    ${value}
#     END
#     Press Keys    ${Loc_Header_Status}    Escape
Verify the Workflow Reflected in Summary Tab
    [Documentation]    Verifies that the workflow stages reflected in the Summary tab match the expected workflow.
    [Arguments]    ${Stage_Type}

    ${Actual_Workflow_Lists}=    Create List
    ${Expected_Workflow_Lists}=    Create List

    # Add the advance stage text
    ${advance_text}=    Catenate    Advance to    ${Stage_Type}
    Append To List    ${Actual_Workflow_Lists}    ${advance_text}

    # Collect workflow from side panel
    Click Answers Tab
    # ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${Workflow_Lists}    visible    timeout=${display_timeout}
	# Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Workflow: Workflow side panel elements not found
    # ${side_panel_status}=    Get Elements    ${Workflow_Lists}
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${side_panel_status}    msg=Verify Workflow: Workflow side panel elements not found. Locator: ${Workflow_Lists}
    ${WorkFlow_Side_Panel}=    Get Elements    ${Workflow_Lists}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_Side_Panel}    msg=Verify Workflow: Workflow side panel is empty. No stages found.

    FOR    ${element}    IN    @{WorkFlow_Side_Panel}
        ${WorkFlow_text}=    Get Text    ${element}
        # Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_text}    msg=Verify Workflow: Failed to get text for side panel stage element: ${element}. Ensure the element is visible and contains text.
        ${WorkFlow_text_clean}=    Strip String    ${WorkFlow_text}
        Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text_clean}
    END
    # Collect workflow from Summary tab
    Switch to Summary
    ${Status}    Run Keyword And Return Status    Click    ${Loc_Header_Status}
    Should Be True    ${Status}    Unable to click the Workflow dropdown in Summary tab
    # ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Workflow_Lists}    visible    timeout=${display_timeout}
	# Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Workflow: Summary tab workflow list is empty. No stages displayed.
    @{WorkFlow_SummaryTab}=    Get Elements    ${Summary_Workflow_Lists}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_SummaryTab}    msg=Verify Workflow: Summary tab workflow list is empty. No stages displayed.

    FOR    ${element1}    IN    @{WorkFlow_SummaryTab}
        ${Status}    Run Keyword And Return Status    Wait For Elements State    ${element1}    visible    timeout=${display_timeout}
        Should Be True    ${Status}
        ${WorkFlow_text2}=    Get Text    ${element1}
        # Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_text2}    msg=Verify Workflow: Failed to get text for Summary tab stage element: ${element1}. Ensure the element is visible and contains text.
        ${WorkFlow_text_clean}=    Strip String    ${WorkFlow_text2}
        Append To List    ${Expected_Workflow_Lists}    ${WorkFlow_text_clean}
    END

    # Compare actual vs expected workflow stages
    FOR    ${value}    IN    @{Expected_Workflow_Lists}
        ${stage_present}=    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Contain    ${Actual_Workflow_Lists}    ${value}
        Run Keyword And Continue On Failure    Should Be True    ${stage_present}    msg=Verify Workflow: Stage '${value}' is missing in actual workflow list. Actual stages: ${Actual_Workflow_Lists}
    END

    # Close the workflow dropdown
    ${closed}=    Run Keyword And Return Status    Press Keys    ${Loc_Header_Status}    Escape
    Run Keyword And Continue On Failure    Should Be True    ${closed}    msg=Verify Workflow: Failed to close the workflow dropdown using Escape key. Ensure the dropdown is focused and enabled.

# verify the entered Policy Information
#     [Documentation]    verify that given Text Are enter Correctly on premium And Attachment point And policy  field
#     ...    *argument*
#     ...    ${expected_Policy_Field}
#     [Arguments]    ${expected_Policy_Field}

#      ${Actual_Policy_Text}    Get Text    ${policy_btn_Loc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Policy_Text}    ${expected_Policy_Field['PolicyNumber']}
#     ${Actual_Premium_Text}    Get Text    ${permium_Btn_Loc}
#     ${Actual_Premium_Text}    Replace String    ${Actual_Premium_Text}    $    ${EMPTY}
#     ${Actual_Premium_Text}    Replace String    ${Actual_Premium_Text}    ,    ${EMPTY}
#     ${Actual_Premium_Text}    Strip String    ${Actual_Premium_Text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Premium_Text}    ${expected_Policy_Field['premium']}
#     ${Actual_Attachment_Text}    Get Text    ${Attachement_point_btn_loc}
#     ${Actual_Attachment_Text}    Replace String    ${Actual_Attachment_Text}    $    ${EMPTY}
#     ${Actual_Attachment_Text}    Replace String    ${Actual_Attachment_Text}    ,    ${EMPTY}
#     ${Actual_Attachment_Text}    Strip String    ${Actual_Attachment_Text}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Attachment_Text}    ${expected_Policy_Field['AttachmentPoint']}
#     ${Actual_ClassOf_Business}    Get Text    ${loc_ClassOf_Business}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_ClassOf_Business}    ${expected_Policy_Field['ClassOfBusiness']}
#     ${Actual_Placement_Text}    Get Text    ${Loc_Placement_Button}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Placement_Text}    ${expected_Policy_Field['PlacementType']}

Verify the Entered Policy Information
    [Documentation]    Verifies that the given Policy Information is entered correctly for Premium, Attachment Point, Policy Number, Class of Business, and Placement Type.
    [Arguments]    ${expected_Policy_Field}

    # Verify Policy Number
    ${Actual_Policy_Text}=    Get Text    ${policy_btn_Loc}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Policy_Text}    ${expected_Policy_Field['PolicyNumber']}    msg=Policy Number does not match expected value.

    # Verify Premium
    ${Actual_Premium_Text}=    Get Text    ${permium_Btn_Loc}
    ${Actual_Premium_Text}=    Replace String    ${Actual_Premium_Text}    $    ${EMPTY}
    ${Actual_Premium_Text}=    Replace String    ${Actual_Premium_Text}    ,    ${EMPTY}
    ${Actual_Premium_Text}=    Strip String    ${Actual_Premium_Text}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Premium_Text}    ${expected_Policy_Field['premium']}    msg=Premium value does not match expected value.

    # Verify Attachment Point
    ${Actual_Attachment_Text}=    Get Text    ${Attachement_point_btn_loc}
    ${Actual_Attachment_Text}=    Replace String    ${Actual_Attachment_Text}    $    ${EMPTY}
    ${Actual_Attachment_Text}=    Replace String    ${Actual_Attachment_Text}    ,    ${EMPTY}
    ${Actual_Attachment_Text}=    Strip String    ${Actual_Attachment_Text}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Attachment_Text}    ${expected_Policy_Field['AttachmentPoint']}    msg=Attachment Point value does not match expected value.

    # Verify Class of Business
    ${Actual_ClassOf_Business}=    Get Text    ${loc_ClassOf_Business}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_ClassOf_Business}    ${expected_Policy_Field['ClassOfBusiness']}    msg=Class of Business does not match expected value.

    # Verify Placement Type
    ${Actual_Placement_Text}=    Get Text    ${Loc_Placement_Button}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_Placement_Text}    ${expected_Policy_Field['PlacementType']}    msg=Placement Type does not match expected value.

# Advance Stage Popup Verification
#     [Documentation]    This method will verifies, while clicking the Advance stage in dropdown, it will Appears the popup message.it must show the next Stage.
#     [Arguments]    ${data}
#     Switch to Summary
#     Run Keyword And Continue On Failure    Wait For Element With Message    Summary_Stage_Dropdown    ${Summary_Stage_Dropdown}    visible    Summary_Stage_Dropdown is not avilable in Summary page 
#     # Wait For Elements State    ${Summary_Stage_Dropdown}
#     ${ActualStage}    Get Text    ${Summary_Stage_Dropdown}
#     Run Keyword And Continue On Failure    Should Be Equal    ${data['stage']}    ${ActualStage}
#     Click    ${Summary_Stage_Dropdown}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Summary_Adv_Stage    ${Summary_Adv_Stage}    visible    Summary_Adv_Stage is not avilable in Summary page
#     # Wait For Elements State    ${Summary_Adv_Stage}
#     Click    ${Summary_Adv_Stage}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Adv_Stage_popup    ${Adv_Stage_popup}    visible    Adv_Stage_popup is not avilable in Summary page
#     # Wait For Elements State    ${Adv_Stage_popup}
#     ${ActualPopup}    Get Text    ${Adv_Stage_popup}
#     Log    ${ActualPopup}
#     Run Keyword And Continue On Failure    Should Be Equal    ${data['Excepted_Advance_Popup']}    ${ActualPopup}
Advance Stage Popup Verification
    [Documentation]    This method verifies that clicking the Advance Stage option displays the correct popup.
    [Arguments]    ${data}

    Switch to Summary

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Stage_Dropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Summary_Stage_Dropdown is not available on Summary page.

    ${ActualStage}=    Get Text    ${Summary_Stage_Dropdown}
    Run Keyword And Continue On Failure    Should Be Equal    ${data['stage']}    ${ActualStage}    msg=Stage value mismatch in Summary page.

    ${clicked}=    Run Keyword And Return Status    Click    ${Summary_Stage_Dropdown}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Summary_Stage_Dropdown.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Adv_Stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Summary_Adv_Stage is not available in Summary page.

    ${clicked}=    Run Keyword And Return Status    Click    ${Summary_Adv_Stage}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Summary_Adv_Stage.

    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Adv_Stage_popup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Advance Stage popup is not visible.

    ${ActualPopup}=    Get Text    ${Adv_Stage_popup}
    Log    ${ActualPopup}

    Run Keyword And Continue On Failure    Should Be Equal    ${data['Excepted_Advance_Popup']}    ${ActualPopup}    msg=Advance Stage popup message mismatch.



# Summary Premium Field Verification
#     [Documentation]    This method verifies the Alphanumeric/Special characters should not accept in premium field
#     [Arguments]    ${data}

#     Switch to Summary
#     Click    ${permium_Btn_Loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    premium_field_loc    ${premium_field_loc}    visible    premium_field_loc is not avilable in Summary page
#     Fill Text    ${premium_field_loc}    ${data['premium'][0]}
#     Click    ${Attachement_point_btn_loc}
#     ${ActualValue}    Get Text    ${PloicyInformationErrorMessage}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ActualValue}    Premium must be a number.
#     Click Answers Tab
#     Switch to Summary
#     Click    ${permium_Btn_Loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    premium_field_loc    ${premium_field_loc}    visible    premium_field_loc is not avilable in Summary page
#     Fill Text    ${premium_field_loc}    ${data['premium'][1]}
#     Click    ${Attachement_point_btn_loc}
#     # Sleep    5s
#     Click Answers Tab
#     Switch to Summary
#     ${ActualValue1}    Get Text    ${permium_Btn_Loc}
#     ${ActualValue1}    Replace String    ${ActualValue1}    $    ${EMPTY}
#     ${ActualValue1}    Replace String    ${ActualValue1}    ,    ${EMPTY}
#     ${actualamount}    Convert To Number    ${ActualValue1}
#     ${expectedamount}    Convert To Number    ${data['premium'][1]}
#     Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${expectedamount}    ${actualamount}
Summary Premium Field Verification
    [Documentation]    This method verifies that alphanumeric/special characters are not accepted in the premium field.
    [Arguments]    ${data}

    # Switch to Summary tab
    Switch to Summary

    # Open the premium field
    ${clicked_premium}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_premium}    msg=Summary Premium Field: Failed to click on the premium button. Ensure it is visible and enabled.

    ${field_visible}=    Run Keyword And Return Status    Wait For Elements State    ${premium_field_loc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${field_visible}    msg=Summary Premium Field: Premium input field is not visible in Summary tab. Locator: ${premium_field_loc}

    # Verify invalid text input is rejected
    Type Text    ${premium_field_loc}    ${data['premium'][0]}
    ${clicked_attachment}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_attachment}    msg=Summary Premium Field: Failed to click attachment point button after entering invalid premium data.

    ${actual_message}=    Get Text    ${PloicyInformationErrorMessage}
    Run Keyword And Continue On Failure    Should Be Equal    ${actual_message}    Premium must be a number.    msg=Summary Premium Field: Expected error message 'Premium must be a number.' but got '${actual_message}'. Invalid input may not be rejected.

    # Verify numeric input is accepted
    Click Answers Tab
    Switch to Summary

    ${clicked_premium2}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_premium2}    msg=Summary Premium Field: Failed to click on the premium button for numeric input.

    ${field_visible2}=    Run Keyword And Return Status    Wait For Elements State    ${premium_field_loc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${field_visible2}    msg=Summary Premium Field: Premium input field is not visible for numeric input. Locator: ${premium_field_loc}

    Type Text    ${premium_field_loc}    ${data['premium'][1]}
    ${clicked_attachment2}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_attachment2}    msg=Summary Premium Field: Failed to click attachment point button after entering numeric premium data.

    Click Answers Tab
    Switch to Summary

    # Validate numeric value is saved correctly
    ${actual_value}=    Get Text    ${permium_Btn_Loc}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${actual_value}    msg=Summary Premium Field: Failed to get text from premium field button. Locator: ${permium_Btn_Loc}

    ${cleaned_value}=    Replace String    ${actual_value}    $    ${EMPTY}
    ${cleaned_value}=    Replace String    ${cleaned_value}    ,    ${EMPTY}
    ${actual_amount}=    Convert To Number    ${cleaned_value}
    ${expected_amount}=    Convert To Number    ${data['premium'][1]}
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${actual_amount}    ${expected_amount}    msg=Summary Premium Field: Numeric premium value mismatch. Expected: ${expected_amount}, Actual: ${actual_amount}

# Verify that Referral is not displayed in the Summary tab
#     [Documentation]    this method verifies that refferal is not there in summary page
#     [Arguments]    ${data}
#      ${Expected_Workflow_Lists}    Create List
#      Click Answers Tab
#      Switch to Summary
#     Click    ${Loc_Header_Status}
#     ${WorkFlow_SummaryTab}    Get Elements     ${Summary_Workflow_Lists}
#     FOR    ${element1}    IN    @{WorkFlow_SummaryTab}
#         ${WorkFlow_text2}    Get Text    ${element1}
#         ${WorkFlow_text1}    Strip String    ${WorkFlow_text2}
#         Append To List    ${Expected_Workflow_Lists}    ${WorkFlow_text1}
        
#     END
#     FOR    ${value}    IN    @{Expected_Workflow_Lists}
#         Run Keyword And Continue On Failure    Should Not Match    ${data['Ref_Header']}    ${value}
#     END
#      Press Keys    ${Loc_Header_Status}    Escape
Verify that Referral is not displayed in the Summary tab
    [Documentation]    This method verifies that referral is not present in the summary page
    [Arguments]    ${data}

    ${Expected_Workflow_Lists}=    Create List

    Click Answers Tab
    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers_Tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Verify Referral: 'Answers' tab is not visible in the side menu. Cannot proceed.

    Click    ${Answers_Tab}
    ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Referral: Failed to click 'Answers' tab. Ensure it is enabled.

    Switch to Summary
    # ${summary_tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${SummaryTab_loc}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${summary_tab_visible}    msg=Verify Referral: 'Summary' tab is not visible. Cannot switch to Summary.

    # Click    ${Loc_Header_Status}
    ${clicked_header}=    Run Keyword And Return Status    Click    ${Loc_Header_Status}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_header}    msg=Verify Referral: Failed to click the Summary Header status.

    ${WorkFlow_SummaryTab}=    Get Elements    ${Summary_Workflow_Lists}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_SummaryTab}    msg=Verify Referral: No workflow stages found in the Summary tab. Locator: ${Summary_Workflow_Lists}

    FOR    ${element1}    IN    @{WorkFlow_SummaryTab}
        ${WorkFlow_text2}=    Get Text    ${element1}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_text2}    msg=Verify Referral: Failed to get text from workflow stage element.
        ${WorkFlow_text1}=    Strip String    ${WorkFlow_text2}
        Append To List    ${Expected_Workflow_Lists}    ${WorkFlow_text1}
    END

    FOR    ${value}    IN    @{Expected_Workflow_Lists}
        Run Keyword And Continue On Failure    Should Not Match    ${data['Ref_Header']}    ${value}    msg=Verify Referral: The referral header '${data['Ref_Header']}' was found in the workflow stages: ${Expected_Workflow_Lists}
    END

    ${escape_pressed}=    Run Keyword And Return Status    Press Keys    ${Loc_Header_Status}    Escape
    Run Keyword And Continue On Failure    Should Be True    ${escape_pressed}    msg=Verify Referral: Failed to send Escape key to '${Loc_Header_Status}'. Ensure the element is visible and interactable.

# Verify that the Referral button is not displayed in the Draft stage

#     [Documentation]    This method verifies that the Referral button is not displayed in the Draft stage.
#     [Arguments]    ${data}
#     Click Answers Tab
#     ${Actual_Workflow_Lists}    Create List

#     ${WorkFlow_Side_Panel}    Get Elements     ${Workflow_Lists}
#     FOR    ${element}    IN    @{WorkFlow_Side_Panel}
#     ${WorkFlow_text_Panel}    Get Text    ${element}
#     ${WorkFlow_text_Panel1}    Strip String    ${WorkFlow_text_Panel}
#     Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text_Panel1}           
#     END  

#     FOR    ${element}    IN    @{Actual_Workflow_Lists}
#     Should Not Match    ${data['Ref_Header']}    ${element}
#         Log    ${element} 
#     END
Verify that the Referral button is not displayed in the Draft stage
    [Documentation]    This method verifies that the Referral button is not displayed in the Draft stage.
    [Arguments]    ${data}

    ${Actual_Workflow_Lists}=    Create List

    # Navigate to Answers Tab
    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers_Tab}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Verify Draft Referral: 'Answers' tab is not visible in the side menu. Cannot proceed.

    ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Draft Referral: Failed to click 'Answers' tab. Ensure it is enabled and not obscured.

    # Get all workflow stages from the side panel
    ${WorkFlow_Side_Panel}=    Get Elements    ${Workflow_Lists}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_Side_Panel}    msg=Verify Draft Referral: No workflow stages found in the side panel. Locator: ${Workflow_Lists}

    FOR    ${element}    IN    @{WorkFlow_Side_Panel}
        ${WorkFlow_text_Panel}=    Get Text    ${element}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${WorkFlow_text_Panel}    msg=Verify Draft Referral: Failed to get text from a workflow stage element in the side panel.
        ${WorkFlow_text_Panel1}=    Strip String    ${WorkFlow_text_Panel}
        Append To List    ${Actual_Workflow_Lists}    ${WorkFlow_text_Panel1}
    END

    # Verify Referral header is NOT present
    FOR    ${element}    IN    @{Actual_Workflow_Lists}
        Run Keyword And Continue On Failure    Should Not Match    ${data['Ref_Header']}    ${element}    msg=Verify Draft Referral: The referral header '${data['Ref_Header']}' was found in the Draft stage workflow stages: ${Actual_Workflow_Lists}
    END


# Verify Summary Workflow Stages
#     [Documentation]    This method verifies the stage names listed in the Summary tab and also validates the extract status of each stage.
#     [Arguments]    ${Number}    
#     Switch to Summary
    
#     ${Stage_Locator}    Get Elements    ${Summary_Workflow_Stages}
#     ${ExpectedStages}    Create List    In Draft    Cleared    Under Review    Quoted    Bind    Bound    Booked    Issued    
#     ${ActualStages}    Create List

#     ${count}    Get Length    ${Stage_Locator}

#     FOR    ${index}    IN RANGE    ${count}
#         ${element}    Get From List    ${Stage_Locator}    ${index}
#         Wait For Elements State    ${element}    visible    timeout=${element_timeout}
#         ${text}    Get Text    ${element}
#         Append To List    ${ActualStages}    ${text}
#         Log    The actual stage we get is: ${text}
#     END
#     Lists Should Be Equal    ${ExpectedStages}    ${ActualStages}

#     Wait For Elements State    ${Summary_Stage_Processing}    visible    timeout=${element_timeout}
#     ${ActualStageProcessing}    Get Text    ${Summary_Stage_Processing}
#     ${ActualStageNo}    Convert To Integer    ${ActualStageProcessing}
#     ${ExceptedStageNo}    Convert To Integer    ${Number}
#     Should Be Equal    ${ExceptedStageNo}    ${ActualStageNo}

    
#     ${ActualCompletedNo}    Evaluate    ${ExceptedStageNo} - 1

#     ${CompletedLocator}    Get Elements    ${Summary_Stage_completed}
#     ${Length}    Get Length    ${CompletedLocator}
#     ${LastIndex}    Evaluate    ${Length} - 1
#     Should Be Equal As Integers    ${ActualCompletedNo}    ${LastIndex}
    
#     FOR    ${index}    IN RANGE    ${Length}
#         ${completed_element}    Get From List    ${ActualStages}    ${index}
#         Log    The completed stage shown in summary tab is: ${completed_element}
#     END


# Verify Advance Stage Disable When Referral Pending
#     [Documentation]    This method verifies that the Advance Stage option is disabled when a referral is pending.
#     [Arguments]    ${data}
#     Switch to Summary
#     Wait For Elements State    ${Summary_Stage_Dropdown}
#     ${ActualStage}    Get Text    ${Summary_Stage_Dropdown}
#     Should Be Equal    ${data}    ${ActualStage}
#     Click    ${Summary_Stage_Dropdown}
#     Wait For Elements State    ${Summary_Adv_Stage}    visible    timeout=${element_timeout}
#     ${state}    Get Element States    ${Summary_Adv_Stage}
#     Should Contain    ${state}    disabled
#     Log    Verified that Advance Stage is disabled when referral is pending.
#     # Click    ${Summary_Stage_Dropdown}
#     Press Keys    ${Loc_Header_Status}    Escape


# Verify AttachmentPoint Must Accept Numeric Values
#     [Documentation]    This test verifies that the Attachment Point field accepts only numeric values
#     [Arguments]    ${ExceptedValue}
#     # Switch to Summary
#     Click    ${Attachement_point_btn_loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Attachement_point    ${Attachement_point_field_loc}    visible    Attachement point field is not visible
#         # Wait For Elements State    ${Attachement_point_field_loc}    visible    5s
    
#     # Verify text is rejected
#     Run Keyword And Continue On Failure    Run Keyword And Expect Error    *    Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentText']}

#     # Verify numeric input is accepted
#     Clear Text    ${Attachement_point_field_loc}
#     Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointValue']}
#     Click    ${permium_Btn_Loc}
#     ${NumericValue}    Get Text    ${Attachement_point_btn_loc}
#     ${CleanField1}    Replace String    ${NumericValue}    $    ${EMPTY}
#     ${CleanField2}    Replace String    ${CleanField1}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField2}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointValue']}

#     # Verify numeric input is accepting maximum digits
#     Click    ${Attachement_point_btn_loc}
#     Clear Text    ${Attachement_point_field_loc}
#     Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointMaximum']}
#     Click    ${permium_Btn_Loc}
#     ${MaxValue}    Get Text    ${Attachement_point_btn_loc}
#     ${CleanField3}    Replace String    ${MaxValue}    $    ${EMPTY}
#     ${CleanField4}    Replace String    ${CleanField3}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField4}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointMaximum']}

#     Click Answers Tab
#     Switch to Summary
#     Click    ${Attachement_point_btn_loc}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Attachement_point_field_loc    ${Attachement_point_field_loc}    visible    Attachement_point_field_loc is not avilable in Summary page
#     # Wait For Elements State    ${Attachement_point_field_loc}    visible    3s
#     ${pointValue}    Get Text    ${Attachement_point_field_loc}
#     ${CleanField5}    Replace String    ${pointValue}    $    ${EMPTY}
#     ${CleanField6}    Replace String    ${CleanField5}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField6}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointMaximum']}
Verify AttachmentPoint Must Accept Numeric Values
    [Documentation]    Verifies that the Attachment Point field accepts only numeric values and enforces maximum digits.
    [Arguments]    ${ExceptedValue}

    # Open the Attachment Point field
    ${clicked}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=AttachmentPoint: Failed to click the attachment point button in the Summary tab.

    ${field_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_field_loc}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${field_visible}    msg=AttachmentPoint: Attachment Point field is not visible in the Summary tab.

    # Verify text input is rejected
    ${text_rejected}=    Run Keyword And Return Status    Run Keyword And Expect Error    *    Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentText']}
    Run Keyword And Continue On Failure    Should Be True    ${text_rejected}    msg=AttachmentPoint: Non-numeric text '${ExceptedValue['AttachmentText']}' was incorrectly accepted in the Summary tab.

    # Verify numeric input is accepted
    ${cleared}=    Run Keyword And Return Status    Clear Text    ${Attachement_point_field_loc}
    Run Keyword And Continue On Failure    Should Be True    ${cleared}    msg=AttachmentPoint: Failed to clear Attachment Point field before numeric input in the Summary tab.

    ${filled}=    Run Keyword And Return Status    Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointValue']}
    Run Keyword And Continue On Failure    Should Be True    ${filled}    msg=AttachmentPoint: Failed to fill numeric value '${ExceptedValue['AttachmentPointValue']}'.

    ${clicked_save}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_save}    msg=AttachmentPoint: Failed to click Save button after entering numeric value in the Summary tab.
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_btn_loc}    visible    timeout=${element_timeout}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Summary tab: Attachment Point field not visible in summary tab in the Summary tab.
    ${numeric_text}=    Get Text    ${Attachement_point_btn_loc}
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${numeric_text}    msg=AttachmentPoint: Failed to read back the numeric value from the button.

    ${clean1}=    Replace String    ${numeric_text}    $    ${EMPTY}
    ${clean2}=    Replace String    ${clean1}    ,    ${EMPTY}
    ${actual_value}=    Strip String    ${clean2}

    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${actual_value}    ${ExceptedValue['AttachmentPointValue']}    msg=AttachmentPoint: Numeric value mismatch. Expected '${ExceptedValue['AttachmentPointValue']}', got '${actual_value}' in the Summary tab.

    # Verify numeric input with maximum digits
    ${clicked}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=AttachmentPoint: Failed to click the attachment point button for max value test in the Summary tab.
    
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_field_loc}    visible    timeout=${element_timeout}
    Should Be True    ${visible}    'Attachment Point field not visible in Summary tab in the Summary tab.'

    ${clearStatus}=    Run Keyword And Return Status    Clear Text    ${Attachement_point_field_loc}
    Should Be True    ${clearStatus}    'Failed to clear Attachment Point field.'

    ${fillStatus}=    Run Keyword And Return Status    Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointMaximum']}
    Should Be True    ${fillStatus}    'Failed to fill Attachment Point field in the Summary tab.'

    ${clickStatus}=    Run Keyword And Return Status    Click    ${permium_Btn_Loc}
    Should Be True    ${clickStatus}    'Failed to click Premium button in the Summary tab.'

    ${max_text}=    Get Text    ${Attachement_point_btn_loc}
    ${clean3}=    Replace String    ${max_text}    $    ${EMPTY}
    ${clean4}=    Replace String    ${clean3}    ,    ${EMPTY}
    ${actual_max}=    Strip String    ${clean4}

    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${actual_max}    ${ExceptedValue['AttachmentPointMaximum']}    msg=AttachmentPoint: Maximum numeric value mismatch. Expected '${ExceptedValue['AttachmentPointMaximum']}', got '${actual_max}'.

    # Verify value is retained in the field after navigating tabs
    Click Answers Tab
    Switch to Summary  # assuming you want to reuse the enhanced method

    ${clicked}=    Run Keyword And Return Status    Click    ${Attachement_point_btn_loc}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=AttachmentPoint: Failed to click attachment point button after switching back to Summary tab.

    ${field_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Attachement_point_field_loc}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${field_visible}    msg=AttachmentPoint: Field not visible in Summary tab.
    ${value_text}=    Get Text    ${Attachement_point_field_loc}
    ${clean5}=    Replace String    ${value_text}    $    ${EMPTY}
    ${clean6}=    Replace String    ${clean5}    ,    ${EMPTY}
    ${actual_value}=    Strip String    ${clean6}

    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${actual_value}    ${ExceptedValue['AttachmentPointMaximum']}    msg=AttachmentPoint: Value after switching tabs mismatch. Expected '${ExceptedValue['AttachmentPointMaximum']}', got '${actual_value}'.

# Verify Summary Workflow Stages
#     [Documentation]    This method verifies the stage names listed in the Summary tab and also validates the extract status of each stage.
#     [Arguments]    ${Number}    
#     Click Answers Tab
#     Switch to Summary
#     ${Stage_Locator}    Get Elements    ${Summary_Workflow_Stages}
#     ${ExpectedStages}    Create List    In Draft    Cleared    Under Review    Quoted    Bind    Bound    Booked    Issued    
#     ${ActualStages}    Create List

#     ${count}    Get Length    ${Stage_Locator}

#     FOR    ${index}    IN RANGE    ${count}
#         ${element}    Get From List    ${Stage_Locator}    ${index}
#         Run Keyword And Continue On Failure    Wait For Element With Message    element    ${element}    visible    
#         # Wait For Elements State    ${element}    visible    timeout=${element_timeout}
#         ${text}    Get Text    ${element}
#         Append To List    ${ActualStages}    ${text}
#         Log    The actual stage we get is: ${text}
#     END
#     Lists Should Be Equal    ${ExpectedStages}    ${ActualStages}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Summary_Stage_Processing    ${Summary_Stage_Processing}    visible    Summary_Stage_Processing is not avilable in Summary page
#     # Wait For Elements State    ${Summary_Stage_Processing}    visible    timeout=${element_timeout}
#     ${ActualStageProcessing}    Get Text    ${Summary_Stage_Processing}
#     ${ActualStageNo}    Convert To Integer    ${ActualStageProcessing}
#     ${ExceptedStageNo}    Convert To Integer    ${Number}
#     Should Be Equal    ${ExceptedStageNo}    ${ActualStageNo}

    
#     ${ActualCompletedNo}    Evaluate    ${ExceptedStageNo} - 1

#     ${CompletedLocator}    Get Elements    ${Summary_Stage_completed}
#     ${Length}    Get Length    ${CompletedLocator}
#     ${LastIndex}    Evaluate    ${Length} - 1
#     Should Be Equal As Integers    ${ActualCompletedNo}    ${LastIndex}
    
#     FOR    ${index}    IN RANGE    ${Length}
#         ${completed_element}    Get From List    ${ActualStages}    ${index}
#         Log    The completed stage shown in summary tab is: ${completed_element}
#     END
Verify Summary Workflow Stages
    [Documentation]    Verifies the stage names listed in the Summary tab and validates the extract status of each stage in detail.
    [Arguments]    ${Number}

    # Navigate to Summary tab
    Click Answers Tab
    Switch to Summary    # assuming "Summary" is the expected header

    # Get all stage elements
    ${stage_elements}=    Get Elements    ${Summary_Workflow_Stages}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${stage_elements}    msg=Verify Summary Workflow: Expected at least one workflow stage element in the Summary tab, but none were found. Please ensure the Summary tab is loaded correctly and the locator '${Summary_Workflow_Stages}' is accurate.

    ${expected_stages}=    Create List    In Draft    Cleared    Under Review    Quoted    Bind    Bound    Booked    Issued
    ${actual_stages}=    Create List

    ${stage_count}=    Get Length    ${stage_elements}
    # Log    Verify Summary Workflow: Total number of stages found on the Summary tab = ${stage_count}. Expected = ${len(${expected_stages})}.

    FOR    ${index}    IN RANGE    ${stage_count}
        ${element}=    Get From List    ${stage_elements}    ${index}
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Verify Summary Workflow: Stage element at index ${index} was expected to be visible but was not. Locator used: '${element}'.

        ${text}=    Get Text    ${element}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Summary Workflow: Could not retrieve text for stage element at index ${index}. Ensure the element is correctly rendered and not empty. Locator: '${element}'.
        Append To List    ${actual_stages}    ${text}
        Log    Verify Summary Workflow: Stage at index ${index} = '${text}'.
    END

    ${lists_equal}=    Run Keyword And Return Status    Lists Should Be Equal    ${expected_stages}    ${actual_stages}
    Run Keyword And Continue On Failure    Should Be True    ${lists_equal}    msg=Verify Summary Workflow: Stage names mismatch. Expected stages: ${expected_stages}. Actual stages found: ${actual_stages}. Verify that all stages are present and in correct order.

    # Verify current extract stage number
    ${processing_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Stage_Processing}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${processing_visible}    msg=Verify Summary Workflow: Processing stage element is not visible. Expected to find current extract stage number element with locator '${Summary_Stage_Processing}' in Summary tab.
    ${actual_stage_text}=    Get Text    ${Summary_Stage_Processing}
    ${actual_stage}=    Convert To Integer    ${actual_stage_text}
    ${expected_stage}=    Convert To Integer    ${Number}
    Run Keyword And Continue On Failure    Should Be Equal    ${expected_stage}    ${actual_stage}    msg=Verify Summary Workflow: Current extract stage number mismatch. Expected stage number = ${expected_stage}, but found = ${actual_stage}. Verify the workflow status is correctly updated.

    # Verify completed stages
    ${actual_completed}=    Evaluate    ${expected_stage} - 1
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Stage_completed}    visible    timeout=${display_timeout}
	Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Summary Workflow: Expected completed stages in Summary tab but none were found. Verify that completed stages are displayed correctly and locator '${Summary_Stage_completed}' is accurate.
    ${completed_elements}=    Get Elements    ${Summary_Stage_completed}
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${completed_elements}    msg=Verify Summary Workflow: Expected completed stages in Summary tab but none were found. Verify that completed stages are displayed correctly and locator '${Summary_Stage_completed}' is accurate.

    ${completed_count}=    Get Length    ${completed_elements}
    ${last_index}=    Evaluate    ${completed_count} - 1
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${actual_completed}    ${last_index}    msg=Verify Summary Workflow: Number of completed stages mismatch. Expected completed stages = ${actual_completed}, but found = ${last_index}. Check if the stages are properly marked completed in the UI.

    FOR    ${index}    IN RANGE    ${completed_count}
        ${completed_stage}=    Get From List    ${actual_stages}    ${index}
        Log    Verify Summary Workflow: Completed stage at index ${index} = '${completed_stage}'. Expected index corresponds to completed stage count.
    END


Verify Advance Stage Disable When Referral Pending
    [Documentation]    This method verifies that the Advance Stage option is disabled when a referral is pending.
    [Arguments]    ${data}
    Switch to Summary
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Stage_Dropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Summary_Stage_Dropdown is not available in Summary page
    # Wait For Elements State    ${Summary_Stage_Dropdown}
    ${ActualStage}    Get Text    ${Summary_Stage_Dropdown}
    Run Keyword And Continue On Failure    Should Be Equal    ${data}    ${ActualStage}
    Click    ${Summary_Stage_Dropdown}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Summary_Adv_Stage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Summary_Adv_Stage is not available in Summary page
    # Wait For Elements State    ${Summary_Adv_Stage}    visible    timeout=${element_timeout}
    ${state}    Get Element States    ${Summary_Adv_Stage}
    Run Keyword And Continue On Failure    Should Contain    ${state}    disabled
    Log    Verified that Advance Stage is disabled when referral is pending.
    Press Keys    ${Summary_Adv_Stage}    Escape

Verify multiple edit functionality in the Summary tab
    [Documentation]    This method verifies that the data can be edited and saved multiple times.
    [Arguments]    ${Data}
    Sleep    10s
    Click Edit Submission
    Sleep    10s
    Switch to Summary
    Enter the Policy Information    ${Data}
    Click Answers Tab
    Save Submission And verify popup
    Click Answers Tab
    Wait For Processing Stage
    Sleep    10s
    Click Edit Submission
    Sleep    10s
    Switch to Summary
    Enter the Policy Information    ${Data}
    Click Answers Tab
    Save Submission And verify popup

# Verify The Account History Current Stage Status

#     [Documentation]    this method verifies the Account history status to be changed to reject/decline according to our command

#     [Arguments]    ${data}
#     Switch to Summary
#     Verify Summary Table Data    ${data['SummaryTableHeader']}    ${data['SummaryTableData']}
#     Click Answers Tab
#     Reject Submission and Verify the Tag name    ${data['FailureReasons']}    ${data['FailureDetails']}    ${data['Action']}
#     ${Status}    Run Keyword And Return Status    Wait For Elements State    ${Number_Task_Side_Menu}    visible    5s
#     Run Keyword And Continue On Failure    Should Not Be True    ${Status}
#     Switch to Summary
#     Verify Summary Table Data    ${data['SummaryTableHeader']}    ${data['SummaryTableData1']}
#     Click Answers Tab
#     Reactive the Rejected Submission

Verify The Account History Current Stage Status
    [Documentation]    Verifies that the Account History status changes to rejected/declined as per the action and validates updates in Summary and Answers tabs.
    [Arguments]    ${data}

    # Switch to Summary and verify initial summary table data
    Click Answers Tab
    Switch to Summary

    Run Keyword And Continue On Failure    Verify Summary Table Data    ${data['SummaryTableHeader']}    ${data['SummaryTableData']}

    # Switch to Answers Tab and reject submission
    ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers tab.

    Run Keyword And Continue On Failure    Reject Submission and Verify the Tag name    ${data['FailureReasons']}    ${data['FailureDetails']}    ${data['Action']}

    # Wait for Number Task in side menu to disappear
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Number_Task_Side_Menu}    visible    5s
    Run Keyword And Continue On Failure    Should Not Be True    ${status}    msg=Number Task Side Menu still visible after rejection.

    # Switch back to Summary and verify updated summary table data
    ${switch_summary}=    Run Keyword And Return Status    Switch to Summary
    Run Keyword And Continue On Failure    Should Be True    ${switch_summary}    msg=Failed to switch back to Summary tab.

    Run Keyword And Continue On Failure    Verify Summary Table Data    ${data['SummaryTableHeader']}    ${data['SummaryTableData1']}

    # Switch to Answers Tab and reactivate rejected submission
    ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
    Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers tab for reactivation.

    Run Keyword And Continue On Failure    Reactive the Rejected Submission



# Verify AttachmentPoint Must Accept Numeric Values
#     [Documentation]    This test verifies that the Attachment Point field accepts only numeric values
#     [Arguments]    ${ExceptedValue}
#     # Switch to Summary
#     Click    ${Attachement_point_btn_loc}
#     Wait For Elements State    ${Attachement_point_field_loc}    visible    5s
    
#     # Verify text is rejected
#     Run Keyword And Continue On Failure    Run Keyword And Expect Error    *    Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentText']}

#     # Verify numeric input is accepted
#     Clear Text    ${Attachement_point_field_loc}
#     Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointValue']}
#     Click    ${permium_Btn_Loc}
#     ${NumericValue}    Get Text    ${Attachement_point_btn_loc}
#     ${CleanField1}    Replace String    ${NumericValue}    $    ${EMPTY}
#     ${CleanField2}    Replace String    ${CleanField1}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField2}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointValue']}

#     # Verify numeric input is accepting maximum digits
#     Click    ${Attachement_point_btn_loc}
#     Clear Text    ${Attachement_point_field_loc}
#     Fill Text    ${Attachement_point_field_loc}    ${ExceptedValue['AttachmentPointMaximum']}
#     Click    ${permium_Btn_Loc}
#     ${MaxValue}    Get Text    ${Attachement_point_btn_loc}
#     ${CleanField3}    Replace String    ${MaxValue}    $    ${EMPTY}
#     ${CleanField4}    Replace String    ${CleanField3}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField4}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointMaximum']}

#     Click Answers Tab
#     Switch to Summary
#     Click    ${Attachement_point_btn_loc}
#     Wait For Elements State    ${Attachement_point_field_loc}    visible    3s
#     ${pointValue}    Get Text    ${Attachement_point_field_loc}
#     ${CleanField5}    Replace String    ${pointValue}    $    ${EMPTY}
#     ${CleanField6}    Replace String    ${CleanField5}    ,    ${EMPTY}
#     ${ActualPointValue}    Strip String    ${CleanField6}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${ActualPointValue}    ${ExceptedValue['AttachmentPointMaximum']}

# Reject Submission via summary tab
#     [Documentation]    Rejects a submission,via inside the summary tab  option.
#     ...
#     ...    *Arguments:*
#     ...    - `${FailureReasons}`: A list of reasons for the rejection.
#     ...    - `${data_details}`: A text description of the rejection details.
#     ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.
#     [Arguments]    ${FailureReasons}    ${data_details}    ${action}
#     Switch to Summary
#     Click    ${Loc_Header_Status}
#     Click    ${Summary_Reject_option}
#     FOR     ${failureReason}    IN    @{FailureReasons}
#     ${reason}    Catenate    SEPARATOR=    ${Summary_ReasonForReject1}    ${failureReason}    ']
#     Check Checkbox    ${reason}
#     END
#     ${other_option}=    Run Keyword And Return Status    List Should Contain Value    ${FailureReasons}    Other
#     IF    '${other_option}' == 'True'
#         ${state}=    Get Element States    ${Summary_Sumbit}
#         Run Keyword And Continue On Failure    Should Contain    ${state}    disabled
#         Type Text    ${Summary_detials}    ${data_details}
 
#      END    
#     IF    '${action}' == 'Cancel'
#         Get Element States    ${SelectReason}    validate    value & enabled    'SelectReason should be enabled.'
#         Click    ${CancelButtonInReject}
#         Verify WorkFlow Options Advance Stage and Reject
#         Get Element States    ${InDraftTag}    validate    value & visible    'InDraftTag should be visible.'
#     ELSE    
#          Get Element States    ${Summary_Sumbit}    validate    value & enabled    'AcceptButton should be enabled.'
#          Click    ${Summary_Sumbit}
#          Sleep    2s    
#          ${text}    Get Text    ${Loc_Header_Status}
#          Run Keyword And Continue On Failure    Should Be Equal    ${text}    Rejected
#     END     
# 
Reject Submission via Summary Tab
    [Documentation]    Rejects a submission via the Summary tab option.
    ...    ${FailureReasons}: List of reasons for rejection.
    ...    ${data_details}: Text description of rejection details.
    ...    ${action}: 'Cancel' to cancel the rejection or any other value to proceed.
    [Arguments]    ${FailureReasons}    ${data_details}    ${action}

    # Switch to Summary tab
    ${switch_summary}=    Run Keyword And Return Status    Switch to Summary
    Run Keyword And Continue On Failure    Should Be True    ${switch_summary}    msg=Failed to switch to Summary tab.

    # Click header status and reject option
    ${click_header}=    Run Keyword And Return Status    Click    ${Loc_Header_Status}
    Run Keyword And Continue On Failure    Should Be True    ${click_header}    msg=Failed to click header status.

    ${click_reject}=    Run Keyword And Return Status    Click    ${Summary_Reject_option}
    Run Keyword And Continue On Failure    Should Be True    ${click_reject}    msg=Failed to click Summary Reject option.

    # Select all failure reasons
    FOR    ${failureReason}    IN    @{FailureReasons}
        ${reason}=    Catenate    SEPARATOR=    ${Summary_ReasonForReject1}    ${failureReason}    ']
        Check Checkbox    ${reason}
    END

    # If 'Other' is selected, enter rejection details
    ${other_option}=    Run Keyword And Return Status    List Should Contain Value    ${FailureReasons}    Other
    IF    '${other_option}' == 'True'
        ${state}=    Get Element States    ${Summary_Sumbit}
        Run Keyword And Continue On Failure    Should Contain    ${state}    disabled    msg=Submit button should be disabled when 'Other' reason is selected without entering details.
        Type Text    ${Summary_detials}    ${data_details}
    END

    # Handle Cancel or Submit action
    IF    '${action}' == 'Cancel'
        Get Element States    ${SelectReason}    validate    value & enabled    'SelectReason should be enabled.'
        ${click_cancel}=    Run Keyword And Return Status    Click    ${CancelButtonInReject}
        Run Keyword And Continue On Failure    Should Be True    ${click_cancel}    msg=Failed to click Cancel in Reject dialog.

        Run Keyword And Continue On Failure    Verify WorkFlow Options Advance Stage and Reject
        Get Element States    ${InDraftTag}    validate    value & visible    'InDraftTag should be visible.'
    ELSE
        Get Element States    ${Summary_Sumbit}    validate    value & enabled    'AcceptButton should be enabled.'
        ${click_submit}=    Run Keyword And Return Status    Click    ${Summary_Sumbit}
        Run Keyword And Continue On Failure    Should Be True    ${click_submit}    msg=Failed to click Submit button in Reject dialog.

        Sleep    2s
        ${text}=    Get Text    ${Loc_Header_Status}
        Run Keyword And Continue On Failure    Should Be Equal    ${text}    Rejected    msg=Header status did not update to 'Rejected' after rejection.
    END
 
 
#  Reactive the Submission via summary tab
#     [Documentation]    Reactive the submission,via inside the summary tab  option.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_details}`: A text description of the rejection details.
#     ...    - `${action}`: Either 'Cancel' to cancel the rejection or any other value to proceed.
#     [Arguments]    ${data_details}    ${action}
#     # Switch to Summary
#     Click    ${Loc_Header_Status}
#     Click    ${Summary_reactive}
#     IF    '${action}' == 'Cancel'
#         Get Element States    ${summary_cancel}    validate    value & enabled    'SelectReason should be enabled.'
#         Click    ${summary_cancel}
#      ELSE
#         Get Element States    ${Summary_accept}    validate    value & enabled    'AcceptButton should be enabled.'
#         Click    ${Summary_accept}
#         Get Element States    ${Summary_reactive_error_msg}    validate    value & visible    'Summary_reactive_error_msg should be enabled.'
#         Click    ${summary_cancel}
#         Click Answers Tab
#         # Type Text    ${Summary_detials}    ${data_details}
#         # Get Element States    ${Summary_accept}    validate    value & enabled    'AcceptButton should be enabled.'
#         # Click    ${Summary_accept}
#         # Sleep    2s
#         # ${text}    Get Text    ${Loc_Header_Status}
#         # Run Keyword And Continue On Failure     Should Be Equal    ${text}    In Draft
#      END  

Reactive the Submission via Summary Tab
    [Documentation]    Reactivates a submission via the Summary tab option.
    ...    ${data_details}: Text description of the rejection details.
    ...    ${action}: 'Cancel' to cancel reactivation or any other value to proceed.
    [Arguments]    ${data_details}    ${action}
    Switch To Summary
    # Switch to Summary and click header status
    ${click_header}=    Run Keyword And Return Status    Click    ${Loc_Header_Status}
    Run Keyword And Continue On Failure    Should Be True    ${click_header}    msg=Failed to click header status.

    # Click reactive option
    ${click_reactive}=    Run Keyword And Return Status    Click    ${Summary_reactive}
    Run Keyword And Continue On Failure    Should Be True    ${click_reactive}    msg=Failed to click Summary Reactive option.

    # Handle Cancel or Accept action
    IF    '${action}' == 'Cancel'
        Get Element States    ${summary_cancel}    validate    value & enabled    'Cancel button should be enabled.'
        ${click_cancel}=    Run Keyword And Return Status    Click    ${summary_cancel}
        Run Keyword And Continue On Failure    Should Be True    ${click_cancel}    msg=Failed to click Cancel button in reactivation dialog.
    ELSE
        Get Element States    ${Summary_accept}    validate    value & enabled    'Accept button should be enabled.'
        ${click_accept}=    Run Keyword And Return Status    Click    ${Summary_accept}
        Run Keyword And Continue On Failure    Should Be True    ${click_accept}    msg=Failed to click Accept button in reactivation dialog.

        # Handle reactive error message if it appears
        Get Element States    ${Summary_reactive_error_msg}    validate    value & visible    'Reactive error message should be visible if reactivation fails.'
        ${click_error_cancel}=    Run Keyword And Return Status    Click    ${summary_cancel}
        Run Keyword And Continue On Failure    Should Be True    ${click_error_cancel}    msg=Failed to click Cancel after reactive error.

        # Navigate back to Answers tab
        ${click_answers}=    Run Keyword And Return Status    Click Answers Tab
        Run Keyword And Continue On Failure    Should Be True    ${click_answers}    msg=Failed to click Answers tab after reactivation.
    END

