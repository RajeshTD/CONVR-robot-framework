*** Settings ***
Resource     ../../utils/common_keywords.robot
Variables     ../locators/Forms_locator.py
Library    DateTime
 
*** Variables ***
${AttachmentPath}             ${CURDIR}/../../uploads/
 
*** Keywords ***
# Navigate to Form
#     ${Status}    Run Keyword And Return Status    Get Element States    ${FormsPage}    Validate    value & visible
#     IF    ${Status}
#         Log    Forms page already opened
#     ELSE
#         # Wait For Elements State    ${FormsMenu}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    FormsMenu    ${FormsMenu}    visible
#         Click    ${FormsMenu}
#     END
#     ${Status}    Run Keyword And Return Status    Get Element States    ${RegenerateButton}    Validate    value & visible
#     # Run Keyword And Continue On Failure    Should Be Equal    '${Status}'    'False'
#     IF    ${Status}==True
#         Run Keyword And Continue On Failure    Fail    Regenerate popup occurred while Clicking the Forms tab!
#         Click    ${RegenerateButton}
#     END
Navigate To Form
    [Documentation]    Navigates to the 'Forms' page for the current submission and ensures it opens without triggering the Regenerate popup.

    ${forms_visible}=    Run Keyword And Return Status    Wait For Elements State    ${FormsPage}    visible    timeout=${display_timeout}
    IF    ${forms_visible}
        Log    Navigate To Form: Forms page is already opened.
    ELSE
        ${menu_visible}=    Run Keyword And Return Status    Wait For Elements State    ${FormsMenu}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${menu_visible}    msg=Navigate To Form: 'Forms' menu item is not visible in the side menu. Cannot proceed to click it.

        ${menu_clicked}=    Run Keyword And Return Status    Click    ${FormsMenu}
        Run Keyword And Continue On Failure    Should Be True    ${menu_clicked}    msg=Navigate To Form: Failed to click the 'Forms' menu item. Ensure it is enabled and clickable.
    END

    ${regenerate_status}=    Run Keyword And Return Status    Wait For Elements State    ${RegenerateButton}    visible    timeout=${display_timeout}
    IF    ${regenerate_status}
        Run Keyword And Continue On Failure    Fail    Navigate To Form: Regenerate popup appeared while opening the Forms tab!
        Click    ${RegenerateButton}
    END


# Verify Form Summary Headers
#     [Arguments]    ${expectedFormHeader}
#     ${formHeaderValues}    Get Text    ${FormSummaryHeader}
#     ${Text}    Strip String    ${formHeaderValues}
#     FOR    ${FormHeader}    IN    @{expectedFormHeader['expectedFormHeaderValues']}
#         Run Keyword And Continue On Failure    Should Contain    ${Text}    ${FormHeader}
#     END

Verify Form Summary Headers
    [Documentation]    Verifies that the form summary headers match the expected values
    [Arguments]    ${expectedFormHeader}

    # Get all form header values and clean them
    ${formHeaderValues}=    Get Text    ${FormSummaryHeader}
    ${Text}=    Strip String    ${formHeaderValues}

    # Verify each expected header is present
    FOR    ${FormHeader}    IN    @{expectedFormHeader['expectedFormHeaderValues']}
        Run Keyword And Continue On Failure    Should Contain    ${Text}    ${FormHeader}    msg=Expected header '${FormHeader}' not found in form summary.
    END

   
Verify Form Summary Details
    [Arguments]    ${expectedFormDetails}
    ${elements}=    Get Elements    ${FormSummaryDetails}
    ${ActualList}    Create List
    FOR    ${elements}    IN    @{elements}
    ${elementText}    Get Text    ${elements}
    ${actualelementText}    Strip String    ${elementText}
    Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedFormDetails['expectedFormDetailsValues']}   ${ActualList}
# Switch to Policy Instruction Form
#     # Wait For Elements State    ${FormsPIFOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsPIFOption    ${FormsPIFOption}    visible
#     Click    ${FormsPIFOption}

Switch to Policy Instruction Form
    [Documentation]    Switches to the Policy Instruction Form (PIF) in the forms menu.

    # Wait for the form option to be visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    FormsPIFOption    ${FormsPIFOption}    visible    FormsPIFOption is not visible in the Forms menu
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsPIFOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'FormsPIFOption is not visible in the Forms menu'
    # Click the option and capture click status
    ${clicked}=    Run Keyword And Return Status    Click    ${FormsPIFOption}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on FormsPIFOption

    
# Verify Form Policy Instruction Form General Details
#     [Arguments]    ${expectedPIFGeneralDetails}
#     # Wait For Elements State    ${FormsPIFOption}    visible
#     # Click    ${FormsPIFOption}
#     ${elements}=    Get Elements    ${PIFGeneralLOBData}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure     Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralLOB']}    ${ActualList}
#     ${elements}=    Get Elements    ${PIFGeneralDates}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Attribute    ${elements}    value
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure     Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralDateValues']}    ${ActualList}
#     Fill Text    ${PIFPolicyInputField}    ${expectedPIFGeneralDetails['PIFPolicyInput']}
#     # Wait For Elements State    ${PIFNeededByDateField}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFNeededByDateField    ${PIFNeededByDateField}    visible
#     Click    ${PIFNeededByDateField}
#     ${day}    Get Current Day Number
#     ${actualCurrentDate}    Convert To Integer    ${day}
#     ${CurrentDateInput}    Convert To Integer    ${expectedPIFGeneralDetails['PIFPolicyDateNumberInput']}
#     ${sum}=    Evaluate    ${actualCurrentDate} + ${CurrentDateInput}
#     ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${sum}    ']
#     # Wait For Elements State    ${currentdate}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    currentdate    ${currentdate}    visible
#     Click    ${currentdate}
#     # Wait For Elements State    ${PIFNeededByDateField}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFNeededByDateField    ${PIFNeededByDateField}    visible
#     Click    ${PIFNeededByDateField}

# Verify Form Policy Instruction Form General Details
#     [Documentation]    Verifies the general details in the Policy Instruction Form (PIF) and fills necessary fields.
#     [Arguments]    ${expectedPIFGeneralDetails}

#     # Verify LOB Data
#     ${elements}=    Get Elements    ${PIFGeneralLOBData}
#     ${ActualList}=    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}=    Get Text    ${element}
#         ${actualelementText}=    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralLOB']}    ${ActualList}

#     # Verify Dates
#     ${elements}=    Get Elements    ${PIFGeneralDates}
#     ${ActualList}=    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}=    Get Attribute    ${element}    value
#         ${actualelementText}=    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralDateValues']}    ${ActualList}

#     # Fill Policy Input
#     Fill Text    ${PIFPolicyInputField}    ${expectedPIFGeneralDetails['PIFPolicyInput']}

#     # Select Needed By Date
#     # Run Keyword And Continue On Failure    Wait For Element With Message    PIFNeededByDateField    ${PIFNeededByDateField}    visible
#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFNeededByDateField}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    'PIFNeededByDateField is not visible to proceed'
#     ${clicked}=    Run Keyword And Return Status    Click    ${PIFNeededByDateField}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click PIFNeededByDateField

#     ${day}=    Get Current Day Number
#     ${actualCurrentDate}=    Convert To Integer    ${day}
#     ${CurrentDateInput}=    Convert To Integer    ${expectedPIFGeneralDetails['PIFPolicyDateNumberInput']}
#     ${sum}=    Evaluate    ${actualCurrentDate} + ${CurrentDateInput}
#     ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${sum}    '])[1]
#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${currentdate}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    'currentdate is not visible to select the needed by date'

#     ${clicked}=    Run Keyword And Return Status    Click    ${currentdate}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to select the needed by date'

#     # Close date picker
#     ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFNeededByDateField}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    'PIFNeededByDateField is not visible to close date picker'

#     ${clicked}=    Run Keyword And Return Status    Click    ${PIFNeededByDateField}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to close date picker'
#     # Run Keyword And Continue On Failure    Wait For Element With Message    currentdate    ${currentdate}    visible
    # ${clicked}=    Run Keyword And Return Status    Click    ${currentdate}
    # Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select the needed by date

    # # Close date picker
    # Run Keyword And Continue On Failure    Wait For Element With Message    PIFNeededByDateField    ${PIFNeededByDateField}    visible
    # ${clicked}=    Run Keyword And Return Status    Click    ${PIFNeededByDateField}
    # Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to close date picker
Verify Form Policy Instruction Form General Details
    [Documentation]    Verifies the general details in the Policy Instruction Form (PIF) and fills necessary fields.
    [Arguments]    ${expectedPIFGeneralDetails}

    ${elements}=    Get Elements    ${PIFGeneralLOBData}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralLOB']}    ${ActualList}    msg=LOB Data mismatch – Expected: ${expectedPIFGeneralDetails['expectedPIFGeneralLOB']} | Actual: ${ActualList}

    ${elements}=    Get Elements    ${PIFGeneralDates}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Attribute    ${element}    value
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGeneralDetails['expectedPIFGeneralDateValues']}    ${ActualList}    msg=Date field values mismatch – Expected: ${expectedPIFGeneralDetails['expectedPIFGeneralDateValues']} | Actual: ${ActualList}

    ${status}=    Run Keyword And Return Status    Fill Text    ${PIFPolicyInputField}    ${expectedPIFGeneralDetails['PIFPolicyInput']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to enter policy input value in field ${PIFPolicyInputField}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFNeededByDateField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg='Needed By Date' field not visible after waiting ${element_timeout}s

    ${clicked}=    Run Keyword And Return Status    Click    ${PIFNeededByDateField}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Needed By Date' field to open date picker

    ${day}=    Get Current Day Number
    ${actualCurrentDate}=    Convert To Integer    ${day}
    ${CurrentDateInput}=    Convert To Integer    ${expectedPIFGeneralDetails['PIFPolicyDateNumberInput']}
    ${sum}=    Evaluate    ${actualCurrentDate} + ${CurrentDateInput}
    ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${sum}    '])[1]

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${currentdate}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Expected date option for Needed By Date (${sum}) not visible within ${element_timeout}s

    ${clicked}=    Run Keyword And Return Status    Click    ${currentdate}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select the calculated Needed By Date (${sum})

    # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFNeededByDateField}    visible    timeout=${element_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    msg='Needed By Date' field not visible again to close date picker

    # ${clicked}=    Run Keyword And Return Status    Click    ${PIFNeededByDateField}
    # Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to close date picker by clicking 'Needed By Date' field again

 
 
# Verify Form Policy Instruction Form Indured Tab Details
#     [Arguments]    ${expectedPIFInsuredDetails}
#     ${YearValues}    Get Attribute    ${PIFInsuredYearEstablished}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredYearEstablishedValue']}    ${YearValues}
#     ${RevenueValue}    Get Attribute    ${PIFInsuredRevenueEstimate}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredRevenueEstimateValue']}    ${RevenueValue}
#     # ${YearsInBusinessValue}    Get Attribute    ${PIFInsuredYearsInBusiness}    value
#     # Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredYearsInBusinessValue']}    ${YearsInBusinessValue}
#     Run Keyword And Continue On Failure    Verify The Year Of Business
#     # Fill Text    ${PIFInsuredYearsInBusiness}    ${expectedPIFInsuredDetails['PIFInsuredYearsInBusinessValue']}
#     # Fill Text    ${PIFInsuredOperationDesc}    ${expectedPIFInsuredDetails['PIFInsuredOperationDescValue']}
#     ${DescValue}    Get Text    ${PIFInsuredOperationDesc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredOperationDescValue']}    ${DescValue}
#     Fill Text    ${PIFInsuredDomiciledState}    ${expectedPIFInsuredDetails['PIFInsuredYearsInBusinessValue']}
#     Fill Text    ${PIFInsuredOutSideTheUS}    ${expectedPIFInsuredDetails['PIFInsuredOutsideYheUSValue']}


# Verify Form Policy Instruction Form Indured Tab Details
#     [Documentation]    Verifies the Insured tab details in the Policy Instruction Form (PIF) and fills necessary fields.
#     [Arguments]    ${expectedPIFInsuredDetails}

#     # Verify Year Established
#     ${YearValues}=    Get Attribute    ${PIFInsuredYearEstablished}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredYearEstablishedValue']}    ${YearValues}

#     # Verify Revenue Estimate
#     ${RevenueValue}=    Get Attribute    ${PIFInsuredRevenueEstimate}    value
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredRevenueEstimateValue']}    ${RevenueValue}

#     # Verify Years In Business (via custom keyword)
#     Run Keyword And Continue On Failure    Verify The Year Of Business

#     # Verify Operation Description
#     ${DescValue}=    Get Text    ${PIFInsuredOperationDesc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredOperationDescValue']}    ${DescValue}

#     # Fill Domiciled State
#     ${status}=    Run Keyword And Return Status    Fill Text    ${PIFInsuredDomiciledState}    ${expectedPIFInsuredDetails['PIFInsuredYearsInBusinessValue']}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Domiciled State

#     # Fill Outside The US
#     ${status}=    Run Keyword And Return Status    Fill Text    ${PIFInsuredOutSideTheUS}    ${expectedPIFInsuredDetails['PIFInsuredOutsideYheUSValue']}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Outside The US
Verify Form Policy Instruction Form Insured Tab Details
    [Documentation]    Verifies the Insured tab details in the Policy Instruction Form (PIF) and fills necessary fields.
    [Arguments]    ${expectedPIFInsuredDetails}

    ${YearValues}=    Get Attribute    ${PIFInsuredYearEstablished}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredYearEstablishedValue']}    ${YearValues}    msg=Year Established value mismatch – Expected: ${expectedPIFInsuredDetails['PIFInsuredYearEstablishedValue']} | Actual: ${YearValues}

    ${RevenueValue}=    Get Attribute    ${PIFInsuredRevenueEstimate}    value
    Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredRevenueEstimateValue']}    ${RevenueValue}    msg=Revenue Estimate value mismatch – Expected: ${expectedPIFInsuredDetails['PIFInsuredRevenueEstimateValue']} | Actual: ${RevenueValue}

    ${status}=    Run Keyword And Return Status    Verify The Year Of Business
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to verify the Years in Business field

    # ${DescValue}=    Get Text    ${PIFInsuredOperationDesc}
    # Run Keyword And Continue On Failure    Should Be Equal    ${expectedPIFInsuredDetails['PIFInsuredOperationDescValue']}    ${DescValue}    msg=Operation Description mismatch – Expected: ${expectedPIFInsuredDetails['PIFInsuredOperationDescValue']} | Actual: ${DescValue}

    ${status}=    Run Keyword And Return Status    Fill Text    ${PIFInsuredDomiciledState}    ${expectedPIFInsuredDetails['PIFInsuredYearsInBusinessValue']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill value for Domiciled State field

    ${status}=    Run Keyword And Return Status    Fill Text    ${PIFInsuredOutSideTheUS}    ${expectedPIFInsuredDetails['PIFInsuredOutsideYheUSValue']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill value for Outside The US field


# Verify The Year Of Business
#     [Documentation]    This keyword verifies the year of business in the Forms tab.
#     ${YearValues}    Get Attribute    ${PIFInsuredYearEstablished}    value
#     ${current_year}    Get Current Date    result_format=%Y
#     ${Excepted_yearof_business}    Evaluate    int(${current_year}) - int(${YearValues})
#     ${Actual_yearof_business}    Get Attribute    ${PIFInsuredYearsInBusiness}    value
#     ${Actual_yearof_business}    Convert To Integer    ${Actual_yearof_business}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Actual_yearof_business}    ${Excepted_yearof_business}
    
Verify The Year Of Business
    [Documentation]    Verifies the number of years in business based on the Year Established in the Forms tab.

    # Get Year Established
    ${YearValues}=    Get Attribute    ${PIFInsuredYearEstablished}    value
    ${YearValues}=    Convert To Integer    ${YearValues}

    # Get Current Year
    ${current_year}=    Get Current Date    result_format=%Y
    ${current_year}=    Convert To Integer    ${current_year}

    # Calculate Expected Years in Business
    ${Expected_years_in_business}=    Evaluate    ${current_year} - ${YearValues}

    # Get Actual Years in Business
    ${Actual_years_in_business}=    Get Attribute    ${PIFInsuredYearsInBusiness}    value
    ${Actual_years_in_business}=    Convert To Integer    ${Actual_years_in_business}

    # Compare Actual vs Expected with custom message
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_years_in_business}    ${Expected_years_in_business}    msg=Expected years in business to be ${Expected_years_in_business}, but found ${Actual_years_in_business}.
    
# Verify Form Policy Instruction Form Producer Details
#     [Arguments]    ${expectedPIFGProducerDetailsInput}
#     ${elements}=    Get Elements    ${PIFProducerData}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#     ${elementText}    Get Attribute    ${element}    value
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGProducerDetailsInput['expectedPIFProducerDetails']}    ${ActualList}
Verify Form Policy Instruction Form Producer Details
    [Arguments]    ${expectedPIFGProducerDetailsInput}

    ${elements}=    Get Elements    ${PIFProducerData}
    ${ActualList}=    Create List

    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Attribute    ${element}    value
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFGProducerDetailsInput['expectedPIFProducerDetails']}    ${ActualList}    msg=Producer Details do not match expected values. Expected: ${expectedPIFGProducerDetailsInput['expectedPIFProducerDetails']}, Actual: ${ActualList}
 
# Verify Form Policy Instruction Form Processing Details
#     [Arguments]    ${expectedPIFProcessingrDetails}
#     ${elements}=    Get Elements    ${PIFProcessingExpected}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#     ${elementText}    Get Text    ${element}
#     ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${elementText}    \n
#         IF    ${hasNewLine}
#             @{splitValue}=    Split String    ${elementText}    \n
#             ${split}=    Strip String    ${splitValue}[1]
#             Append To List    ${ActualList}    ${split}
#         ELSE
#             ${trimData}=    Strip String    ${elementText}
#             Append To List    ${ActualList}    ${trimData}
#         END
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFProcessingrDetails['ProcessingDetails']['VerificationValues']}    ${ActualList}
#     Click    ${PIFProcessingUWOffice}
#     ${ProcessingUWOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingUWOfficeValue']}    ']
#     # Wait For Elements State    ${ProcessingUWOffice}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingUWOffice    ${ProcessingUWOffice}    visible
#     Click    ${ProcessingUWOffice}
#     Click    ${PIFProcessingRepOffice}
#     ${ProcessingRepOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingRepOfficeValue']}     ']
#     # Wait For Elements State    ${ProcessingRepOffice}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingRepOffice    ${ProcessingRepOffice}    visible
#     Click    ${ProcessingRepOffice}
 
#     # Click    ${PIFProcessingChannel}
#     # ${ProcessingChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingChannelValue']}     ']
#     # Wait For Elements State    ${ProcessingChannel}    visible
#     # Click    ${ProcessingChannel}
 
#     #New Modified----Channel steps
#     ${ChannelHeader}    Get Text    ${PIFProcessingChannel}
 
#     IF    '${ChannelHeader.strip()}' == ''
#     Click    ${PIFProcessingChannel}
#     ${ProcessingChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingChannelValue']}     ']
#     # Wait For Elements State    ${ProcessingChannel}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingChannel    ${ProcessingChannel}    visible
#     Click    ${ProcessingChannel}
#     ELSE
#     Log    Continue the steps
#     END
 
 
 
#     # Click    ${PIFProcessingSubChannel}
#     # ${ProcessingSubChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingSubChannelValue']}     ']
#     # Wait For Elements State    ${ProcessingSubChannel}    visible
#     # Click    ${ProcessingSubChannel}
 
#     #New Modified----Sub Channel
#     ${SubChannelHeader}    Get Text    ${PIFProcessingSubChannel}
#     IF    '${SubChannelHeader}' == 'Select a sub channel'
#     Click    ${PIFProcessingSubChannel}
#     ${ProcessingSubChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingSubChannelValue']}     ']
#     # Wait For Elements State    ${ProcessingSubChannel}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingSubChannel    ${ProcessingSubChannel}    visible
#     Click    ${ProcessingSubChannel}    
#     END
#     IF    '${SubChannelHeader}' != 'Select a sub channel'
#      Log    Continue the steps
#      END

# Verify Form Policy Instruction Form Processing Details
#     [Arguments]    ${expectedPIFProcessingrDetails}

#     # Verify Processing Details list
#     ${elements}=    Get Elements    ${PIFProcessingExpected}
#     ${ActualList}=    Create List

#     FOR    ${element}    IN    @{elements}
#         ${elementText}=    Get Text    ${element}
#         ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${elementText}    \n
#         IF    ${hasNewLine}
#             @{splitValue}=    Split String    ${elementText}    \n
#             ${split}=    Strip String    ${splitValue}[1]
#             Append To List    ${ActualList}    ${split}
#         ELSE
#             ${trimData}=    Strip String    ${elementText}
#             Append To List    ${ActualList}    ${trimData}
#         END
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFProcessingrDetails['ProcessingDetails']['VerificationValues']}    ${ActualList}    msg=Processing Details values do not match expected list.

#     # Select Underwriting Office
#     Click    ${PIFProcessingUWOffice}
#     ${ProcessingUWOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingUWOfficeValue']}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingUWOffice    ${ProcessingUWOffice}    visible
#     Click    ${ProcessingUWOffice}

#     # Select Representative Office
#     Click    ${PIFProcessingRepOffice}
#     ${ProcessingRepOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingRepOfficeValue']}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingRepOffice    ${ProcessingRepOffice}    visible
#     Click    ${ProcessingRepOffice}

#     # Select Channel if empty
#     ${ChannelHeader}=    Get Text    ${PIFProcessingChannel}
#     IF    '${ChannelHeader.strip()}' == ''
#         Click    ${PIFProcessingChannel}
#         ${ProcessingChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingChannelValue']}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingChannel    ${ProcessingChannel}    visible
#         Click    ${ProcessingChannel}
#     ELSE
#         Log    Channel already selected, continuing...
#     END

#     # Select Sub-Channel if not already selected
#     ${SubChannelHeader}=    Get Text    ${PIFProcessingSubChannel}
#     IF    '${SubChannelHeader}' == 'Select a sub channel'
#         Click    ${PIFProcessingSubChannel}
#         ${ProcessingSubChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingSubChannelValue']}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    ProcessingSubChannel    ${ProcessingSubChannel}    visible
#         Click    ${ProcessingSubChannel}
#     ELSE
#         Log    Sub-Channel already selected, continuing...
#     END
Verify Form Policy Instruction Form Processing Details
    [Arguments]    ${expectedPIFProcessingrDetails}

    # ----- Verify Processing Details list -----
    ${elements}=    Get Elements    ${PIFProcessingExpected}
    ${ActualList}=    Create List

    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${elementText}    \n
        IF    ${hasNewLine}
            @{splitValue}=    Split String    ${elementText}    \n
            ${split}=    Strip String    ${splitValue}[1]
            Append To List    ${ActualList}    ${split}
        ELSE
            ${trimData}=    Strip String    ${elementText}
            Append To List    ${ActualList}    ${trimData}
        END
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedPIFProcessingrDetails['ProcessingDetails']['VerificationValues']}    ${ActualList}    msg=Processing Details values do not match expected list.

    # ----- Select Underwriting Office -----
    ${clicked}=    Run Keyword And Return Status    Click    ${PIFProcessingUWOffice}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Underwriting Office dropdown'

    ${ProcessingUWOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingUWOfficeValue']}    ']
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingUWOffice}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Underwriting Office option not visible to select'

    ${clicked}=    Run Keyword And Return Status    Click    ${ProcessingUWOffice}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to select Underwriting Office'

    # ----- Select Representative Office -----
    ${clicked}=    Run Keyword And Return Status    Click    ${PIFProcessingRepOffice}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Representative Office dropdown'

    ${ProcessingRepOffice}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingRepOfficeValue']}    ']
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingRepOffice}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Representative Office option not visible to select'

    ${clicked}=    Run Keyword And Return Status    Click    ${ProcessingRepOffice}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to select Representative Office'

    # ----- Select Channel if empty -----
    ${ChannelHeader}=    Get Text    ${PIFProcessingChannel}
    IF    '${ChannelHeader.strip()}' == ''
        ${clicked}=    Run Keyword And Return Status    Click    ${PIFProcessingChannel}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Channel dropdown'

        ${ProcessingChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingChannelValue']}    ']
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingChannel}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Channel option not visible to select'

        ${clicked}=    Run Keyword And Return Status    Click    ${ProcessingChannel}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to select Channel option'
    ELSE
        Log    Channel already selected, continuing...
    END

    # ----- Select Sub-Channel if not already selected -----
    ${SubChannelHeader}=    Get Text    ${PIFProcessingSubChannel}
    IF    '${SubChannelHeader}' == 'Select a sub channel'
        ${clicked}=    Run Keyword And Return Status    Click    ${PIFProcessingSubChannel}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Sub-Channel dropdown'

        ${ProcessingSubChannel}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFProcessingrDetails['ProcessingDetails']['PIFProcessingSubChannelValue']}    ']
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ProcessingSubChannel}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Sub-Channel option not visible to select'

        ${clicked}=    Run Keyword And Return Status    Click    ${ProcessingSubChannel}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to select Sub-Channel option'
    ELSE
        Log    Sub-Channel already selected, continuing...
    END


 
# Verify Form Policy Instruction Form Underwritting Details
#    [Arguments]    ${expectedPIFUnderwrittingDetails}
#     # Wait For Elements State    ${PIFUWWrittingCompany}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFUWWrittingCompany    ${PIFUWWrittingCompany}    visible
#     Click    ${PIFUWWrittingCompany}
#     ${UWWrittingCompany}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['WrittingCompanyName']}     ']
#     # Wait For Elements State    ${UWWrittingCompany}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    UWWrittingCompany    ${UWWrittingCompany}    visible
#     Click    ${UWWrittingCompany}
#     ${AuditableRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['AuditabilityValue']}     ${PIFUWRadioButton2}
#     # Wait For Elements State    ${AuditableRadioButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AuditableRadioButton    ${AuditableRadioButton}    visible
#     Click    ${AuditableRadioButton}
#     ${BillibgTypeRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['BillingTypeValue']}     ${PIFUWRadioButton2}
#     # Wait For Elements State    ${BillibgTypeRadioButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    BillibgTypeRadioButton    ${BillibgTypeRadioButton}    visible
#     Click    ${BillibgTypeRadioButton}
 
# Verify Form Policy Instruction Form Underwritting Details
#     [Arguments]    ${expectedPIFUnderwrittingDetails}

#     # Wait for the Underwriting Company field
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFUWWrittingCompany    ${PIFUWWrittingCompany}    visible

#     # Click Underwriting Company
#     ${status}=    Run Keyword And Return Status    Click    ${PIFUWWrittingCompany}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click PIFUWWrittingCompany

#     # Select expected Underwriting Company option
#     ${UWWrittingCompany}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['WrittingCompanyName']}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    UWWrittingCompany    ${UWWrittingCompany}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${UWWrittingCompany} 
#     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click expected Underwriting Company option in forms tab

#     # Click Auditability radio button
#     ${AuditableRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['AuditabilityValue']}    ${PIFUWRadioButton2}
#     Run Keyword And Continue On Failure    Wait For Element With Message    AuditableRadioButton    ${AuditableRadioButton}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${AuditableRadioButton}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Auditability radio button in forms tab

#     # Click Billing Type radio button
#     ${BillingTypeRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['BillingTypeValue']}    ${PIFUWRadioButton2}
#     Run Keyword And Continue On Failure    Wait For Element With Message    BillingTypeRadioButton    ${BillingTypeRadioButton}    visible
#     ${status}=    Run Keyword And Return Status    Click    ${BillingTypeRadioButton}
#     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Billing Type radio button in forms tab
Verify Form Policy Instruction Form Underwritting Details
    [Arguments]    ${expectedPIFUnderwrittingDetails}

    # ----- Wait for the Underwriting Company field -----
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFUWWrittingCompany}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'PIFUWWrittingCompany is not visible to proceed'

    # ----- Click Underwriting Company -----
    ${status}=    Run Keyword And Return Status    Click    ${PIFUWWrittingCompany}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click PIFUWWrittingCompany dropdown'

    # ----- Select expected Underwriting Company option -----
    ${UWWrittingCompany}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['WrittingCompanyName']}    ']
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${UWWrittingCompany}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Underwriting Company option not visible to select'

    ${status}=    Run Keyword And Return Status    Click    ${UWWrittingCompany}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to select expected Underwriting Company option in Forms tab'

    # ----- Click Auditability radio button -----
    ${AuditableRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['AuditabilityValue']}    ${PIFUWRadioButton2}
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AuditableRadioButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Auditability radio button not visible to proceed'

    ${status}=    Run Keyword And Return Status    Click    ${AuditableRadioButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Auditability radio button in Forms tab'

    # ----- Click Billing Type radio button -----
    ${BillingTypeRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${expectedPIFUnderwrittingDetails['UnderWrittingDetails']['BillingTypeValue']}    ${PIFUWRadioButton2}
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${BillingTypeRadioButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Billing Type radio button not visible to proceed'

    ${status}=    Run Keyword And Return Status    Click    ${BillingTypeRadioButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Billing Type radio button in Forms tab'

# Verify Form Policy Instruction Form Hazard Grade Details
#    [Arguments]    ${HazardGradeDetails}

#     Fill Text    ${PIFHGSICCode}    ${HazardGradeDetails['HazardGradeDetails']['PIFHGSICCode']}
#     Fill Text    ${PIFHGNAICSCode}    ${HazardGradeDetails['HazardGradeDetails']['PIFHGNAICSCode']}
#     Fill Text    ${PIFHGProperty}    ${HazardGradeDetails['HazardGradeDetails']['Property']}
#     Fill Text    ${PIFHGPropertyNetCompanyLimit}    ${HazardGradeDetails['HazardGradeDetails']['PropertyNetCompanyLimit']}
#     FOR    ${Endorsement}    IN    @{HazardGradeDetails['HazardGradeDetails']['EnhancementEndorsement']}
#          ${EndorsementCheckbox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Endorsement}     ${PIFUWRadioButton2}
#         # Wait For Elements State    ${EndorsementCheckbox}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    EndorsementCheckbox    ${EndorsementCheckbox}    visible
#         Uncheck Checkbox    ${EndorsementCheckbox}
#         Check Checkbox    ${EndorsementCheckbox}
#         #Click    ${EndorsementCheckbox}      
#     END
#     FOR    ${Machinery}    IN    @{HazardGradeDetails['HazardGradeDetails']['BoilerMachinery']}
#          ${MachineryCheckBox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Machinery}     ${PIFUWRadioButton2}
#         # Wait For Elements State    ${MachineryCheckBox}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    MachineryCheckBox    ${MachineryCheckBox}    visible
#         #Click    ${MachineryCheckBox}
#         Uncheck Checkbox    ${MachineryCheckBox}
#         Check Checkbox    ${MachineryCheckBox}      
#     END

Verify Form Policy Instruction Form Hazard Grade Details
    [Arguments]    ${HazardGradeDetails}

    Fill Text    ${PIFHGSICCode}    ${HazardGradeDetails['HazardGradeDetails']['PIFHGSICCode']}
    Fill Text    ${PIFHGNAICSCode}    ${HazardGradeDetails['HazardGradeDetails']['PIFHGNAICSCode']}
    Fill Text    ${PIFHGProperty}    ${HazardGradeDetails['HazardGradeDetails']['Property']}
    Fill Text    ${PIFHGPropertyNetCompanyLimit}    ${HazardGradeDetails['HazardGradeDetails']['PropertyNetCompanyLimit']}

    FOR    ${Endorsement}    IN    @{HazardGradeDetails['HazardGradeDetails']['EnhancementEndorsement']}
        ${EndorsementCheckbox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Endorsement}    ${PIFUWRadioButton2}
        # Run Keyword And Continue On Failure    Wait For Element With Message    EndorsementCheckbox    ${EndorsementCheckbox}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${EndorsementCheckbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'EndorsementCheckbox is not visible to proceed'
        ${status}=    Run Keyword And Return Status    Uncheck Checkbox    ${EndorsementCheckbox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to uncheck Endorsement '${Endorsement}' in forms tab
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${EndorsementCheckbox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to check Endorsement '${Endorsement}' in forms tab
    END

    FOR    ${Machinery}    IN    @{HazardGradeDetails['HazardGradeDetails']['BoilerMachinery']}
        ${MachineryCheckBox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Machinery}    ${PIFUWRadioButton2}
        # Run Keyword And Continue On Failure    Wait For Element With Message    MachineryCheckBox    ${MachineryCheckBox}    visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${MachineryCheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'MachineryCheckBox is not visible to proceed'
        ${status}=    Run Keyword And Return Status    Uncheck Checkbox    ${MachineryCheckBox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to uncheck Machinery '${Machinery}' in forms tab
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${MachineryCheckBox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to check Machinery '${Machinery}' in forms tab
    END

 
Verify Form Policy Instruction Form Reinsurance Details
   [Arguments]    ${ReinsuranceDetailsData}
#    Scroll To Element    ${PIFReinsuranceCdedPrescentage}
#    Wait For Elements State    ${PIFReinsuranceCdedPrescentage}
   Fill Text    ${PIFReinsuranceCdedPrescentage}    ${ReinsuranceDetailsData['ReinsuranceDetails']['cedePrecentage']}
   Press Keys    ${PIFReinsuranceCdedPrescentage}    Escape
# Verify Form Policy Instruction Form Instruction Details
#    [Arguments]    ${ReinsuranceDetailsData}
#     # Wait For Elements State    ${PIFInstructionDate}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFInstructionDate    ${PIFInstructionDate}    visible
#     Click    ${PIFInstructionDate}
#     ${day}    Get Current Day Number
#     ${actualCurrentDate}    Convert To Integer    ${day}
#     ${CurrentDateInput}    Convert To Integer    ${ReinsuranceDetailsData['PIFPolicyDateNumberInput']}
#     ${sum}=    Evaluate    ${actualCurrentDate} + ${CurrentDateInput}
#     ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${sum}    ']
#     # Wait For Elements State    ${currentdate}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    currentdate    ${currentdate}    visible
#     Click    ${currentdate}
#     Fill Text    ${PIFInstructionsAdditionalInformation}    ${ReinsuranceDetailsData['InstructionDetails']['Ascci_AdditionalInformation']}

Verify Form Policy Instruction Form Instruction Details
    [Arguments]    ${ReinsuranceDetailsData}

    # Wait for Instruction Date field to be visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    PIFInstructionDate    ${PIFInstructionDate}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFInstructionDate}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'PIFInstructionDate is not visible to proceed'
    # Click Instruction Date field
    ${status}=    Run Keyword And Return Status    Click    ${PIFInstructionDate}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Instruction Date field in forms tab

    # Calculate the target date
    ${day}=    Get Current Day Number
    ${actualCurrentDate}=    Convert To Integer    ${day}
    ${CurrentDateInput}=    Convert To Integer    ${ReinsuranceDetailsData['PIFPolicyDateNumberInput']}
    ${sum}=    Evaluate    ${actualCurrentDate} + ${CurrentDateInput}
    ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${sum}    '])[1]

    # Wait for the target date element to be visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    currentdate    ${currentdate}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${currentdate}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'currentdate is not visible to proceed'
    # Click the target date
    ${status}=    Run Keyword And Return Status    Click    ${currentdate}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to select date '${sum}'

    # Fill Additional Information field
    ${status}=    Run Keyword And Return Status    Fill Text    ${PIFInstructionsAdditionalInformation}    ${ReinsuranceDetailsData['InstructionDetails']['Ascci_AdditionalInformation']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Additional Information field in forms tab

# Switch To NY FreeTrade Zone
#     # Wait For Elements State    ${FormsNYFTZOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYFTZOption    ${FormsNYFTZOption}    visible
#     Click    ${FormsNYFTZOption}

Switch To NY FreeTrade Zone
    # Wait for NY FreeTrade Zone option to be visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYFTZOption    ${FormsNYFTZOption}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsNYFTZOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'FormsNYFTZOption is not visible to proceed'
    # Click the NY FreeTrade Zone option
    ${status}=    Run Keyword And Return Status    Click    ${FormsNYFTZOption}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on NY FreeTrade Zone option in forms tab

# Verify Form NY Free Trade Zone Instructions
#     [Arguments]    ${ExpectedInstructions}
#     Wait For Elements State    ${FormsNYFTZOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYFTZOption    ${FormsNYFTZOption}    visible
#     # Click    ${FormsNYFTZOption}
#     ${elements}=    Get Elements    ${NYFExpectedInstructions}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions}    ${ActualList}
 
 Verify Form NY Free Trade Zone Instructions
    [Arguments]    ${ExpectedInstructions}

    # Wait for NY FreeTrade Zone option to be visible
    # Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYFTZOption    ${FormsNYFTZOption}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsNYFTZOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'FormsNYFTZOption is not visible to proceed'
    # Click the NY FreeTrade Zone option with return status
    ${status}=    Run Keyword And Return Status    Click    ${FormsNYFTZOption}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on NY FreeTrade Zone option in forms tab

    # Get all expected instructions elements
    ${elements}=    Get Elements    ${NYFExpectedInstructions}
    ${ActualList}=    Create List

    # Loop through elements and collect text
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    # Compare the actual list with expected instructions
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions}    ${ActualList}

# Verify Form NY Free Trade Zone Documentation
#     [Arguments]    ${DocumentationData}
#     ${elementText}    Get Text    ${NYFDocumentationUnderwriter}
#     ${actualelementText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualelementText}    ${DocumentationData['Underwriter']}
#     ${elementText}    Get Attribute    ${NYFDocumentationPolicyNumber}    value
#     ${actualText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualText}    ${DocumentationData['PolicyNumber']}
#     fill text    ${NYFDocumentationPolicyPremiumField}    ${DocumentationData['PolicyPremium']}
#     fill text    ${NYFDocumentationNYPremiumField}    ${DocumentationData['NYPremium']}

Verify Form NY Free Trade Zone Documentation
    [Arguments]    ${DocumentationData}

    # Verify Underwriter text
    ${elementText}=    Get Text    ${NYFDocumentationUnderwriter}
    ${actualelementText}=    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Contain    ${actualelementText}    ${DocumentationData['Underwriter']}

    # Verify Policy Number
    ${elementText}=    Get Attribute    ${NYFDocumentationPolicyNumber}    value
    ${actualText}=    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Contain    ${actualText}    ${DocumentationData['PolicyNumber']}

    # Fill Policy Premium with return status
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFDocumentationPolicyPremiumField}    ${DocumentationData['PolicyPremium']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Policy Premium field in forms tab

    # Fill NY Premium with return status
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFDocumentationNYPremiumField}    ${DocumentationData['NYPremium']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill NY Premium field in forms tab

# Form NY Free Trade Zone Eligibility
#     [Arguments]    ${EligibilityData}
#     fill text    ${NYFEligibilityClass1Field}    ${EligibilityData['Class1']}
#     fill text    ${NYFEligibilityClass2Field}    ${EligibilityData['Class2']}
#     fill text    ${NYFEligibilityClass3Field}    ${EligibilityData['Class3']}

Form NY Free Trade Zone Eligibility
    [Arguments]    ${EligibilityData}

    # Fill Class 1
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFEligibilityClass1Field}    ${EligibilityData['Class1']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill data in NYFEligibilityClass1 Field in forms tab

    # Fill Class 2
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFEligibilityClass2Field}    ${EligibilityData['Class2']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill data in NYFEligibilityClass2 Field in forms tab

    # Fill Class 3
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFEligibilityClass3Field}    ${EligibilityData['Class3']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill data in NYFEligibilityClass3 Field in forms tab

 
# Form NY Free Trade Zone Exposures
#     [Arguments]    ${ExposuresData}
#     fill text    ${NYFExposuresClassificationField}    ${ExposuresData['Classification']}
#     fill text    ${NYFExposuresDescriptionField}    ${ExposuresData['Description']}
#     fill text    ${NYFExposuresLimitsProvidedField}    ${ExposuresData['LimitsProvided']}
 
Form NY Free Trade Zone Exposures
    [Arguments]    ${ExposuresData}

    # Fill Classification
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFExposuresClassificationField}    ${ExposuresData['Classification']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Classification field in the Forms tab

    # Fill Description
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFExposuresDescriptionField}    ${ExposuresData['Description']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Description field in the Forms tab

    # Fill Limits Provided
    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFExposuresLimitsProvidedField}    ${ExposuresData['LimitsProvided']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Limits Provided field in the Forms tab

# Form NY Free Trade Zone Underwriting Evaluation
#     [Arguments]    ${UnderwritingEvaluationData}
#     fill text    ${NYFUnderwritingEvaluationField}    ${UnderwritingEvaluationData['Evaluation']}
 
Form NY Free Trade Zone Underwriting Evaluation
    [Arguments]    ${UnderwritingEvaluationData}

    ${status}=    Run Keyword And Return Status    Fill Text    ${NYFUnderwritingEvaluationField}    ${UnderwritingEvaluationData['Evaluation']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Underwriting Evaluation field in the Forms tab

# Switch to Rate Form
#     # Wait For Elements State    ${RateForm}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    RateForm    ${RateForm}    visible
#     Click    ${RateForm}
#     # Wait For Elements State    ${RateFormHeader}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    RateFormHeader    ${RateFormHeader}    visible

# Switch to Rate Form
#     # Wait for Rate Form option to be visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    RateForm    ${RateForm}    visible

#     ${clickStatus}=    Run Keyword And Return Status    Click    ${RateForm}
#     Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    Failed to click Rate Form option in the Forms tab

#     # Verify Rate Form header appears after navigation
#     Run Keyword And Continue On Failure    Wait For Element With Message    RateFormHeader    ${RateFormHeader}    visible
Switch to Rate Form
    # Wait for Rate Form option to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${RateForm}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Rate Form option is not visible in the Forms tab. It might be a loading issue or not rendered properly.

    ${clickStatus}=    Run Keyword And Return Status    Click    ${RateForm}
    Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    msg=Failed to click Rate Form option in the Forms tab.

    # Verify Rate Form header appears after navigation
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${RateFormHeader}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Rate Form header not visible after navigating to Rate Form.


# Select Reason For Documentation
#     [Arguments]    ${reason}    ${expectedText}
#     ${elements}    Get Elements    ${ReasonForDocumentationText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actualelementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}        
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${ActualList}
#     # Wait For Elements State    ${ReasonForDocumentation}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    ReasonForDocumentation    ${ReasonForDocumentation}    visible
#     # Click    ${ReasonForDocumentation}
#     ${reasonForDoc}    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason}    ']
#     # Wait For Elements State    ${reasonForDoc}   visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    reasonForDoc    ${reasonForDoc}    visible
#     Check Checkbox    ${reasonForDoc}

Select Reason For Documentation
    [Arguments]    ${reason}    ${expectedText}
    ${elements}=    Get Elements    ${ReasonForDocumentationText}
    ${ActualList}=    Create List

    FOR    ${element}    IN    @{elements}
        ${Status}    Run Keyword And Return Status    Wait For Elements State    ${element}    visible     ${display_timeout}
        Should Be True    ${Status}    Reason for Documentation Element is not visible in rate form
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}        
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedText}    ${ActualList}
    # Wait for main Reason For Documentation field
    # Run Keyword And Continue On Failure    Wait For Element With Message    ReasonForDocumentation    ${ReasonForDocumentation}    visible
    # ${reasonForDoc}=    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason}    ']
    # # Wait for specific reason checkbox
    # Run Keyword And Continue On Failure    Wait For Element With Message    reasonForDoc    ${reasonForDoc}    visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ReasonForDocumentation}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReasonForDocumentation is not visible to proceed'

    ${reasonForDoc}=    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason}    ']

    # Wait for specific reason checkbox
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${reasonForDoc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'ReasonForDoc option is not visible to proceed'
    ${clickStatus}=    Run Keyword And Return Status    Check Checkbox    ${reasonForDoc}
    Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    Failed to select reason for documentation: '${reason}' in the Forms tab

 
# General Section In Rate Form
#     [Arguments]    ${expectedGeneralSectionText}    ${data}
#     # Wait For Elements State    ${GeneralSection}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    GeneralSection    ${GeneralSection}    visible
#     ${elements}    Get Elements    ${GeneralSectionText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actualelementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedGeneralSectionText}    ${ActualList}
#     Fill Text    ${PolicyNumber}    ${data['PolicyNumber']}
#     ${effDate}    Get Text    ${PolicyEffectiveDate}
#     ${effDate}    Strip String    ${effDate}
#     ${expectedDate}    Strip String    ${data['PolicyEffectiveDate']}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${effDate}    ${expectedDate}
#     Select Options By    ${WritingCompanyDropdown}    value    ${data['WritingCompany']}
#     ${WritingCompany}    Get Selected Options    ${WritingCompanyDropdown}
#     Run Keyword And Continue On Failure    List Should Contain Value    ${WritingCompany}    ${data['WritingCompany']}
 
General Section In Rate Form
    [Arguments]    ${expectedGeneralSectionText}    ${data}
    # Wait for General Section to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${GeneralSection}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=General Section is not visible in the Rate Form. The UI may not have loaded or the section may be missing.
    # Verify General Section Texts
    ${elements}=    Get Elements    ${GeneralSectionText}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${ActualList}    ${expectedGeneralSectionText}    General Section Text mismatch: Expected '${expectedGeneralSectionText}', found '${ActualList}'

    # Verify Policy Number
    Fill Text    ${PolicyNumber}    ${data['PolicyNumber']}
    ${effDate}=    Get Text    ${PolicyEffectiveDate}
    ${effDate}=    Strip String    ${effDate}
    ${expectedDate}=    Strip String    ${data['PolicyEffectiveDate']}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${effDate}    ${expectedDate}    Policy Effective Date mismatch: Expected '${expectedDate}', found '${effDate}'

    # Verify Writing Company
    Select Options By    ${WritingCompanyDropdown}    value    ${data['WritingCompany']}
    ${WritingCompany}=    Get Selected Options    ${WritingCompanyDropdown}
    Run Keyword And Continue On Failure    List Should Contain Value    ${WritingCompany}    ${data['WritingCompany']}    Writing Company mismatch: Expected selection '${data['WritingCompany']}', found '${WritingCompany}'

# Deviated Rate Locations
#     [Arguments]    ${expectedDeviatedRateLocationsText}    ${data}
#     ${elements}    Get Elements    ${DeviatedRateLocationText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actual_elementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}        ${actual_elementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedDeviatedRateLocationsText}    ${ActualList}
#     Click    ${AddButtonInDeviatedRateLocations}
#     # Wait For Elements State    ${AddDeviatedLocationDialogBox}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AddDeviatedLocationDialogBox    ${AddDeviatedLocationDialogBox}    visible
#     FOR    ${locations}    IN    @{data}
#         ${location}    Catenate        SEPARATOR=    ${SelectLocation}    ${locations}    ']]
#         # Wait For Elements State    ${location}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    location    ${location}    visible
#         Check Checkbox    ${location}
#     END
#     Click    ${CloseDialogBox}
#     # Wait For Elements State    ${AddDeviatedLocationDialogBox}    hidden
#     Run Keyword And Continue On Failure    Wait For Element With Message    AddDeviatedLocationDialogBox    ${AddDeviatedLocationDialogBox}    visible

Deviated Rate Locations
    [Arguments]    ${expectedDeviatedRateLocationsText}    ${data}

    # Verify existing deviated rate locations
    ${elements}=    Get Elements    ${DeviatedRateLocationText}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actual_elementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actual_elementText}
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${ActualList}    ${expectedDeviatedRateLocationsText}    Deviated Rate Locations mismatch: Expected '${expectedDeviatedRateLocationsText}', found '${ActualList}'

    # Open Add Deviated Location dialog
    ${status}=    Run Keyword And Return Status    Click    ${AddButtonInDeviatedRateLocations}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Add button in Deviated Rate Locations

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AddDeviatedLocationDialogBox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Add Deviated Location dialog is not visible after clicking Add. It may be a loading issue or the dialog did not open properly.

    # Select locations to add
    FOR    ${locations}    IN    @{data}
        ${location}=    Catenate    SEPARATOR=    ${SelectLocation}    ${locations}    ']]
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${location}    visible    timeout=5s
        Run Keyword And Continue On Failure    Should Be True    ${status}    Location checkbox '${locations}' is not visible in Add Deviated Location dialog
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${location}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to check location '${locations}'
    END

    # Close the dialog
    ${status}=    Run Keyword And Return Status    Click    ${CloseDialogBox}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click Close button in Add Deviated Location dialog

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AddDeviatedLocationDialogBox}    hidden    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Add Deviated Location dialog did not close after clicking Close. It may still be attached to the DOM due to a UI delay or failure in closing action.

# Deviated Rate Coverage
#     [Arguments]    ${expectedDeviatedRateCoverageText}    ${data}
#     ${elements}    Get Elements    ${DeviatedRateCoverage}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actual_elementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}        ${actual_elementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedDeviatedRateCoverageText}    ${ActualList}
#     FOR    ${coverage}    IN    @{data['ApplicableCoverages']}
#         ${coverages}    Catenate            SEPARATOR=    ${SelectAllApplicableCoverages}    ${coverage}    ']]
#         # Wait For Elements State    ${coverages}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    coverages    ${coverages}    visible
#         Check Checkbox    ${coverages}
#     END
#     Fill Text    ${Limits}    ${data['Limits']}
#     Fill Text    ${Classification}    ${data['Classification']}    
#     Fill Text    ${Code}    ${data['Code']}
#     Fill Text    ${ExposureBasis}    ${data['ExposureBasis']}

Deviated Rate Coverage
    [Arguments]    ${expectedDeviatedRateCoverageText}    ${data}

    # Verify existing deviated rate coverage
    ${elements}=    Get Elements    ${DeviatedRateCoverage}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actual_elementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actual_elementText}
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${ActualList}    ${expectedDeviatedRateCoverageText}    Deviated Rate Coverage mismatch: Expected '${expectedDeviatedRateCoverageText}', found '${ActualList}'

    # Select applicable coverages
    FOR    ${coverage}    IN    @{data['ApplicableCoverages']}
        ${coverages}=    Catenate    SEPARATOR=    ${SelectAllApplicableCoverages}    ${coverage}    ']]
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${coverages}    visible    timeout=5s
        Run Keyword And Continue On Failure    Should Be True    ${status}    Coverage checkbox '${coverage}' is not visible
        ${status}=    Run Keyword And Return Status    Check Checkbox    ${coverages}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to check coverage '${coverage}'
    END

    # Fill coverage details with return status
    ${status}=    Run Keyword And Return Status    Fill Text    ${Limits}    ${data['Limits']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Limits field

    ${status}=    Run Keyword And Return Status    Fill Text    ${Classification}    ${data['Classification']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Classification field

    ${status}=    Run Keyword And Return Status    Fill Text    ${Code}    ${data['Code']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Code field

    ${status}=    Run Keyword And Return Status    Fill Text    ${ExposureBasis}    ${data['ExposureBasis']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Exposure Basis field

 
# Rating Detail
#     [Arguments]    ${expectedRatingDetailText}    ${data}
#     ${elements}    Get Elements    ${RatingDetailText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actual_elementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}        ${actual_elementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedRatingDetailText}    ${ActualList}
#     ${ManualFactors}    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{ManualFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['premises']}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['products']}
#     END
#     ${SelectedFactors}    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{SelectedFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['premises']}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['products']}
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#     END
#     ${RateEligibility}    Get Text    ${DeviatedRateEligibilityDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateEligibility}    ${data['DeviatedRateEligibilityDescription']}
#     ${RateExposure}    Get Text    ${DeviatedRateExposureDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateExposure}    ${data['DeviatedRateExposureDescription']}
#     Fill Text    ${DeviatedRateEligibility}    ${data['DeviatedRateEligibility']}
#     Fill Text    ${DeviatedRateExposure}    ${data['DeviatedRateExposure']}
 Rating Detail
    [Arguments]    ${expectedRatingDetailText}    ${data}

    # Verify rating detail labels
    ${elements}=    Get Elements    ${RatingDetailText}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actual_elementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actual_elementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${expectedRatingDetailText}    ${ActualList}    Rating Detail labels mismatch

    # Fill Manual Factors
    # ${ManualFactors}=    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
    # FOR    ${factor}    IN    @{ManualFactors}
    #     ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
    #     Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible    Manual Factor Premises field '${factor}' is not visible
    #     ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['premises']}
    #     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Manual Factor Premises for '${factor}'

    #     ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
    #     Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible    Manual Factor Products field '${factor}' is not visible
    #     ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['products']}
    #     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Manual Factor Products for '${factor}'
    # END

    # # Fill Selected Factors
    # ${SelectedFactors}=    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
    # FOR    ${factor}    IN    @{SelectedFactors}
    #     ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
    #     Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible    Selected Factor Premises field '${factor}' is not visible
    #     ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['premises']}
    #     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Selected Factor Premises for '${factor}'

    #     ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
    #     Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible    Selected Factor Products field '${factor}' is not visible
    #     ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['products']}
    #     Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Selected Factor Products for '${factor}'
    # END
    ${ManualFactors}=    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
    FOR    ${factor}    IN    @{ManualFactors}

        # Manual Factor Premises
        ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manual Factor Premises field '${factor}' is not visible.

        ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['premises']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Manual Factor Premises for '${factor}'.

        # Manual Factor Products
        ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manual Factor Products field '${factor}' is not visible.

        ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['products']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Manual Factor Products for '${factor}'.

    END
    # -------------------------
    # Selected Factors Section
    # -------------------------
    ${SelectedFactors}=    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
    FOR    ${factor}    IN    @{SelectedFactors}

        # Selected Factor Premises
        ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Selected Factor Premises field '${factor}' is not visible.

        ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['premises']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Selected Factor Premises for '${factor}'.

        # Selected Factor Products
        ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Selected Factor Products field '${factor}' is not visible.

        ${status}=    Run Keyword And Return Status    Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['products']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Failed to fill Selected Factor Products for '${factor}'.

    END

    # Verify Deviated Rate descriptions
    ${RateEligibility}=    Get Text    ${DeviatedRateEligibilityDescription}
    Run Keyword And Continue On Failure    Should Be Equal    ${RateEligibility}    ${data['DeviatedRateEligibilityDescription']}    Deviated Rate Eligibility mismatch

    ${RateExposure}=    Get Text    ${DeviatedRateExposureDescription}
    Run Keyword And Continue On Failure    Should Be Equal    ${RateExposure}    ${data['DeviatedRateExposureDescription']}    Deviated Rate Exposure mismatch

    # Fill Deviated Rate fields with return status
    ${status}=    Run Keyword And Return Status    Fill Text    ${DeviatedRateEligibility}    ${data['DeviatedRateEligibility']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Deviated Rate Eligibility

    ${status}=    Run Keyword And Return Status    Fill Text    ${DeviatedRateExposure}    ${data['DeviatedRateExposure']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to fill Deviated Rate Exposure

# Upload Relevant Documents for Rate
#     [Arguments]    ${data}
    
#     # ${CancelBtn}    Catenate    SEPARATOR=    ${Loc_Upload_cancel_Btn}    ${file}    ${Loc_Upload_cancel_Btn1}
#     # ${Status}    Run Keyword And Return Status    Get Element States    ${CancelBtn}    Validate    value & visible
    
#     # IF    ${Status} == True
#     #     Wait For Elements State    ${CancelBtn}
#     #     Click    ${CancelBtn}
#     # END


#     FOR    ${file}    IN    @{data['UploadFile']}

#         ${CancelBtn}    Catenate    SEPARATOR=    ${Loc_Upload_cancel_Btn}    ${file}    ${Loc_Upload_cancel_Btn1}
#         ${Status}    Run Keyword And Return Status    Get Element States    ${CancelBtn}    Validate    value & visible
    
#         IF    ${Status} == True
#         Run Keyword And Continue On Failure    Wait For Element With Message    CancelBtn    ${CancelBtn}    visible
#         # Wait For Elements State    ${CancelBtn}
#         Click    ${CancelBtn}
#         END

#             ${AbsolutePath}=    Normalize Path    ${AttachmentPath}${file}
#             Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#             ${AttachedDocument}=    Catenate    SEPARATOR=    ${AttachedDocumentName}    ${file}']
#            Run Keyword And Continue On Failure    Wait For Element With Message    AttachedDocument    ${AttachedDocument}    visible
#             # Wait For Elements State    ${AttachedDocument}    visible
#     END
Upload Relevant Documents for Rate
    [Arguments]    ${data}

    FOR    ${file}    IN    @{data['UploadFile']}

        # Build locator for Cancel button for this file
        ${CancelBtn}=    Catenate    SEPARATOR=    ${Loc_Upload_cancel_Btn}    ${file}    ${Loc_Upload_cancel_Btn1}
        ${Status}=    Run Keyword And Return Status    Get Element States    ${CancelBtn}    Validate    value & visible

        # Click Cancel button if it exists
        IF    ${Status} == True
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CancelBtn}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Cancel button '${file}' is not visible.
            ${clickStatus}=    Run Keyword And Return Status    Click    ${CancelBtn}
            Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    Failed to click Cancel button for '${file}'
        END

        # Upload the file
        ${AbsolutePath}=    Normalize Path    ${AttachmentPath}${file}
        ${uploadStatus}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Run Keyword And Continue On Failure    Should Be True    ${uploadStatus}    Failed to upload file '${file}'

        # Verify uploaded document appears
        ${AttachedDocument}=    Catenate    SEPARATOR=    ${AttachedDocumentName}    ${file}']
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${AttachedDocument}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Uploaded document '${file}' is not visible.

    END

 
# Save Changes in Form
#     [Arguments]    ${data}
#     # Wait For Elements State    ${SaveChangesButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    SaveChangesButton    ${SaveChangesButton}    visible
#     Click    ${SaveChangesButton}
#     ${Popup_Text}    Catenate    SEPARATOR=    ${SaveChangesPopup}    ${data['SaveChangesPopup']}    '])[1]    
#     ${popupText}    Get Text    ${Popup_Text}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${popupText}    ${data['SaveChangesPopup']}

Save Changes in Form
    [Arguments]    ${data}

    # Wait for Save Changes button
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SaveChangesButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Save Changes button is not visible.
# Click Save Changes button with status check
    ${clickStatus}=    Run Keyword And Return Status    Click    ${SaveChangesButton}
    Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    Failed to click Save Changes button
    Sleep    1s
    # Verify popup text
    # ${Popup_Text}=    Catenate    SEPARATOR=    ${SaveChangesPopup}    ${data['SaveChangesPopup']}    '])[1]
    # ${popupText}=    Get Text    ${Popup_Text}
    # Run Keyword And Continue On Failure    Should Be Equal As Strings    ${popupText}    ${data['SaveChangesPopup']}    Save Changes popup text mismatch

# Switch To Manuscript Tab
#     # Wait For Elements State    ${Loc_Manuscript_btn}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Manuscript_btn    ${Loc_Manuscript_btn}    visible
#     click    ${Loc_Manuscript_btn}

Switch To Manuscript Tab
    # Wait for Manuscript tab button
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Manuscript_btn}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manuscript tab button is not visible.
    # Click the Manuscript tab with status check
    ${clickStatus}=    Run Keyword And Return Status    Click    ${Loc_Manuscript_btn}
    Run Keyword And Continue On Failure    Should Be True    ${clickStatus}    Failed to click Manuscript tab button

# Verify Manuscript Tab Header
#     [Arguments]    ${exceptedHeader}
#     ${Actual_header}    Get Text    ${Loc_Manuscript_Tab_Verify}
#     Log    Actual header we get is : ${Actual_header}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedHeader}    ${Actual_header}

Verify Manuscript Tab Header
    [Arguments]    ${expectedHeader}
    
    ${actualHeader}    Get Text    ${Loc_Manuscript_Tab_Verify}
    Log    Actual header retrieved: ${actualHeader}
    
    Run Keyword And Continue On Failure    Should Be Equal    ${actualHeader}    ${expectedHeader}    Manuscript tab header mismatch: Expected '${expectedHeader}' but found '${actualHeader}'

# Reason for Documentation
#     [Arguments]    ${Excepted_Reason_Tab}    ${exceptedCheckbox}
#     ${Actual_Tab}    Get Text    ${Loc_Reason_Tab_verify}
#     Log    Actual header we get is : ${Actual_Tab}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Excepted_Reason_Tab}    ${Actual_Tab}
#     IF    '${exceptedCheckbox}' == 'Deregulation'
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Deregulation_Checkbox    ${Loc_Deregulation_Checkbox}    visible
#     # Wait For Elements State    ${Loc_Deregulation_Checkbox}
#     Check Checkbox    ${Loc_Deregulation_Checkbox}
#     Get Checkbox State    ${Loc_Deregulation_Checkbox}
#     ELSE IF    '${exceptedCheckbox}' == 'Manuscript Forms'
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Manuscript_Form_Checkbox    ${Loc_Manuscript_Form_Checkbox}    visible
#     # Wait For Elements State    ${Loc_Manuscript_Form_Checkbox}
#     Check Checkbox    ${Loc_Manuscript_Form_Checkbox}
#     Get Checkbox State    ${Loc_Manuscript_Form_Checkbox}
#     ELSE
#     Log    Checkbox was not clicked
#     END 
Reason for Documentation
    [Arguments]    ${Expected_Reason_Tab}    ${Expected_Checkbox}

    # Verify the tab header
    ${Actual_Tab}    Get Text    ${Loc_Reason_Tab_verify}
    Log    Actual header retrieved: ${Actual_Tab}
    Run Keyword And Continue On Failure    Should Be Equal    ${Expected_Reason_Tab}    ${Actual_Tab}    Reason tab mismatch: Expected '${Expected_Reason_Tab}' but found '${Actual_Tab}'

    # Handle the checkbox based on input
    IF    '${Expected_Checkbox}' == 'Deregulation'
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Deregulation_Checkbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Deregulation checkbox is not visible.
        ${status}    Run Keyword And Return Status    Check Checkbox    ${Loc_Deregulation_Checkbox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Deregulation checkbox could not be clicked
        ${state}    Get Checkbox State    ${Loc_Deregulation_Checkbox}
        Log    Deregulation checkbox state: ${state}
    ELSE IF    '${Expected_Checkbox}' == 'Manuscript Forms'
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Manuscript_Form_Checkbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manuscript form checkbox is not visible.
        ${status}    Run Keyword And Return Status    Check Checkbox    ${Loc_Manuscript_Form_Checkbox}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Manuscript Forms checkbox could not be clicked
        ${state}    Get Checkbox State    ${Loc_Manuscript_Form_Checkbox}
        Log    Manuscript Forms checkbox state: ${state}
    ELSE
        Log    No checkbox action performed for: ${Expected_Checkbox}
    END

   
 
# General Tab
#     [Arguments]    ${exceptedGeneralTab}    ${GenaralDetails}
#     ${actual_Tab}    Get Text    ${Loc_General_Tab}
#     Log    Actual header we get is : ${actual_Tab}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedGeneralTab}    ${actual_Tab}
#     ${actual_Company}    Get Text    ${Loc_WritingCom_Verify}
#     Log    Actual Writing company we get is : ${actual_Company}
#     Run Keyword And Continue On Failure    Should Be Equal    ${GenaralDetails['CompanyName']}    ${actual_Company}
 
#     ${actual_policyNo}    Get Text    ${Loc_PolicyNo}
#     Log    Actual policy number we get is : ${actual_policyNo}
#     Run Keyword And Continue On Failure    Should Be Equal    ${GenaralDetails['PolicyNumber']}    ${actual_policyNo}
 
#     ${actual_EffecctiveDate}    Get Text    ${Loc_EffecDate}
#     Log    Actual policy number we get is : ${actual_EffecctiveDate}
#     Run Keyword And Continue On Failure    Should Be Equal    ${GenaralDetails['EffectiveDate']}    ${actual_EffecctiveDate}
 
 
#     ${actual_ExpiryDate}    Get Text    ${Loc_ExpiryDate}
#     Log    Actual Expiry Date we get is : ${actual_ExpiryDate}
#     Run Keyword And Continue On Failure    Should Be Equal    ${GenaralDetails['ExpiryDate']}    ${actual_ExpiryDate}

General Tab
    [Arguments]    ${expectedGeneralTab}    ${GeneralDetails}

    # Verify the General tab header
    ${actual_Tab}    Get Text    ${Loc_General_Tab}
    Log    Actual General tab header: ${actual_Tab}
    Run Keyword And Continue On Failure    Should Be Equal    ${expectedGeneralTab}    ${actual_Tab}    Tab mismatch: Expected '${expectedGeneralTab}' but found '${actual_Tab}'

    # Verify Writing Company
    ${actual_Company}    Get Text    ${Loc_WritingCom_Verify}
    Log    Actual Writing Company: ${actual_Company}
    Run Keyword And Continue On Failure    Should Be Equal    ${GeneralDetails['CompanyName']}    ${actual_Company}    Company Name mismatch: Expected '${GeneralDetails['CompanyName']}' but found '${actual_Company}'

    # Verify Policy Number
    ${actual_policyNo}    Get Text    ${Loc_PolicyNo}
    Log    Actual Policy Number: ${actual_policyNo}
    Run Keyword And Continue On Failure    Should Be Equal    ${GeneralDetails['PolicyNumber']}    ${actual_policyNo}    Policy Number mismatch: Expected '${GeneralDetails['PolicyNumber']}' but found '${actual_policyNo}'

    # Verify Effective Date
    ${actual_EffectiveDate}    Get Text    ${Loc_EffecDate}
    Log    Actual Effective Date: ${actual_EffectiveDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${GeneralDetails['EffectiveDate']}    ${actual_EffectiveDate}    Effective Date mismatch: Expected '${GeneralDetails['EffectiveDate']}' but found '${actual_EffectiveDate}'

    # Verify Expiry Date
    ${actual_ExpiryDate}    Get Text    ${Loc_ExpiryDate}
    Log    Actual Expiry Date: ${actual_ExpiryDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${GeneralDetails['ExpiryDate']}    ${actual_ExpiryDate}    Expiry Date mismatch: Expected '${GeneralDetails['ExpiryDate']}' but found '${actual_ExpiryDate}'

# Refer to Lines of Business
#     [Arguments]    ${exceptedReferlines}    @{checkBoxHeader}
#     Scroll To Element    ${Loc_Refer_Lines}
#     ${actual_ReferLines_header}    Get Text    ${Loc_Refer_Lines}
#     Log    Actual header we get is : ${actual_ReferLines_header}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedReferlines}    ${actual_ReferLines_header}
   
#     FOR    ${Checkbox}    IN    @{checkBoxHeader}
#     ${Loc_Refer_CheckBox}    Catenate    SEPARATOR=    ${Loc_ReferLines_Checkbox1}    ${Checkbox}    ${Loc_ReferLines_Checkbox2}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Refer_CheckBox    ${Loc_Refer_CheckBox}    visible
#     # Wait For Elements State    ${Loc_Refer_CheckBox}
#     Uncheck Checkbox    ${Loc_Refer_CheckBox}
#     Check Checkbox    ${Loc_Refer_CheckBox}
#     Get Checkbox State    ${Loc_Refer_CheckBox}
     
#     END

Refer to Lines of Business
    [Arguments]    ${expectedReferLines}    @{checkBoxHeader}

    Scroll To Element    ${Loc_Refer_Lines}

    # Verify header text
    ${actual_ReferLines_header}    Get Text    ${Loc_Refer_Lines}
    Log    Actual header we get is: ${actual_ReferLines_header}
    Run Keyword And Continue On Failure    Should Be Equal    ${expectedReferLines}    ${actual_ReferLines_header}    Header mismatch: Expected '${expectedReferLines}' but found '${actual_ReferLines_header}'

    # Loop through checkboxes
    FOR    ${Checkbox}    IN    @{checkBoxHeader}
        ${Loc_Refer_CheckBox}    Catenate    SEPARATOR=    ${Loc_ReferLines_Checkbox1}    ${Checkbox}    ${Loc_ReferLines_Checkbox2}
        
        # Ensure checkbox is visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Refer_CheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Refer checkbox is not visible on the page.
        
        # Toggle the checkbox to verify interactable
        Uncheck Checkbox    ${Loc_Refer_CheckBox}
        Check Checkbox    ${Loc_Refer_CheckBox}
        
        # Confirm checkbox is checked
        # ${is_checked}    Get Checkbox State    ${Loc_Refer_CheckBox}
        # Run Keyword And Continue On Failure    Should Be True    ${is_checked}    Checkbox '${Checkbox}' is not checked as expected
    END

#  Insured Information
#     [Arguments]    ${SelectState}
#     #Wait For Elements State    ${Loc_SelectState}
#     Select Options By    ${Loc_SelectState}    value    ${SelectState}
#     ${Act_State}    Get Selected Options    ${Loc_SelectState}
#     Log    'The Actual State was Selected : ${Act_State}'

Insured Information
    [Arguments]    ${SelectState}

    # Attempt to select the state and capture status
    ${status}    Run Keyword And Return Status    Select Options By    ${Loc_SelectState}    value    ${SelectState}
    
    # Assert that the selection was successful
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to select the State "${SelectState}".'

    # Verify the selected state
    ${Act_State}    Get Selected Options    ${Loc_SelectState}
    Log    'The Actual State Selected: ${Act_State}'
    
 
# ManuScript Details
#     [Arguments]    ${Description}    ${DescriptionExplore}
#     # Wait For Elements State    ${Loc_Description}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Description    ${Loc_Description}    visible
#     Fill Text    ${Loc_Description}    ${Description}
#     ${Actual_Description}    Get Text    ${Loc_Description}
#     Log    The Actual Description We get: ${Actual_Description}
     
#     # Wait For Elements State    ${Loc_Desc_Explore}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Desc_Explore    ${Loc_Desc_Explore}    visible
#     Fill Text    ${Loc_Desc_Explore}    ${DescriptionExplore}
#      ${Actual_ExporeDescription}    Get Text    ${Loc_Desc_Explore}
#     Log    The Actual Description of explore We get: ${Actual_ExporeDescription}

ManuScript Details
    [Arguments]    ${Description}    ${DescriptionExplore}

    # Fill Description field
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Description}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Location Description field is not visible.
    ${status_desc}    Run Keyword And Return Status    Fill Text    ${Loc_Description}    ${Description}
    Run Keyword And Continue On Failure    Should Be True    ${status_desc}    'Failed to fill Description field with value "${Description}".'
    
    ${Actual_Description}    Get Text    ${Loc_Description}
    Log    The Actual Description we get: ${Actual_Description}
    Run Keyword And Continue On Failure    Should Be True    '${Description}' in '${Actual_Description}'    'Description text does not match expected value.'

    # Fill Description Explore field
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Desc_Explore}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Location Description Explore icon is not visible.
    ${status_explore}    Run Keyword And Return Status    Fill Text    ${Loc_Desc_Explore}    ${DescriptionExplore}
    Run Keyword And Continue On Failure    Should Be True    ${status_explore}    'Failed to fill Description Explore field with value "${DescriptionExplore}".'

    ${Actual_ExploreDescription}    Get Text    ${Loc_Desc_Explore}
    Log    The Actual Description of Explore we get: ${Actual_ExploreDescription}
    Run Keyword And Continue On Failure    Should Be True    '${DescriptionExplore}' in '${Actual_ExploreDescription}'    'Explore description text does not match expected value.'

# Upload Relevant Documents for Manuscript
#     [Arguments]    ${data}
#     FOR    ${file}    IN    ${data['DocumentName']}

#         ${CancelBtn}    Catenate    SEPARATOR=    ${Loc_Upload_cancel_Btn}    ${file}    ${Loc_Upload_cancel_Btn1}
#         ${Status}    Run Keyword And Return Status    Get Element States    ${CancelBtn}    Validate    value & visible
    
#         IF    ${Status} == True
#         # Wait For Elements State    ${CancelBtn}
#         Run Keyword And Continue On Failure    Wait For Element With Message    CancelBtn    ${CancelBtn}    visible
#         Click    ${CancelBtn}
#         END
#             ${AbsolutePath}=    Normalize Path    ${AttachmentPath}${file}
#             Upload File By Selector    ${UploadFile}    ${AbsolutePath}
#             ${AttachedDocument}=    Catenate    SEPARATOR=    ${AttachedDocumentName}    ${file}']
#             # Wait For Elements State    ${AttachedDocument}    visible    timeout=180s
#             Run Keyword And Continue On Failure    Wait For Element With Message    AttachedDocument    ${AttachedDocument}    visible
#     END
Upload Relevant Documents for Manuscript
    [Arguments]    ${data}

    FOR    ${file}    IN    ${data['DocumentName']}

        ${CancelBtn}=    Catenate    SEPARATOR=    ${Loc_Upload_cancel_Btn}    ${file}    ${Loc_Upload_cancel_Btn1}
        ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${CancelBtn}    visible    timeout=5s

        IF    ${Status}
            ${status1}=    Run Keyword And Return Status    Click    ${CancelBtn}
            Run Keyword And Continue On Failure    Should Be True    ${status1}    msg=Failed to click Cancel button for file '${file}'
        END

        ${AbsolutePath}=    Normalize Path    ${AttachmentPath}${file}
        ${uploadStatus}=    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
        Run Keyword And Continue On Failure    Should Be True    ${uploadStatus}    msg=Failed to upload file '${file}'

        ${AttachedDocument}=    Catenate    SEPARATOR=    ${AttachedDocumentName}    ${file}']
        ${docStatus}=    Run Keyword And Return Status    Wait For Elements State    ${AttachedDocument}    visible    timeout=180s
        Run Keyword And Continue On Failure    Should Be True    ${docStatus}    msg=Uploaded document '${file}' is not visible after upload

    END

    
# Switch to Company Underwriting Eligibility Form
#     # Wait For Elements State    ${FormsCUEGOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsCUEGOption    ${FormsCUEGOption}    visible
#     Click    ${FormsCUEGOption}
Switch to Company Underwriting Eligibility Form
    # Wait for the element to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsCUEGOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Forms CUEG option is not visible on the page.

    # Click and get the return status
    ${click_status}    Run Keyword And Return Status    Click    ${FormsCUEGOption}
    Run Keyword And Continue On Failure    Should Be True    ${click_status}    'Failed to click on Company Underwriting Eligibility Form option.'

# Verify Form Company Underwriting Eligibility General
#     [Arguments]    ${ExpectedInstructions}
#     ${elementText}    Get Attribute    ${NYFDocumentationPolicyNumber}    value
#     ${actualText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualText}    ${ExpectedInstructions['ExpectedPolicyNumber']}
#     ${elementText}    Get Text    ${CUEGExpectedGeneralEffectiveDate}
#     ${actualText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${actualText}    ${ExpectedInstructions['ExpectedEffectiveDate']}
Verify Form Company Underwriting Eligibility General
    [Arguments]    ${ExpectedInstructions}

    # Verify Policy Number
    ${elementText}    Get Attribute    ${NYFDocumentationPolicyNumber}    value
    ${actualText}    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Be Equal    ${actualText}    ${ExpectedInstructions['ExpectedPolicyNumber']}    msg=Policy Number mismatch: expected ${ExpectedInstructions['ExpectedPolicyNumber']}, got ${actualText}

    # Verify Effective Date
    ${elementText}    Get Text    ${CUEGExpectedGeneralEffectiveDate}
    ${actualText}    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Be Equal    ${actualText}    ${ExpectedInstructions['ExpectedEffectiveDate']}    msg=Effective Date mismatch: expected ${ExpectedInstructions['ExpectedEffectiveDate']}, got ${actualText}
   
# Verify Form Company Underwriting Eligibility Total Points
#     [Arguments]    ${ExpectedInstructions}
#     fill text    ${CUEGTotalPointsField}    ${ExpectedInstructions['TotalPointsValue']}
#     ${elements}=    Get Elements    ${CUEGTotalPointsTableHeaders}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableHeaders']}    ${ActualList}
#     ${elements}=    Get Elements    ${CUEGTotalPointsTableData}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableData']}    ${ActualList}
Verify Form Company Underwriting Eligibility Total Points
    [Arguments]    ${ExpectedInstructions}

    # Fill Total Points field
    ${status}    Run Keyword And Return Status    Fill Text    ${CUEGTotalPointsField}    ${ExpectedInstructions['TotalPointsValue']}
    Run Keyword If    '${status}' == 'False'    Log    Failed to fill Total Points field with value: ${ExpectedInstructions['TotalPointsValue']}

    # Verify Table Headers
    ${elements}=    Get Elements    ${CUEGTotalPointsTableHeaders}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableHeaders']}    ${ActualList}    msg=Table header mismatch: expected ${ExpectedInstructions['ExpectedTableHeaders']}, got ${ActualList}

    # Verify Table Data
    ${elements}=    Get Elements    ${CUEGTotalPointsTableData}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableData']}    ${ActualList}    msg=Table data mismatch: expected ${ExpectedInstructions['ExpectedTableData']}, got ${ActualList}
 
# Verify Form Company Underwriting Eligibility Management Attitude
#     [Arguments]    ${ManagementAttitudeData}
#     ${elements}=    Get Elements    ${CUEGManagementDetails}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ManagementAttitudeData['ExpectedTableData']}    ${ActualList}
#     Fill Text    ${FormsNYUEGPremiumDocumentation}    ${ManagementAttitudeData['DocumentationInput']}

Verify Form Company Underwriting Eligibility Management Attitude
    [Arguments]    ${ManagementAttitudeData}

    # Verify Management Attitude Table
    ${elements}=    Get Elements    ${CUEGManagementDetails}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ManagementAttitudeData['ExpectedTableData']}    ${ActualList}    msg=Management Attitude table mismatch: expected ${ManagementAttitudeData['ExpectedTableData']}, got ${ActualList}

    # Fill Documentation Input
    ${status}    Run Keyword And Return Status    Fill Text    ${FormsNYUEGPremiumDocumentation}    ${ManagementAttitudeData['DocumentationInput']}
    Run Keyword If    '${status}' == 'False'    Log    Failed to fill Documentation field with value: ${ManagementAttitudeData['DocumentationInput']}

# Verify Form Company Underwriting Eligibility Company Inspection Details
#     [Arguments]    ${CompanyInspectionmData}
#     ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${CompanyInspectionmData['ExpectedTableData']}    ${ActualList}
#     Fill Text    ${CUEGCompanyInventoryRecords}    ${CompanyInspectionmData['InventoryRcordsInput']}

Verify Form Company Underwriting Eligibility Company Inspection Details
    [Arguments]    ${CompanyInspectionData}

    # Verify Company Inspection Table
    ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${CompanyInspectionData['ExpectedTableData']}    ${ActualList}    msg=Company Inspection table mismatch: expected ${CompanyInspectionData['ExpectedTableData']}, got ${ActualList}

    # Fill Inventory Records field
    ${status}    Run Keyword And Return Status    Fill Text    ${CUEGCompanyInventoryRecords}    ${CompanyInspectionData['InventoryRcordsInput']}
    Run Keyword If    '${status}' == 'False'    Log    Failed to fill Inventory Records field with value: ${CompanyInspectionData['InventoryRcordsInput']}

# switch to Reinsurance Form
#     # Wait For Elements State    ${FormsReinsuranceOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsReinsuranceOption    ${FormsReinsuranceOption}    visible
#     Click    ${FormsReinsuranceOption}
Switch To Reinsurance Form
    # Wait for the Reinsurance form option to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsReinsuranceOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Forms Reinsurance option is not visible on the page.

    # Attempt to click and capture status
    ${status}    Run Keyword And Return Status    Click    ${FormsReinsuranceOption}
    Run Keyword If    '${status}' == 'False'    Log    Failed to click on Reinsurance Form option: ${FormsReinsuranceOption}


# Verify Reinsurance Form
#     [Arguments]    ${ExpectedReinsurance}
#     ${elements}=    Get Elements    ${ReinsuranceFacultativeObligatory}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#     ${elementText}    Get Text    ${element}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedReinsurance['FacultativeObligatory']}    ${ActualList}
#     ${FacultativeReinsuranceelementText}    Get Text    ${ReinsuranceFacultativeReinsurance}
#     ${actualFacultativeReinsuranceelementText}    Strip String    ${FacultativeReinsuranceelementText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['FacultativeReinsurance']}    ${actualFacultativeReinsuranceelementText}
#     ${EquipmentBreakdownelementText}    Get Text    ${ReinsuranceEquipmentBreakdown}
#     ${actualFacultativeReinsuranceelementText}    Strip String    ${EquipmentBreakdownelementText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['EquipmentBreakdown']}    ${actualFacultativeReinsuranceelementText}
#     ${AssumedReinsuranceelementText}    Get Text    ${ReinsuranceAssumedReinsurance}
#     ${actualAssumedReinsuranceelementText}    Strip String    ${AssumedReinsuranceelementText}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['AssumedReinsurance']}    ${actualAssumedReinsuranceelementText}
#     ${SwiftReelements}=    Get Elements    ${ReinsuranceSwiftRe}
#     ${ActualSwiftReList}    Create List
#     FOR    ${element}    IN    @{SwiftReelements}
#     ${elementText}    Get Text    ${element}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualSwiftReList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedReinsurance['SwiftRe']}    ${ActualSwiftReList}
 Verify Reinsurance Form
    [Arguments]    ${ExpectedReinsurance}

    # Verify Facultative/Obligatory list
    ${elements}=    Get Elements    ${ReinsuranceFacultativeObligatory}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedReinsurance['FacultativeObligatory']}    ${ActualList}

    # Verify Facultative Reinsurance
    ${FacultativeText}    Get Text    ${ReinsuranceFacultativeReinsurance}
    ${actualFacultativeText}    Strip String    ${FacultativeText}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['FacultativeReinsurance']}    ${actualFacultativeText}

    # Verify Equipment Breakdown
    ${EquipmentText}    Get Text    ${ReinsuranceEquipmentBreakdown}
    ${actualEquipmentText}    Strip String    ${EquipmentText}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['EquipmentBreakdown']}    ${actualEquipmentText}

    # Verify Assumed Reinsurance
    ${AssumedText}    Get Text    ${ReinsuranceAssumedReinsurance}
    ${actualAssumedText}    Strip String    ${AssumedText}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedReinsurance['AssumedReinsurance']}    ${actualAssumedText}

    # Verify Swift Re elements
    ${SwiftElements}=    Get Elements    ${ReinsuranceSwiftRe}
    ${ActualSwiftList}    Create List
    FOR    ${element}    IN    @{SwiftElements}
        ${elementText}    Get Text    ${element}
        ${actualElementText}    Strip String    ${elementText}
        Append To List    ${ActualSwiftList}        ${actualElementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedReinsurance['SwiftRe']}    ${ActualSwiftList}
   
# Select Check Box Reinsurance Form
#     [Arguments]    ${CheckBoxOptionsData}
#     ${ActualStatusButtons}    Get Elements    ${ReinsuranceCheckBoxes}
#     ${ActualStatusButtonStatus}    Get Elements    ${ReinsuranceCheckBoxStatus}
#     ${list_length}    Get Length    ${ActualStatusButtons}
#     FOR    ${index}    IN RANGE    0    ${list_length}
#     ${ActualStatusButton}    Set Variable    ${ActualStatusButtonStatus[${index}]}
#     ${Status}    Get Checkbox State    ${ActualStatusButton}
#     IF    '${Status}' == 'True'
#         ${ActualStatus}    Set Variable    ${ActualStatusButtons[${index}]}
#         # Wait For Elements State    ${ActualStatus}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    ActualStatus    ${ActualStatus}    visible
#         Click    ${ActualStatus}
#     END
#     END
#     FOR    ${checkbox}    IN    @{CheckBoxOptionsData['CheckBoxOptions']}
#         ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes3}
#         # Wait For Elements State    ${Reinsurance_CheckBox}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reinsurance_CheckBox    ${Reinsurance_CheckBox}    visible
#         ${Status}    Get Checkbox State    ${Reinsurance_CheckBox}
#         IF    '${Status}' == 'False'
#             ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes2}
#             # Wait For Elements State    ${Reinsurance_CheckBox}
#             Run Keyword And Continue On Failure    Wait For Element With Message    Reinsurance_CheckBox    ${Reinsurance_CheckBox}    visible
#             Click    ${Reinsurance_CheckBox}
#         END
#     END
Select Check Box Reinsurance Form
    [Arguments]    ${CheckBoxOptionsData}

    ${ActualStatusButtons}    Get Elements    ${ReinsuranceCheckBoxes}
    ${ActualStatusButtonStatus}    Get Elements    ${ReinsuranceCheckBoxStatus}
    ${list_length}    Get Length    ${ActualStatusButtons}

    # Uncheck checked boxes first
    FOR    ${index}    IN RANGE    0    ${list_length}
        ${ActualStatusButton}    Set Variable    ${ActualStatusButtonStatus[${index}]}
        ${Status}    Get Checkbox State    ${ActualStatusButton}
        IF    '${Status}' == 'True'
            ${ActualStatus}    Set Variable    ${ActualStatusButtons[${index}]}
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${ActualStatus}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=ActualStatus element is not visible on the page.
            ${ClickStatus}    Run Keyword And Return Status    Click    ${ActualStatus}
            Run Keyword If    '${ClickStatus}' == 'False'    Log    Failed to click on ${ActualStatus}
        END
    END

    # Select required checkboxes
    FOR    ${checkbox}    IN    @{CheckBoxOptionsData['CheckBoxOptions']}
        ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes3}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reinsurance_CheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reinsurance_CheckBox is not visible on the page.
        ${Status}    Get Checkbox State    ${Reinsurance_CheckBox}
        IF    '${Status}' == 'False'
            ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes2}
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Reinsurance_CheckBox}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reinsurance_CheckBox is not visible on the page.
            ${ClickStatus}    Run Keyword And Return Status    Click    ${Reinsurance_CheckBox}
            Run Keyword If    '${ClickStatus}' == 'False'    Log    Failed to click on ${Reinsurance_CheckBox}
        END
    END


# Verify Check Box Reinsurance Form
#     [Arguments]    ${CheckBoxOptionsData}
#     FOR    ${checkbox}    IN    @{CheckBoxOptionsData['CheckBoxOptions']}
#         ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes3}
#         # Wait For Elements State    ${Reinsurance_CheckBox}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Reinsurance_CheckBox    ${Reinsurance_CheckBox}    visible
#         ${Status}    Get Checkbox State    ${Reinsurance_CheckBox}
#         Run Keyword And Continue On Failure    Should Be True    ${Status}    'True'
#     END

# Verify Check Box Reinsurance Form
#     [Arguments]    ${CheckBoxOptionsData}

#     FOR    ${checkbox}    IN    @{CheckBoxOptionsData['CheckBoxOptions']}
#         ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes3}
#         # Wait for checkbox to be visible
#         ${VisibleStatus}    Run Keyword And Return Status    Wait For Element With Message    Reinsurance_CheckBox    ${Reinsurance_CheckBox}    visible
#         Run Keyword If    '${VisibleStatus}' == 'False'    Log    Checkbox ${checkbox} is not visible

#         # Verify checkbox is checked
#         ${Status}    Run Keyword And Return Status    Get Checkbox State    ${Reinsurance_CheckBox}
#         Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Checkbox '${checkbox}' is NOT selected
#     END
Verify Check Box Reinsurance Form
    [Arguments]    ${CheckBoxOptionsData}

    FOR    ${checkbox}    IN    @{CheckBoxOptionsData['CheckBoxOptions']}
        ${Reinsurance_CheckBox}    Catenate    SEPARATOR=    ${ReinsuranceCheckBoxes1}    ${checkbox}    ${ReinsuranceCheckBoxes3}

        # Wait for checkbox to be visible
        ${VisibleStatus}=    Run Keyword And Return Status    Wait For Elements State    ${Reinsurance_CheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${VisibleStatus}    msg=Checkbox '${checkbox}' is not visible in Reinsurance section.

        # IF checkbox was NOT visible, add a log (no Run Keyword If)
        IF    not ${VisibleStatus}
            Log    Checkbox '${checkbox}' is NOT visible — skipping validation.
        END

        # Verify checkbox is checked
        ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${Reinsurance_CheckBox}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Checkbox '${checkbox}' is NOT selected
    END


    
# switch to NY Underwriting Eligibility Guidelines Form
#     # Wait For Elements State    ${FormsNYUEGOption}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYUEGOption    ${FormsNYUEGOption}    visible
#     Click    ${FormsNYUEGOption}
# Switch To NY Underwriting Eligibility Guidelines Form
#     # Wait for the form option to be visible
#     ${VisibleStatus}    Run Keyword And Return Status    Wait For Element With Message    FormsNYUEGOption    ${FormsNYUEGOption}    visible
#     Run Keyword If    '${VisibleStatus}' == 'False'    Log    FormsNYUEGOption is not visible
#     # Click the form option if visible
#     ${ClickStatus}    Run Keyword And Return Status    Click    ${FormsNYUEGOption}
#     Run Keyword If    '${ClickStatus}' == False    Log    Failed to click FormsNYUEGOption
Switch To NY Underwriting Eligibility Guidelines Form
    # Wait for the form option to be visible
    ${VisibleStatus}=    Run Keyword And Return Status    Wait For Elements State    ${FormsNYUEGOption}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${VisibleStatus}    msg=FormsNYUEGOption is not visible

    # If not visible, log additional info (non-blocking)
    IF    not ${VisibleStatus}
        Log    FormsNYUEGOption is not visible — skipping click action.
    END

    # Try clicking the form option
    ${ClickStatus}=    Run Keyword And Return Status    Click    ${FormsNYUEGOption}
    Run Keyword And Continue On Failure    Should Be True    ${ClickStatus}    msg=Failed to click FormsNYUEGOption

    # If click failed, log extra info (non-blocking)
    IF    not ${ClickStatus}
        Log    Click action failed for FormsNYUEGOption.
    END


 
# Verify Form NY Underwriting Eligibility Guidelines Total Points Range
#     [Arguments]    ${ExpectedInstructions}
#     fill text    ${NYUEGTotalPointsField}    ${ExpectedInstructions['TotalPointsValue']}
#     ${elements}=    Get Elements    ${NYUEGTotalPointsTableHeaders}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableHeaders']}    ${ActualList}
#     ${elements}=    Get Elements    ${NYUEGTotalPointsTableData}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableData']}    ${ActualList}

Verify Form NY Underwriting Eligibility Guidelines Total Points Range
    [Arguments]    ${ExpectedInstructions}

    ${FillStatus}    Run Keyword And Return Status    Fill Text    ${NYUEGTotalPointsField}    ${ExpectedInstructions['TotalPointsValue']}
    Run Keyword If    '${FillStatus}' == False    Log    Failed to fill Total Points Field

    ${elements}=    Get Elements    ${NYUEGTotalPointsTableHeaders}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableHeaders']}    ${ActualList}    msg=Table headers mismatch! Expected: ${ExpectedInstructions['ExpectedTableHeaders']}, Actual: ${ActualList}

    ${elements}=    Get Elements    ${NYUEGTotalPointsTableData}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}        ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['ExpectedTableData']}    ${ActualList}    msg=Table data mismatch! Expected: ${ExpectedInstructions['ExpectedTableData']}, Actual: ${ActualList}

# Verify Form NY Underwriting Eligibility Guidelines Company Inspection Details
#     [Arguments]    ${CompanyInspectionData}
#     ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${CompanyInspectionData['ExpectedTableData']}    ${ActualList}
#     Fill Text    ${FormsNYUEGPremiumDocumentation}    ${CompanyInspectionData['DocumentationInput']}
Verify Form NY Underwriting Eligibility Guidelines Company Inspection Details
    [Arguments]    ${CompanyInspectionData}

    ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${CompanyInspectionData['ExpectedTableData']}    ${ActualList}    msg=Company Inspection Table mismatch! Expected: ${CompanyInspectionData['ExpectedTableData']}, Actual: ${ActualList}

    ${FillStatus}    Run Keyword And Return Status    Fill Text    ${FormsNYUEGPremiumDocumentation}    ${CompanyInspectionData['DocumentationInput']}
    Run Keyword If    '${FillStatus}' == False    Log    Failed to fill Documentation Input: ${CompanyInspectionData['DocumentationInput']}
 

# Policy Instruction Form Verification
#     #${TC_Forms_001['PrimaryProperty']}
#     [Arguments]    ${ExceptedHeader}

#     Navigate to Form
#     Switch to Policy Instruction Form

#     Verify Form Summary Headers    ${ExceptedHeader}
#     # Verify Form Summary Details    ${ExceptedHeader}

#     ${elements}=    Get Elements    ${PIFGeneralLOBData}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure     Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralLOB']}    ${ActualList}
#     ${elements}=    Get Elements    ${PIFGeneralDates}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Attribute    ${elements}    value
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure     Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralDateValues']}    ${ActualList}
    
#     # Wait For Elements State    ${PIFPolicyInputField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFPolicyInputField    ${PIFPolicyInputField}    visible
#     ${ActualGeneralDetails}    Get Text    ${PIFPolicyInputField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFPolicyInput']}    ${ActualGeneralDetails}

    
#     ${actual_NeededDate}    Get Text    ${Loc_PIF_NeededDate}
#     Log    Actual Needed Date we get is : ${actual_NeededDate}
#     # ${CurrentDateInput}    Convert To Integer    ${ExceptedHeader['PIFPolicyDateNumberInput']}
#     ${date}=    Get Current Date    result_format=%b %-d, %Y    increment=${ExceptedHeader['PIFPolicyDateNumberInput']}d
#     Run Keyword And Continue On Failure    Should Be Equal    ${date}    ${actual_NeededDate}

#     #${InsuredElements}    Get Element    ${expectedPIFInsuredDetails}
#     ${ActualValues}    Create List
#     FOR    ${actualelement}    IN    @{ExceptedHeader['PIFInsuredDetails']}
#     ${element}    Strip String    ${actualelement}
#     Log To Console    ${element}
#     ${InsuredValues}    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    ${element}    ${Loc_PIF_InsuredDetails2} 
#     ${ListOfValues}    Get Attribute    ${InsuredValues}    value
#     Append To List    ${ActualValues}    ${ListOfValues}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['ExceptedInsuredvalues']}    ${ActualValues}

#     ${DescValue}    Get Text    ${PIFInsuredOperationDesc}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredOperationDescValue']}    ${DescValue}

#     ${YearBusinessValue}    Get Text    ${PIFInsuredDomiciledState}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredYearsInBusinessValue']}    ${YearBusinessValue}

#     ${UsValue}    Get Text    ${PIFInsuredOutSideTheUS}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredOutsideYheUSValue']}    ${UsValue}

#     Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Producer Details    ${ExceptedHeader}
    
#      ${elements}=    Get Elements    ${PIFProcessingExpected}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#     ${elementText}    Get Text    ${element}
#     ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${elementText}    \n
#         IF    ${hasNewLine}
#             @{splitValue}=    Split String    ${elementText}    \n
#             ${split}=    Strip String    ${splitValue}[1]
#             Append To List    ${ActualList}    ${split}
#         ELSE
#             ${trimData}=    Strip String    ${elementText}
#             Append To List    ${ActualList}    ${trimData}
#         END
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['ProcessingDetails']['VerificationValues']}    ${ActualList}

#     ${ActualDatas}    Create List
#     FOR    ${element}    IN    @{ExceptedHeader['PIFProcessingHeaders']}
#     ${ProcessValue}    Catenate    SEPARATOR=    ${Loc_PIF_Process_Detail1}   ${element}    ${Loc_PIF_Process_Detail2}
#     ${ProcessDetails}    Get Text   ${ProcessValue}
#     Log    ${ProcessDetails}
#     Append To List    ${ActualDatas}     ${ProcessDetails}   
#     END
#     Log    ${ActualDatas}
#     #${Exceptedvalues}    Split String    ${ExceptedHeader['PIFProcessingValues']}
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['PIFProcessingValues']}    ${ActualDatas}


#     # ${UWWrittingCompany}=    Catenate    SEPARATOR=    ${PIFProcessingUWOfficeOption}    ${ExceptedHeader['UnderWrittingDetails']['WrittingCompanyName']}     ']
#     # Scroll To Element    ${UWWrittingCompany}
#     # Wait For Elements State    ${Loc_Writing_Company}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Writing_Company    ${Loc_Writing_Company}    visible
#     ${ActualCompany}    Get Text    ${Loc_Writing_Company}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['UnderWrittingDetails']['WrittingCompanyName']}    ${ActualCompany}
    
#     ${AuditableRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${ExceptedHeader['UnderWrittingDetails']['AuditabilityValue']}     ${PIFUWRadioButton2}
#     # Wait For Elements State    ${AuditableRadioButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    AuditableRadioButton    ${AuditableRadioButton}    visible
#     ${Checkbox}    Run Keyword And Return Status    Get Checkbox State    ${AuditableRadioButton}
#     Run Keyword And Continue On Failure    Should Be True    ${Checkbox}

#     ${BillibgTypeRadioButton}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${ExceptedHeader['UnderWrittingDetails']['BillingTypeValue']}     ${PIFUWRadioButton2}
#     # Wait For Elements State    ${BillibgTypeRadioButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    BillibgTypeRadioButton    ${BillibgTypeRadioButton}    visible
#     ${Checkbox1}    Run Keyword And Return Status    Get Checkbox State    ${BillibgTypeRadioButton}
#     Run Keyword And Continue On Failure    Should Be True    ${Checkbox1}
 

#      #[Arguments]    ${HazardGradeDetails}
#     # Wait For Elements State    ${PIFHGSICCode}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGSICCode    ${PIFHGSICCode}    visible
#     ${Actual_SIC_Code}    Get Text    ${PIFHGSICCode}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGSICCode']}    ${Actual_SIC_Code}

#     # Wait For Elements State    ${PIFHGNAICSCode}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGNAICSCode    ${PIFHGNAICSCode}    visible
#     ${Actual_NAIC_Code}    Get Text    ${PIFHGNAICSCode}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGNAICSCode']}    ${Actual_NAIC_Code}

#     # Wait For Elements State    ${PIFHGProperty}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGProperty    ${PIFHGProperty}    visible
#     ${Actual_InsuredDomiciledState}    Get Text    ${PIFHGProperty}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['Property']}    ${Actual_InsuredDomiciledState}


#     # Wait For Elements State    ${PIFHGPropertyNetCompanyLimit}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGPropertyNetCompanyLimit    ${PIFHGPropertyNetCompanyLimit}    visible
#     ${Actual_InsuredOutside_US}    Get Text    ${PIFHGPropertyNetCompanyLimit}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PropertyNetCompanyLimit']}    ${Actual_InsuredOutside_US}

   
#     FOR    ${Endorsement}    IN    @{ExceptedHeader['HazardGradeDetails']['EnhancementEndorsement']}
#          ${EndorsementCheckbox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Endorsement}     ${PIFUWRadioButton2}
#         # Wait For Elements State    ${EndorsementCheckbox}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    EndorsementCheckbox    ${EndorsementCheckbox}    visible
#         ${Status}    Run Keyword And Return Status    Get Checkbox State    ${EndorsementCheckbox}
#         Log    'The Checkbox Extract Status is ${Status}'      
#     END
#     FOR    ${Machinery}    IN    @{ExceptedHeader['HazardGradeDetails']['BoilerMachinery']}
#          ${MachineryCheckBox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Machinery}     ${PIFUWRadioButton2}
#         # Wait For Elements State    ${MachineryCheckBox}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    MachineryCheckBox    ${MachineryCheckBox}    visible
#        ${Status}    Run Keyword And Return Status    Get Checkbox State    ${MachineryCheckBox}
#         Log    'The Checkbox Extract Status is ${Status}'      
#     END
     
#     # Wait For Elements State    ${PIFReinsuranceCdedPrescentage}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFReinsuranceCdedPrescentage    ${PIFReinsuranceCdedPrescentage}    visible
#     ${ActualInsuredPerc}    Get Text    ${PIFReinsuranceCdedPrescentage}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ReinsuranceDetails']['cedePrecentage']}    ${ActualInsuredPerc}
    

#     # Wait For Elements State    ${PIFInstructionDate}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFInstructionDate    ${PIFInstructionDate}    visible
#     ${Actual_CurentDate}    Get Text    ${PIFInstructionDate}
#     # ${expected_day}    Get Current Day Number
#     Run Keyword And Continue On Failure    Should Be Equal    ${date}   ${Actual_CurentDate}

#     # Wait For Elements State    ${PIFInstructionsAdditionalInformation}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFInstructionsAdditionalInformation    ${PIFInstructionsAdditionalInformation}    visible
#     ${Actual_Additional_Informations}    Get Text    ${PIFInstructionsAdditionalInformation}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['InstructionDetails']['AdditionalInformation']}    ${Actual_Additional_Informations}
     
# Policy Instruction Form Verification
#     [Arguments]    ${ExceptedHeader}

#     Navigate to Form
#     Switch to Policy Instruction Form

#     # Verify Summary Headers
#     Verify Form Summary Headers    ${ExceptedHeader}

#     # General LOB Data Verification
#     ${elements}=    Get Elements    ${PIFGeneralLOBData}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}=    Get Text    ${element}
#         ${actualelementText}=    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralLOB']}    ${ActualList}    msg=Mismatch in General LOB Data

#     # General Dates Verification
#     ${elements}=    Get Elements    ${PIFGeneralDates}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}=    Get Attribute    ${element}    value
#         ${actualelementText}=    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralDateValues']}    ${ActualList}    msg=Mismatch in General Dates

#     # Policy Input Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFPolicyInputField    ${PIFPolicyInputField}    visible
#     ${ActualGeneralDetails}=    Get Text    ${PIFPolicyInputField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFPolicyInput']}    ${ActualGeneralDetails}    msg=Policy Input mismatch

#     # Needed Date Verification
#     ${actual_NeededDate}=    Get Text    ${Loc_PIF_NeededDate}
#     ${date}=    Get Current Date    result_format=%Y-%m-%d    increment=${ExceptedHeader['PIFPolicyDateNumberInput']}d
#     Run Keyword And Continue On Failure    Should Be Equal    ${date}    ${actual_NeededDate}    msg=Needed Date mismatch expected: '${date}'' actual: '${actual_NeededDate}' ->

#     # Insured Details Verification
#     ${ActualValues}=    Create List
#     FOR    ${actualelement}    IN    @{ExceptedHeader['PIFInsuredDetails']}
#         ${element}=    Strip String    ${actualelement}
#         ${InsuredValues}=    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    ${element}    ${Loc_PIF_InsuredDetails2}
#         ${ListOfValues}=    Get Attribute    ${InsuredValues}    value
#         Append To List    ${ActualValues}    ${ListOfValues}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['ExceptedInsuredvalues']}    ${ActualValues}    msg=Insured Details mismatch

#     # Insured Operation Description
#     # ${DescValue}=    Get Text    ${PIFInsuredOperationDesc}
#     # Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredOperationDescValue']}    ${DescValue}    msg=Insured Operation Description mismatch

#     # Years in Business Verification
#     ${YearBusinessValue}=    Get Text    ${PIFInsuredDomiciledState}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredYearsInBusinessValue']}    ${YearBusinessValue}    msg=Years in Business mismatch

#     # Outside US Verification
#     ${UsValue}=    Get Text    ${PIFInsuredOutSideTheUS}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredOutsideYheUSValue']}    ${UsValue}    msg=Outside US mismatch

#     # Producer Details Verification
#     Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Producer Details    ${ExceptedHeader}

#     # Hazard Grade Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGSICCode    ${PIFHGSICCode}    visible
#     ${Actual_SIC_Code}=    Get Text    ${PIFHGSICCode}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGSICCode']}    ${Actual_SIC_Code}    msg=SIC Code mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGNAICSCode    ${PIFHGNAICSCode}    visible
#     ${Actual_NAIC_Code}=    Get Text    ${PIFHGNAICSCode}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGNAICSCode']}    ${Actual_NAIC_Code}    msg=NAIC Code mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFHGProperty    ${PIFHGProperty}    visible
#     ${Actual_InsuredDomiciledState}=    Get Text    ${PIFHGProperty}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['Property']}    ${Actual_InsuredDomiciledState}    msg=Property mismatch

#     # Hazard Grade Checkboxes (Endorsement and Machinery)
#     FOR    ${Endorsement}    IN    @{ExceptedHeader['HazardGradeDetails']['EnhancementEndorsement']}
#         ${EndorsementCheckbox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Endorsement}     ${PIFUWRadioButton2}
#         Run Keyword And Continue On Failure    Wait For Element With Message    EndorsementCheckbox    ${EndorsementCheckbox}    visible
#         ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${EndorsementCheckbox}
#         Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Endorsement Checkbox ${Endorsement} not checked
#     END

#     FOR    ${Machinery}    IN    @{ExceptedHeader['HazardGradeDetails']['BoilerMachinery']}
#         ${MachineryCheckBox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Machinery}     ${PIFUWRadioButton2}
#         Run Keyword And Continue On Failure    Wait For Element With Message    MachineryCheckBox    ${MachineryCheckBox}    visible
#         ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${MachineryCheckBox}
#         Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Boiler/Machinery Checkbox ${Machinery} not checked
#     END

Policy Instruction Form Verification
    [Arguments]    ${ExceptedHeader}

    Navigate to Form
    Switch to Policy Instruction Form

    # Verify Summary Headers
    Verify Form Summary Headers    ${ExceptedHeader}

    # General LOB Data Verification
    ${elements}=    Get Elements    ${PIFGeneralLOBData}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralLOB']}    ${ActualList}    msg=Mismatch in General LOB Data

    # General Dates Verification
    ${elements}=    Get Elements    ${PIFGeneralDates}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Attribute    ${element}    value
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['expectedPIFGeneralDateValues']}    ${ActualList}    msg=Mismatch in General Dates

    # Policy Input Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFPolicyInputField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=PIFPolicyInputField is not visible
    ${ActualGeneralDetails}=    Get Text    ${PIFPolicyInputField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFPolicyInput']}    ${ActualGeneralDetails}    msg=Policy Input mismatch

    # Needed Date Verification
    ${actual_NeededDate}=    Get Text    ${Loc_PIF_NeededDate}
    ${date}=    Get Current Date    result_format=%Y-%m-%d    increment=${ExceptedHeader['PIFPolicyDateNumberInput']}d
    Run Keyword And Continue On Failure    Should Be Equal    ${date}    ${actual_NeededDate}    msg=Needed Date mismatch expected: '${date}' actual: '${actual_NeededDate}'

    # Insured Details Verification
    ${ActualValues}=    Create List
    FOR    ${actualelement}    IN    @{ExceptedHeader['PIFInsuredDetails']}
        ${element}=    Strip String    ${actualelement}
        ${InsuredValues}=    Catenate    SEPARATOR=    ${Loc_PIF_InsuredDetails1}    ${element}    ${Loc_PIF_InsuredDetails2}
        ${ListOfValues}=    Get Attribute    ${InsuredValues}    value
        Append To List    ${ActualValues}    ${ListOfValues}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExceptedHeader['ExceptedInsuredvalues']}    ${ActualValues}    msg=Insured Details mismatch

    # Years in Business Verification
    ${YearBusinessValue}=    Get Text    ${PIFInsuredDomiciledState}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredYearsInBusinessValue']}    ${YearBusinessValue}    msg=Years in Business mismatch

    # Outside US Verification
    ${UsValue}=    Get Text    ${PIFInsuredOutSideTheUS}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['PIFInsuredOutsideYheUSValue']}    ${UsValue}    msg=Outside US mismatch

    # Producer Details
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Producer Details    ${ExceptedHeader}

    # Hazard Grade Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFHGSICCode}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=SIC code field not visible
    ${Actual_SIC_Code}=    Get Text    ${PIFHGSICCode}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGSICCode']}    ${Actual_SIC_Code}    msg=SIC Code mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFHGNAICSCode}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=NAICS Code field not visible
    ${Actual_NAIC_Code}=    Get Text    ${PIFHGNAICSCode}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['PIFHGNAICSCode']}    ${Actual_NAIC_Code}    msg=NAIC Code mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PIFHGProperty}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Property field not visible
    ${Actual_InsuredDomiciledState}=    Get Text    ${PIFHGProperty}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['HazardGradeDetails']['Property']}    ${Actual_InsuredDomiciledState}    msg=Property mismatch

    # Hazard Grade Checkboxes (Enhancement Endorsement)
    FOR    ${Endorsement}    IN    @{ExceptedHeader['HazardGradeDetails']['EnhancementEndorsement']}
        ${EndorsementCheckbox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Endorsement}    ${PIFUWRadioButton2}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${EndorsementCheckbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Endorsement checkbox '${Endorsement}' not visible
        ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${EndorsementCheckbox}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Endorsement Checkbox ${Endorsement} not checked
    END

    # Hazard Grade Checkboxes (Boiler Machinery)
    FOR    ${Machinery}    IN    @{ExceptedHeader['HazardGradeDetails']['BoilerMachinery']}
        ${MachineryCheckBox}=    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${Machinery}    ${PIFUWRadioButton2}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${MachineryCheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Boiler/Machinery checkbox '${Machinery}' not visible
        ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${MachineryCheckBox}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Boiler/Machinery Checkbox ${Machinery} not checked
    END


# NY Free TRade Zone Verification
#     #${TC_Forms_002}
#     [Arguments]    ${ExceptedHeader}

#     Navigate to Form
#     Switch To NY FreeTrade Zone

#     Verify Form NY Free Trade Zone Instructions    ${ExceptedHeader['ExpectedInstructionsValues']}

#     # Wait For Elements State    ${NYFDocumentationUnderwriter}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationUnderwriter    ${NYFDocumentationUnderwriter}    visible
#     ${elementText}    Get Text    ${NYFDocumentationUnderwriter}
#     ${actualelementText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualelementText}    ${ExceptedHeader['DocumentationData']['Underwriter']}

#     ${elementText}    Get Attribute    ${NYFDocumentationPolicyNumber}    value
#     ${actualText}    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualText}    ${ExceptedHeader['DocumentationData']['PolicyNumber']}
    
#     # Wait For Elements State    ${NYFDocumentationPolicyPremiumField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationPolicyPremiumField    ${NYFDocumentationPolicyPremiumField}    visible
#     ${ActualPolicyPremium}    Get Text    ${NYFDocumentationPolicyPremiumField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['PolicyPremium']}    ${ActualPolicyPremium}

#     # Wait For Elements State    ${NYFDocumentationNYPremiumField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationNYPremiumField    ${NYFDocumentationNYPremiumField}    visible
#     ${ActualNYPremium}    Get Text    ${NYFDocumentationNYPremiumField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['NYPremium']}    ${ActualNYPremium}
    
#     # Wait For Elements State    ${NYFEligibilityClass1Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass1Field    ${NYFEligibilityClass1Field}    visible
#     ${ActualEligibilityClass1}    Get Text    ${NYFEligibilityClass1Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class1']}    ${ActualEligibilityClass1}

#     # Wait For Elements State    ${NYFEligibilityClass2Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass2Field    ${NYFEligibilityClass2Field}    visible
#     ${ActualEligibilityClass2}    Get Text    ${NYFEligibilityClass2Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class2']}    ${ActualEligibilityClass2}

#     # Wait For Elements State    ${NYFEligibilityClass3Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass3Field    ${NYFEligibilityClass3Field}    visible
#     ${ActualEligibilityClass3}    Get Text    ${NYFEligibilityClass3Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class3']}    ${ActualEligibilityClass3}
    
    
#     # Wait For Elements State    ${NYFExposuresClassificationField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresClassificationField    ${NYFExposuresClassificationField}    visible
#     ${ActualNYF_Classification}    Get Text    ${NYFExposuresClassificationField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Classification']}    ${ActualNYF_Classification}
    
#     # Wait For Elements State    ${NYFExposuresDescriptionField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresDescriptionField    ${NYFExposuresDescriptionField}    visible
#     ${ActualNYF_Description}    Get Text    ${NYFExposuresDescriptionField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Description']}    ${ActualNYF_Description}
    
    
#     # Wait For Elements State    ${NYFExposuresLimitsProvidedField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresLimitsProvidedField    ${NYFExposuresLimitsProvidedField}    visible
#     ${ActualNYF_LimitsProvided}    Get Text    ${NYFExposuresLimitsProvidedField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['LimitsProvided']}    ${ActualNYF_LimitsProvided}
    
#     # Wait For Elements State    ${NYFUnderwritingEvaluationField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFUnderwritingEvaluationField    ${NYFUnderwritingEvaluationField}    visible
#     ${ActualNYF_UnderWritingEvaluation}    Get Text    ${NYFUnderwritingEvaluationField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['UnderwritingEvaluationData']['Evaluation']}    ${ActualNYF_UnderWritingEvaluation}



#     # fill text    ${NYFUnderwritingEvaluationField}    ${UnderwritingEvaluationData['Evaluation']}
#     # fill text    ${NYFExposuresClassificationField}    ${ExposuresData['Classification']}
#     # fill text    ${NYFExposuresDescriptionField}    ${ExposuresData['Description']}
#     # fill text    ${NYFExposuresLimitsProvidedField}    ${ExposuresData['LimitsProvided']}

# NY Free Trade Zone Verification
#     [Arguments]    ${ExceptedHeader}

#     Navigate to Form
#     Switch To NY FreeTrade Zone

#     # Verify Instructions
#     Verify Form NY Free Trade Zone Instructions    ${ExceptedHeader['ExpectedInstructionsValues']}

#     # Documentation Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationUnderwriter    ${NYFDocumentationUnderwriter}    visible
#     ${elementText}=    Get Text    ${NYFDocumentationUnderwriter}
#     ${actualelementText}=    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualelementText}    ${ExceptedHeader['DocumentationData']['Underwriter']}    msg=Underwriter mismatch

#     ${elementText}=    Get Attribute    ${NYFDocumentationPolicyNumber}    value
#     ${actualText}=    Strip String    ${elementText}
#     Run Keyword And Continue On Failure    Should Contain    ${actualText}    ${ExceptedHeader['DocumentationData']['PolicyNumber']}    msg=Policy Number mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationPolicyPremiumField    ${NYFDocumentationPolicyPremiumField}    visible
#     ${ActualPolicyPremium}=    Get Text    ${NYFDocumentationPolicyPremiumField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['PolicyPremium']}    ${ActualPolicyPremium}    msg=Policy Premium mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFDocumentationNYPremiumField    ${NYFDocumentationNYPremiumField}    visible
#     ${ActualNYPremium}=    Get Text    ${NYFDocumentationNYPremiumField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['NYPremium']}    ${ActualNYPremium}    msg=NYPremium mismatch

#     # Eligibility Classes Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass1Field    ${NYFEligibilityClass1Field}    visible
#     ${ActualEligibilityClass1}=    Get Text    ${NYFEligibilityClass1Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class1']}    ${ActualEligibilityClass1}    msg=Class1 mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass2Field    ${NYFEligibilityClass2Field}    visible
#     ${ActualEligibilityClass2}=    Get Text    ${NYFEligibilityClass2Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class2']}    ${ActualEligibilityClass2}    msg=Class2 mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFEligibilityClass3Field    ${NYFEligibilityClass3Field}    visible
#     ${ActualEligibilityClass3}=    Get Text    ${NYFEligibilityClass3Field}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class3']}    ${ActualEligibilityClass3}    msg=Class3 mismatch

#     # Exposures Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresClassificationField    ${NYFExposuresClassificationField}    visible
#     ${ActualNYF_Classification}=    Get Text    ${NYFExposuresClassificationField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Classification']}    ${ActualNYF_Classification}    msg=Classification mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresDescriptionField    ${NYFExposuresDescriptionField}    visible
#     ${ActualNYF_Description}=    Get Text    ${NYFExposuresDescriptionField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Description']}    ${ActualNYF_Description}    msg=Description mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFExposuresLimitsProvidedField    ${NYFExposuresLimitsProvidedField}    visible
#     ${ActualNYF_LimitsProvided}=    Get Text    ${NYFExposuresLimitsProvidedField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['LimitsProvided']}    ${ActualNYF_LimitsProvided}    msg=Limits Provided mismatch

#     # Underwriting Evaluation Verification
#     Run Keyword And Continue On Failure    Wait For Element With Message    NYFUnderwritingEvaluationField    ${NYFUnderwritingEvaluationField}    visible
#     ${ActualNYF_UnderWritingEvaluation}=    Get Text    ${NYFUnderwritingEvaluationField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['UnderwritingEvaluationData']['Evaluation']}    ${ActualNYF_UnderWritingEvaluation}    msg=Underwriting Evaluation mismatch
NY Free Trade Zone Verification
    [Arguments]    ${ExceptedHeader}

    Navigate to Form
    Switch To NY FreeTrade Zone

    # Verify Instructions
    Verify Form NY Free Trade Zone Instructions    ${ExceptedHeader['ExpectedInstructionsValues']}

    # Documentation Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFDocumentationUnderwriter}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Underwriter field not visible
    ${elementText}=    Get Text    ${NYFDocumentationUnderwriter}
    ${actualelementText}=    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Contain    ${actualelementText}    ${ExceptedHeader['DocumentationData']['Underwriter']}    msg=Underwriter mismatch

    ${elementText}=    Get Attribute    ${NYFDocumentationPolicyNumber}    value
    ${actualText}=    Strip String    ${elementText}
    Run Keyword And Continue On Failure    Should Contain    ${actualText}    ${ExceptedHeader['DocumentationData']['PolicyNumber']}    msg=Policy Number mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFDocumentationPolicyPremiumField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Policy Premium field not visible
    ${ActualPolicyPremium}=    Get Text    ${NYFDocumentationPolicyPremiumField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['PolicyPremium']}    ${ActualPolicyPremium}    msg=Policy Premium mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFDocumentationNYPremiumField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=NY Premium field not visible
    ${ActualNYPremium}=    Get Text    ${NYFDocumentationNYPremiumField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['DocumentationData']['NYPremium']}    ${ActualNYPremium}    msg=NYPremium mismatch

    # Eligibility Classes Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFEligibilityClass1Field}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Eligibility Class1 field not visible
    ${ActualEligibilityClass1}=    Get Text    ${NYFEligibilityClass1Field}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class1']}    ${ActualEligibilityClass1}    msg=Class1 mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFEligibilityClass2Field}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Eligibility Class2 field not visible
    ${ActualEligibilityClass2}=    Get Text    ${NYFEligibilityClass2Field}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class2']}    ${ActualEligibilityClass2}    msg=Class2 mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFEligibilityClass3Field}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Eligibility Class3 field not visible
    ${ActualEligibilityClass3}=    Get Text    ${NYFEligibilityClass3Field}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['EligibilityData']['Class3']}    ${ActualEligibilityClass3}    msg=Class3 mismatch

    # Exposures Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFExposuresClassificationField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Exposures Classification field not visible
    ${ActualNYF_Classification}=    Get Text    ${NYFExposuresClassificationField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Classification']}    ${ActualNYF_Classification}    msg=Classification mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFExposuresDescriptionField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Exposures Description field not visible
    ${ActualNYF_Description}=    Get Text    ${NYFExposuresDescriptionField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['Description']}    ${ActualNYF_Description}    msg=Description mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFExposuresLimitsProvidedField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Exposures Limits Provided field not visible
    ${ActualNYF_LimitsProvided}=    Get Text    ${NYFExposuresLimitsProvidedField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['ExposuresData']['LimitsProvided']}    ${ActualNYF_LimitsProvided}    msg=Limits Provided mismatch

    # Underwriting Evaluation Verification
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NYFUnderwritingEvaluationField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Underwriting Evaluation field not visible
    ${ActualNYF_UnderWritingEvaluation}=    Get Text    ${NYFUnderwritingEvaluationField}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedHeader['UnderwritingEvaluationData']['Evaluation']}    ${ActualNYF_UnderWritingEvaluation}    msg=Underwriting Evaluation mismatch


# RATE FORM Verification
#     Switch to Rate Form
#     [Arguments]    ${reason}

#     ${elements}    Get Elements    ${ReasonForDocumentationText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actualelementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}        
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${reason['ReasonCardText']}    ${ActualList}
#     # Wait For Elements State    ${ReasonForDocumentation}    visible
#     # Click    ${ReasonForDocumentation}
#     ${reasonForDoc}    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason['ReasonForDocumentation']}    ']
#     # Wait For Elements State    ${reasonForDoc}   visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    reasonForDoc    ${reasonForDoc}    visible
#     ${ReasonDocument}    Get Attribute    ${reasonForDoc}    aria-checked
#     Run Keyword And Continue On Failure    Should Be Equal    true    ${ReasonDocument}    

#     # Wait For Elements State    ${PolicyNumber}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PolicyNumber    ${PolicyNumber}    visible
#     ${ActualPolicyNo}    Get Text    ${PolicyNumber}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['GeneralSectionData']['PolicyNumber']}    ${ActualPolicyNo}

#     ${effDate}    Get Text    ${PolicyEffectiveDate}
#     ${effDate}    Strip String    ${effDate}
#     ${expectedDate}    Strip String    ${reason['GeneralSectionData']['PolicyEffectiveDate']}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${effDate}    ${expectedDate}
#     #Select Options By    ${WritingCompanyDropdown}    value    ${data['WritingCompany']}
#     ${WritingCompany}    Get Selected Options    ${WritingCompanyDropdown}
#     Run Keyword And Continue On Failure    List Should Contain Value    ${WritingCompany}    ${reason['GeneralSectionData']['WritingCompany']}
#     ${LocationValue}    Catenate    SEPARATOR=    ${Loc_DeviatedRate}    ${reason['DeviatedRateLocationsData1']}    ']
#     ${ActualValue}    Get Text    ${LocationValue}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateLocationsData1']}    ${ActualValue}

#     #Deviated Rate Coverage
#     FOR    ${coverage}    IN    @{reason['DeviatedRateCoverageData']['ApplicableCoverages']}
#         ${coverages}    Catenate            SEPARATOR=    ${PIFUWRadioButton1}    ${coverage}    ${PIFUWRadioButton2}
#         Scroll To Element    ${coverages}
#         # Wait For Elements State    ${coverages}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    coverages    ${coverages}    visible
#         ${Status}    Get Attribute    ${coverages}    aria-checked
#         Run Keyword And Continue On Failure    Should Be Equal    true    ${Status}
#     END

#     # Wait For Elements State    ${Limits}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Limits    ${Limits}    visible
#     ${ActualLimit}    Get Text    ${Limits}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Limits']}   ${ActualLimit}

#     # Wait For Elements State    ${Classification}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Classification    ${Classification}    visible
#     ${ActualClassification}    Get Text    ${Classification}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Classification']}   ${ActualClassification}
    
#     # Wait For Elements State    ${Code}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Code    ${Code}    visible
#     ${ActualCode}    Get Text    ${Code}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Code']}   ${ActualCode}

#     # Wait For Elements State    ${ExposureBasis}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ExposureBasis    ${ExposureBasis}    visible
#     ${ActualExposureBasis}    Get Text    ${ExposureBasis}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['ExposureBasis']}   ${ActualExposureBasis}

#     #Rating Details
#     ${ManualFactors}    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{ManualFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         ${ActualFactor}    Get Text    ${factorPrefix}
#         ${ActualVal}    Convert To Integer    ${ActualFactor}
#         Run Keyword And Continue On Failure     Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['ManualFactors']['${factor}']['premises']}    ${ActualVal}
 
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         ${ActualFactor1}    Get Text    ${factorPrefix}
#         ${ActualVal1}    Convert To Integer    ${ActualFactor1}
#         Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['ManualFactors']['${factor}']['products']}    ${ActualVal1}
#     END
 
#     ${SelectedFactors}    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{SelectedFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         ${ActualFactor}    Get Text    ${factorPrefix}
#         ${ActualVal}    Convert To Integer    ${ActualFactor}
#         Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['SelectedFactors']['${factor}']['premises']}    ${ActualVal}
 
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         ${ActualFactor1}    Get Text    ${factorPrefix}
#         ${ActualVal1}    Convert To Integer    ${ActualFactor1}
#         Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['SelectedFactors']['${factor}']['products']}    ${ActualVal1}
#     END
 
#     ${RateEligibility}    Get Text    ${DeviatedRateEligibilityDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateEligibility}    ${reason['RatingDetailData']['DeviatedRateEligibilityDescription']}
#     ${RateExposure}    Get Text    ${DeviatedRateExposureDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateExposure}    ${reason['RatingDetailData']['DeviatedRateExposureDescription']}
 
#     # Wait For Elements State    ${DeviatedRateEligibility}
#     Run Keyword And Continue On Failure    Wait For Element With Message    DeviatedRateEligibility    ${DeviatedRateEligibility}    visible
#     ${ActualFactor1}    Get Text    ${DeviatedRateEligibility}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateEligibility']}    ${ActualFactor1}
 
#     # Wait For Elements State    ${DeviatedRateExposure}
#     Run Keyword And Continue On Failure    Wait For Element With Message    DeviatedRateExposure    ${DeviatedRateExposure}    visible
#     ${ActualFactor1}    Get Text    ${DeviatedRateExposure}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateExposure']}    ${ActualFactor1}    
# RATE FORM Verification
#     Switch to Rate Form
#     [Arguments]    ${reason}

#     ${elements}    Get Elements    ${ReasonForDocumentationText}
#     ${ActualList}    Create List
#     FOR    ${element}    IN    @{elements}
#         ${elementText}    Get Text    ${element}
#         ${actualelementText}    Strip String    ${elementText}
#         Append To List    ${ActualList}    ${actualelementText}        
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${reason['ReasonCardText']}    ${ActualList}

#     ${reasonForDoc}    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason['ReasonForDocumentation']}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    reasonForDoc    ${reasonForDoc}    visible
#     ${ReasonDocument}    Get Attribute    ${reasonForDoc}    aria-checked
#     Run Keyword And Continue On Failure    Should Be Equal    true    ${ReasonDocument}    msg=Reason for Documentation checkbox mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    PolicyNumber    ${PolicyNumber}    visible
#     ${ActualPolicyNo}    Get Text    ${PolicyNumber}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['GeneralSectionData']['PolicyNumber']}    ${ActualPolicyNo}    msg=Policy Number mismatch

#     ${effDate}    Get Text    ${PolicyEffectiveDate}
#     ${effDate}    Strip String    ${effDate}
#     ${expectedDate}    Strip String    ${reason['GeneralSectionData']['PolicyEffectiveDate']}
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${effDate}    ${expectedDate}    msg=Policy Effective Date mismatch

#     ${WritingCompany}    Get Selected Options    ${WritingCompanyDropdown}
#     Run Keyword And Continue On Failure    List Should Contain Value    ${WritingCompany}    ${reason['GeneralSectionData']['WritingCompany']}    msg=Writing Company mismatch

#     ${LocationValue}    Catenate    SEPARATOR=    ${Loc_DeviatedRate}    ${reason['DeviatedRateLocationsData1']}    ']
#     ${ActualValue}    Get Text    ${LocationValue}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateLocationsData1']}    ${ActualValue}    msg=Deviated Rate Location mismatch

#     # Deviated Rate Coverage Loop
#     FOR    ${coverage}    IN    @{reason['DeviatedRateCoverageData']['ApplicableCoverages']}
#         ${coverages}    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${coverage}    ${PIFUWRadioButton2}
#         Scroll To Element    ${coverages}
#         Run Keyword And Continue On Failure    Wait For Element With Message    coverages    ${coverages}    visible
#         ${Status}    Get Attribute    ${coverages}    aria-checked
#         Run Keyword And Continue On Failure    Should Be Equal    true    ${Status}    msg=Coverage ${coverage} checkbox not selected
#     END

#     ${ActualLimit}    Get Text    ${Limits}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Limits']}   ${ActualLimit}    msg=Limits mismatch

#     ${ActualClassification}    Get Text    ${Classification}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Classification']}   ${ActualClassification}    msg=Classification mismatch

#     ${ActualCode}    Get Text    ${Code}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Code']}   ${ActualCode}    msg=Code mismatch

#     ${ActualExposureBasis}    Get Text    ${ExposureBasis}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['ExposureBasis']}   ${ActualExposureBasis}    msg=Exposure Basis mismatch

#     # Rating Details Loops (ManualFactors & SelectedFactors) remain unchanged
#     # ...

#     # Deviated Rate Descriptions
#     ${RateEligibility}    Get Text    ${DeviatedRateEligibilityDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateEligibility}    ${reason['RatingDetailData']['DeviatedRateEligibilityDescription']}    msg=Eligibility Description mismatch

#     ${RateExposure}    Get Text    ${DeviatedRateExposureDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${RateExposure}    ${reason['RatingDetailData']['DeviatedRateExposureDescription']}    msg=Exposure Description mismatch

#     # Explicit Validation for Deviated Rate Fields
#     Run Keyword And Continue On Failure    Wait For Element With Message    DeviatedRateEligibility    ${DeviatedRateEligibility}    visible
#     ${ActualEligibility}=    Get Text    ${DeviatedRateEligibility}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateEligibility']}    ${ActualEligibility}    msg=Deviated Rate Eligibility mismatch

#     Run Keyword And Continue On Failure    Wait For Element With Message    DeviatedRateExposure    ${DeviatedRateExposure}    visible
#     ${ActualExposure}=    Get Text    ${DeviatedRateExposure}
#     Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateExposure']}    ${ActualExposure}    msg=Deviated Rate Exposure mismatch
RATE FORM Verification
    Switch to Rate Form
    [Arguments]    ${reason}

    ### Reason Card Text Validation ###
    ${elements}    Get Elements    ${ReasonForDocumentationText}
    ${ActualList}    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}    Get Text    ${element}
        ${actualelementText}    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${reason['ReasonCardText']}    ${ActualList}

    ### Reason For Documentation ###
    ${reasonForDoc}    Catenate    SEPARATOR=    ${ReasonForDocumentationOption}    ${reason['ReasonForDocumentation']}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${reasonForDoc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reason For Documentation option not visible: ${reason['ReasonForDocumentation']}

    ${ReasonDocument}    Get Attribute    ${reasonForDoc}    aria-checked
    Run Keyword And Continue On Failure    Should Be Equal    true    ${ReasonDocument}    msg=Reason for Documentation checkbox mismatch

    ### Policy Number ###
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PolicyNumber}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Policy Number field not visible

    ${ActualPolicyNo}    Get Text    ${PolicyNumber}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['GeneralSectionData']['PolicyNumber']}    ${ActualPolicyNo}    msg=Policy Number mismatch

    ### Policy Effective Date ###
    ${effDate}    Get Text    ${PolicyEffectiveDate}
    ${effDate}    Strip String    ${effDate}
    ${expectedDate}    Strip String    ${reason['GeneralSectionData']['PolicyEffectiveDate']}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${effDate}    ${expectedDate}    msg=Policy Effective Date mismatch

    ### Writing Company ###
    ${WritingCompany}    Get Selected Options    ${WritingCompanyDropdown}
    Run Keyword And Continue On Failure    List Should Contain Value    ${WritingCompany}    ${reason['GeneralSectionData']['WritingCompany']}    msg=Writing Company mismatch

    ### Deviated Rate Location ###
    ${LocationValue}    Catenate    SEPARATOR=    ${Loc_DeviatedRate}    ${reason['DeviatedRateLocationsData1']}    ']
    ${ActualValue}    Get Text    ${LocationValue}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateLocationsData1']}    ${ActualValue}    msg=Deviated Rate Location mismatch

    ### Deviated Rate Coverage Loop ###
    FOR    ${coverage}    IN    @{reason['DeviatedRateCoverageData']['ApplicableCoverages']}
        ${coverages}    Catenate    SEPARATOR=    ${PIFUWRadioButton1}    ${coverage}    ${PIFUWRadioButton2}
        Scroll To Element    ${coverages}

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${coverages}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Coverage option not visible: ${coverage}

        ${Status}    Get Attribute    ${coverages}    aria-checked
        Run Keyword And Continue On Failure    Should Be Equal    true    ${Status}    msg=Coverage ${coverage} checkbox not selected
    END

    ### Limits / Classification / Code / Exposure ###
    ${ActualLimit}    Get Text    ${Limits}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Limits']}   ${ActualLimit}    msg=Limits mismatch

    ${ActualClassification}    Get Text    ${Classification}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Classification']}   ${ActualClassification}    msg=Classification mismatch

    ${ActualCode}    Get Text    ${Code}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['Code']}   ${ActualCode}    msg=Code mismatch

    ${ActualExposureBasis}    Get Text    ${ExposureBasis}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['DeviatedRateCoverageData']['ExposureBasis']}   ${ActualExposureBasis}    msg=Exposure Basis mismatch

    ### Deviated Rate Descriptions ###
    ${RateEligibility}    Get Text    ${DeviatedRateEligibilityDescription}
    Run Keyword And Continue On Failure    Should Be Equal    ${RateEligibility}    ${reason['RatingDetailData']['DeviatedRateEligibilityDescription']}    msg=Eligibility Description mismatch

    ${RateExposure}    Get Text    ${DeviatedRateExposureDescription}
    Run Keyword And Continue On Failure    Should Be Equal    ${RateExposure}    ${reason['RatingDetailData']['DeviatedRateExposureDescription']}    msg=Exposure Description mismatch

    ### Explicit Deviated Rate Field Validations ###

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DeviatedRateEligibility}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Deviated Rate Eligibility field not visible
    ${ActualEligibility}=    Get Text    ${DeviatedRateEligibility}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateEligibility']}    ${ActualEligibility}    msg=Deviated Rate Eligibility mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DeviatedRateExposure}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Deviated Rate Exposure field not visible
    ${ActualExposure}=    Get Text    ${DeviatedRateExposure}
    Run Keyword And Continue On Failure    Should Be Equal    ${reason['RatingDetailData']['DeviatedRateExposure']}    ${ActualExposure}    msg=Deviated Rate Exposure mismatch


# Manuscript Data Verification
#     # This method verifies the Details which we are added in Manuscript Tab
#     #${TC_Forms_004['DeregulationHeader']}     ${TC_Forms_004['GenaralDetails']}    @{TC_Forms_004['checkBoxHeader']}    ${SelectState}
#     #$${TC_Forms_004['ManuscriptForm_Desc']}    ${TC_Forms_004['Desc_Explore']}    ${TC_Forms_004}
   
#     # [Arguments]    ${exceptedCheckbox}    ${GenaralDetails}    ${checkBoxHeader}    ${SelectState}    ${Description}    
#     # ...    ${DescriptionExplore}    ${data}

#     [Arguments]    ${exceptedCheckbox}

#     Switch To Manuscript Tab   
 
#     IF    '${exceptedCheckbox['DeregulationHeader']}' == 'Deregulation'
#     # Wait For Elements State    ${Loc_Deregulation_Checkbox}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Deregulation_Checkbox    ${Loc_Deregulation_Checkbox}    visible
#     ${checkboxstatus}    Run Keyword And Return Status    Get Checkbox State    ${Loc_Deregulation_Checkbox}
#     Run Keyword And Continue On Failure    Should Be True    ${checkboxstatus}
 
 
#     ELSE IF    '${exceptedCheckbox['ManuscriptFormHeader']}' == 'Manuscript Forms'
#     # Wait For Elements State    ${Loc_Manuscript_Form_Checkbox}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Manuscript_Form_Checkbox    ${Loc_Manuscript_Form_Checkbox}    visible
#     ${checkboxstatus}    Run Keyword And Return Status    Get Checkbox State    ${Loc_Manuscript_Form_Checkbox}
#     Run Keyword And Continue On Failure    Should Be True    ${checkboxstatus}
 
#     ELSE
#     Log    Checkbox was not clicked
#     END
 
#     ${actual_Company}    Get Text    ${Loc_WritingCom_Verify}
#     Log    Actual Writing company we get is : ${actual_Company}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['CompanyName']}    ${actual_Company}
 
#     ${actual_policyNo}    Get Text    ${Loc_PolicyNo}
#     Log    Actual policy number we get is : ${actual_policyNo}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['PolicyNumber']}    ${actual_policyNo}
 
#      ${actual_EffecctiveDate}    Get Text    ${Loc_EffecDate}
#     Log    Actual policy number we get is : ${actual_EffecctiveDate}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['EffectiveDate']}    ${actual_EffecctiveDate}
 
 
#     ${actual_ExpiryDate}    Get Text    ${Loc_ExpiryDate}
#     Log    Actual Expiry Date we get is : ${actual_ExpiryDate}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['ExpiryDate']}    ${actual_ExpiryDate}
   
#     FOR    ${Checkbox}    IN    @{exceptedCheckbox['checkBoxHeader']}
#     ${Loc_Refer_CheckBox}    Catenate    SEPARATOR=    ${Loc_ReferLines_Checkbox1}    ${Checkbox}    ${Loc_ReferLines_Checkbox2}
#     # Wait For Elements State    ${Loc_Refer_CheckBox}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Refer_CheckBox    ${Loc_Refer_CheckBox}    visible
#     ${Status}    Run Keyword And Return Status    Get Checkbox State    ${Loc_Refer_CheckBox}
#     Run Keyword And Continue On Failure    Should Be True    ${Status}
#     END
 
#     ${Act_State}    Get Selected options    ${Loc_SelectState}
#     Log    'The Actual State was Selected : ${Act_State}'
#     Run Keyword And Continue On Failure    List Should Contain Value    ${Act_State}    ${exceptedCheckbox['Insured_State']}    
 
#     # Wait For Elements State    ${Loc_Description}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Description    ${Loc_Description}    visible
#     ${Actual_Description}    Get Text    ${Loc_Description}
#     Log    The Actual Description We get: ${Actual_Description}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['ManuscriptForm_Desc']}    ${Actual_Description}
 
#     # Wait For Elements State    ${Loc_Desc_Explore}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_Desc_Explore    ${Loc_Desc_Explore}    visible
#     ${Actual_ExporeDescription}    Get Text    ${Loc_Desc_Explore}
#     Log    The Actual Description of explore We get: ${Actual_ExporeDescription}
#     Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['Desc_Explore']}    ${Actual_ExporeDescription}  
   
Manuscript Data Verification
    [Arguments]    ${exceptedCheckbox}

    Switch To Manuscript Tab   

    IF    '${exceptedCheckbox['DeregulationHeader']}' == 'Deregulation'
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Deregulation_Checkbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Deregulation checkbox is not visible
        ${checkboxstatus}=    Run Keyword And Return Status    Get Checkbox State    ${Loc_Deregulation_Checkbox}
        Run Keyword And Continue On Failure    Should Be True    ${checkboxstatus}    msg=Deregulation checkbox not selected

    ELSE IF    '${exceptedCheckbox['ManuscriptFormHeader']}' == 'Manuscript Forms'
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Manuscript_Form_Checkbox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manuscript Form checkbox is not visible
        ${checkboxstatus}=    Run Keyword And Return Status    Get Checkbox State    ${Loc_Manuscript_Form_Checkbox}
        Run Keyword And Continue On Failure    Should Be True    ${checkboxstatus}    msg=Manuscript Form checkbox not selected

    ELSE
        Log    Checkbox was not clicked
    END

    ${actual_Company}=    Get Text    ${Loc_WritingCom_Verify}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['CompanyName']}    ${actual_Company}    msg=Writing Company mismatch

    ${actual_policyNo}=    Get Text    ${Loc_PolicyNo}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['PolicyNumber']}    ${actual_policyNo}    msg=Policy Number mismatch

    ${actual_EffecctiveDate}=    Get Text    ${Loc_EffecDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['EffectiveDate']}    ${actual_EffecctiveDate}    msg=Effective Date mismatch

    ${actual_ExpiryDate}=    Get Text    ${Loc_ExpiryDate}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['GenaralDetails']['ExpiryDate']}    ${actual_ExpiryDate}    msg=Expiry Date mismatch

    FOR    ${Checkbox}    IN    @{exceptedCheckbox['checkBoxHeader']}
        ${Loc_Refer_CheckBox}=    Catenate    SEPARATOR=    ${Loc_ReferLines_Checkbox1}    ${Checkbox}    ${Loc_ReferLines_Checkbox2}

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Refer_CheckBox}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Refer checkbox '${Checkbox}' is not visible

        ${Status}=    Run Keyword And Return Status    Get Checkbox State    ${Loc_Refer_CheckBox}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Refer checkbox '${Checkbox}' is not selected
    END

    ${Act_State}=    Get Selected Options    ${Loc_SelectState}
    Run Keyword And Continue On Failure    List Should Contain Value    ${Act_State}    ${exceptedCheckbox['Insured_State']}    msg=Insured State mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Description}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Manuscript Description field is not visible

    ${Actual_Description}=    Get Text    ${Loc_Description}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['ManuscriptForm_Desc']}    ${Actual_Description}    msg=Manuscript Description mismatch

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_Desc_Explore}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Description Explore field is not visible

    ${Actual_ExporeDescription}=    Get Text    ${Loc_Desc_Explore}
    Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['Desc_Explore']}    ${Actual_ExporeDescription}    msg=Description Explore mismatch

    # FOR    ${file}    IN    ${exceptedCheckbox['DocumentName']}
    # ${AttachedDocument}=    Catenate    SEPARATOR=    ${Loc_Attachment_Select}    ${file}']
    # Wait For Elements State    ${AttachedDocument}    visible
    # ${ActualDoc}    Get Text    ${AttachedDocument}
    # Run Keyword And Continue On Failure    Should Be Equal    ${exceptedCheckbox['DocumentName']}    ${ActualDoc}
    # END


# Underwriting Eligibility Form Verification
#     #${TC_Forms_005}    ${TC_Forms_005['TotalPoints']}
#     [Arguments]    ${ExpectedInstructions}
    
#     Switch to Company Underwriting Eligibility Form
#     Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility General    ${ExpectedInstructions['GeneralData']}

    
#     # Wait For Elements State    ${CUEGTotalPointsField}
#     Run Keyword And Continue On Failure    Wait For Element With Message    CUEGTotalPointsField    ${CUEGTotalPointsField}    visible
#     ${ActualPoints}    Get Text    ${CUEGTotalPointsField}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['TotalPoints']['TotalPointsValue']}    ${ActualPoints}

#     # fill text    ${CUEGTotalPointsField}    ${ExpectedInstructions['TotalPoints']['TotalPointsValue']}

#     ${elements}=    Get Elements    ${CUEGTotalPointsTableHeaders}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['TotalPoints']['ExpectedTableHeaders']}    ${ActualList}
#     ${elements}=    Get Elements    ${CUEGTotalPointsTableData}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['TotalPoints']['ExpectedTableData']}    ${ActualList}

#     Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Management Attitude    ${ExpectedInstructions['ManagementAttitudevalues']}

    
#     ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     # Lists Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['ExpectedTableData']}    ${ActualList}
    
#     # Wait For Elements State    ${CUEGCompanyInventoryRecords}
#     Run Keyword And Continue On Failure    Wait For Element With Message    CUEGCompanyInventoryRecords    ${CUEGCompanyInventoryRecords}    visible
#     ${ActualPoints}    Get Text    ${CUEGCompanyInventoryRecords}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['InventoryRcordsInput']}    ${ActualPoints}

#     #Fill Text    ${CUEGCompanyInventoryRecords}    ${ExpectedInstructions['CompanyInspectionValues']['InventoryRcordsInput']}

Underwriting Eligibility Form Verification
    [Arguments]    ${ExpectedInstructions}

    Switch to Company Underwriting Eligibility Form

    # --- Verify General Section ---
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility General    ${ExpectedInstructions['GeneralData']}

    # --- Verify Total Points ---
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CUEGTotalPointsField}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=CUEGTotalPointsField is not visible
    ${ActualPoints}    Get Text    ${CUEGTotalPointsField}
    ${ActualPoints}    Strip String    ${ActualPoints}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['TotalPoints']['TotalPointsValue']}    ${ActualPoints}

    # --- Verify Total Points Table Headers ---
    ${elements}=    Get Elements    ${CUEGTotalPointsTableHeaders}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['TotalPoints']['ExpectedTableHeaders']}    ${ActualList}

    # --- Verify Total Points Table Data ---
    ${elements}=    Get Elements    ${CUEGTotalPointsTableData}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['TotalPoints']['ExpectedTableData']}    ${ActualList}

    # --- Verify Management Attitude Section ---
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Management Attitude    ${ExpectedInstructions['ManagementAttitudevalues']}

    # --- Verify Company Inspection Details ---
    ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    # Uncomment if you want to compare actual inspection details with expected
    # Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['ExpectedTableData']}    ${ActualList}

    # --- Verify Company Inventory Records ---
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CUEGCompanyInventoryRecords}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=CUEGCompanyInventoryRecords is not visible
    ${ActualPoints}=    Get Text    ${CUEGCompanyInventoryRecords}
    ${ActualPoints}=    Strip String    ${ActualPoints}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['InventoryRcordsInput']}    ${ActualPoints}

    # Optional: Fill text if needed
    # Fill Text    ${CUEGCompanyInventoryRecords}    ${ExpectedInstructions['CompanyInspectionValues']['InventoryRcordsInput']}


# NY Underwriting Eligibility Guidelines Form Verification  

#     [Arguments]    ${ExpectedInstructions}

#     ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
#     ${ActualList}    Create List
#     FOR    ${elements}    IN    @{elements}
#     ${elementText}    Get Text    ${elements}
#     ${actualelementText}    Strip String    ${elementText}
#     Append To List    ${ActualList}        ${actualelementText}
#     END
#     Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['ExpectedTableData']}    ${ActualList}

#     # Wait For Elements State    ${FormsNYUEGPremiumDocumentation}
#     Run Keyword And Continue On Failure    Wait For Element With Message    FormsNYUEGPremiumDocumentation    ${FormsNYUEGPremiumDocumentation}    visible
#     ${ActualPoints}    Get Text    ${FormsNYUEGPremiumDocumentation}
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['DocumentationInput']}    ${ActualPoints}

#     #Fill Text    ${CUEGCompanyInventoryRecords}    ${CompanyInspectionmData['InventoryRcordsInput']}
NY Underwriting Eligibility Guidelines Form Verification
    [Arguments]    ${ExpectedInstructions}

    # --- Verify Company Inspection Details ---
    ${elements}=    Get Elements    ${CUEGCompanyInspectionDetails}
    ${ActualList}=    Create List
    FOR    ${element}    IN    @{elements}
        ${elementText}=    Get Text    ${element}
        ${actualelementText}=    Strip String    ${elementText}
        Append To List    ${ActualList}    ${actualelementText}
    END
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['ExpectedTableData']}    ${ActualList}    msg=Company Inspection Details do not match

    # --- Verify Premium Documentation ---
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${FormsNYUEGPremiumDocumentation}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=FormsNYUEGPremiumDocumentation is not visible
    ${ActualPoints}=    Get Text    ${FormsNYUEGPremiumDocumentation}
    ${ActualPoints}=    Strip String    ${ActualPoints}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedInstructions['CompanyInspectionValues']['DocumentationInput']}    ${ActualPoints}    msg=Premium Documentation value mismatch

    # Optional: Fill text if needed
    # Fill Text    ${FormsNYUEGPremiumDocumentation}    ${ExpectedInstructions['CompanyInspectionValues']['DocumentationInput']}



# Complete Form
#     [Arguments]    ${data}

#     ${Status}    Run Keyword And Return Status    Get Element States  ${Loc_CompleteForm_btn}    validate    value & visible
#     IF    ${Status}
#     # Wait For Elements State    ${Loc_CompleteForm_btn}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Loc_CompleteForm_btn    ${Loc_CompleteForm_btn}    visible
#     Click    ${Loc_CompleteForm_btn}
#     # ${Popup_Text}    Catenate    SEPARATOR=    ${SaveChangesPopup}    ${data['CompleteFormPopup']}    ']    
#     # ${popupText}    Get Text    ${Popup_Text}
#     # Run Keyword And Continue On Failure    Should Be Equal As Strings    ${popupText}    ${data['CompleteFormPopup']}
#     END
# Complete Form
#     [Arguments]    ${data}

#     # Check if the Complete Form button is visible and enabled
#     ${Status}    Run Keyword And Return Status    Get Element States    ${Loc_CompleteForm_btn}    validate    value & visible
#     IF    ${Status}
#         # Wait until the button is visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    Loc_CompleteForm_btn    ${Loc_CompleteForm_btn}    visible    msg=Complete Form button is not visible

#         # Click the Complete Form button
#         Click    ${Loc_CompleteForm_btn}

#         # Optional: Verify the popup text after clicking
#         # ${Popup_Loc}=    Catenate    SEPARATOR=    ${SaveChangesPopup}    ${data['CompleteFormPopup']}    ']
#         # ${popupText}=    Get Text    ${Popup_Loc}
#         # Run Keyword And Continue On Failure    Should Be Equal As Strings    ${popupText}    ${data['CompleteFormPopup']}    msg=Complete Form popup text mismatch
#     ELSE
#         Log    Complete Form button is not available, skipping click
#     END
Complete Form
    [Arguments]    ${data}

    # Check if the Complete Form button is visible and enabled
    ${Status}    Run Keyword And Return Status    Get Element States    ${Loc_CompleteForm_btn}    validate    value & visible

    IF    ${Status}
        # Wait until the button is visible
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Loc_CompleteForm_btn}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Complete Form button is not visible

        # Click the Complete Form button
        ${clicked}=    Run Keyword And Return Status    Click    ${Loc_CompleteForm_btn}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Complete Form button

        # Optional popup verification (kept commented as in your original code)
        # ${Popup_Loc}=    Catenate    SEPARATOR=    ${SaveChangesPopup}    ${data['CompleteFormPopup']}    ']
        # ${popupText}=    Get Text    ${Popup_Loc}
        # Run Keyword And Continue On Failure    Should Be Equal As Strings    ${popupText}    ${data['CompleteFormPopup']}    msg=Complete Form popup text mismatch

    ELSE
        Log    Complete Form button is not available, skipping click
    END



Complete Forms Tab Details Filling

    [Arguments]    ${data1}

    #Policy Instruction Form
    Navigate to Form
    Switch to Policy Instruction Form
    Run Keyword And Continue On Failure    Verify Form Summary Headers    ${data1['TC_Forms_001']['PrimaryProperty']}
    #Verify Form Summary Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form General Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Insured Tab Details    ${data1['TC_Forms_001']['PrimaryProperty']}    
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Producer Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Processing Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Underwritting Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Hazard Grade Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Reinsurance Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Verify Form Policy Instruction Form Instruction Details    ${data1['TC_Forms_001']['PrimaryProperty']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_001']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_001']}

   
    # # NY FreeTrade Zone

    Switch To NY FreeTrade Zone
    Run Keyword And Continue On Failure    Verify Form NY Free Trade Zone Instructions    ${data1['TC_Forms_002']['ExpectedInstructionsValues']}
    Run Keyword And Continue On Failure    Verify Form NY Free Trade Zone Documentation    ${data1['TC_Forms_002']['DocumentationData']}
    Form NY Free Trade Zone Eligibility    ${data1['TC_Forms_002']['EligibilityData']}
    Form NY Free Trade Zone Exposures    ${data1['TC_Forms_002']['ExposuresData']}
    Form NY Free Trade Zone Underwriting Evaluation    ${data1['TC_Forms_002']['UnderwritingEvaluationData']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_002']} 
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_002']}

    # RateForm

    Switch to Rate Form
    Run Keyword And Continue On Failure    Select Reason For Documentation    ${data1['TC_Forms_003']['ReasonForDocumentation']}    ${data1['TC_Forms_003']['ReasonCardText']}
    Run Keyword And Continue On Failure    General Section In Rate Form    ${data1['TC_Forms_003']['GeneralSectionText']}    ${data1['TC_Forms_003']['GeneralSectionData']}
    Run Keyword And Continue On Failure    Deviated Rate Locations    ${data1['TC_Forms_003']['DeviatedRateLocations']}    ${data1['TC_Forms_003']['DeviatedRateLocationsData']}
    Run Keyword And Continue On Failure    Deviated Rate Coverage    ${data1['TC_Forms_003']['DeviatedRateCoverage']}    ${data1['TC_Forms_003']['DeviatedRateCoverageData']}
    Run Keyword And Continue On Failure    Rating Detail    ${data1['TC_Forms_003']['RatingDetailText']}    ${data1['TC_Forms_003']['RatingDetailData']}
    # Upload Relevant Documents for Rate    ${data1['TC_Forms_003']['RatingDetailData']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_003']['RatingDetailData']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_003']['RatingDetailData']}

    #Manuscript Form

    Switch To Manuscript Tab
    Run Keyword And Continue On Failure    Run Keyword And Continue On Failure    Verify Manuscript Tab Header    ${data1['TC_Forms_004']['manuscriptHeader']}
    Run Keyword And Continue On Failure    Reason for Documentation    ${data1['TC_Forms_004']['Reason_Tab_Header']}    ${data1['TC_Forms_004']['DeregulationHeader']}
    Run Keyword And Continue On Failure    General Tab    ${data1['TC_Forms_004']['General_tab_Header']}    ${data1['TC_Forms_004']['GenaralDetails']}
    Run Keyword And Continue On Failure    Refer to Lines of Business    ${data1['TC_Forms_004']['ReferToLinesHeader']}    @{data1['TC_Forms_004']['checkBoxHeader']}
    Run Keyword And Continue On Failure    Insured Information    ${data1['TC_Forms_004']['Insured_State']}
    Run Keyword And Continue On Failure    ManuScript Details    ${data1['TC_Forms_004']['ManuscriptForm_Desc']}    ${data1['TC_Forms_004']['Desc_Explore']}
    # Upload Relevant Documents for Manuscript    ${data1['TC_Forms_004']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_004']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_004']}
    # Company Underwriting Eligibility Form

    Switch to Company Underwriting Eligibility Form
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility General    ${data1['TC_Forms_005']['GeneralData']}
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Total Points    ${data1['TC_Forms_005']['TotalPoints']}
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Management Attitude    ${data1['TC_Forms_005']['ManagementAttitudevalues']}
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Company Inspection Details    ${data1['TC_Forms_005']['CompanyInspectionValues']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_005']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_005']}
    # Reinsurance Form

    Run Keyword And Continue On Failure    switch to Reinsurance Form
    Run Keyword And Continue On Failure    Verify Reinsurance Form    ${data1['TC_Forms_006']}
    Run Keyword And Continue On Failure    Select Check Box Reinsurance Form    ${data1['TC_Forms_006']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_006']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_006']}

    # NY Underwriting Eligibility Guidelines Form

    Run Keyword And Continue On Failure    switch to NY Underwriting Eligibility Guidelines Form
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility General    ${data1['TC_Forms_007']['GeneralData']}
    Run Keyword And Continue On Failure    Verify Form NY Underwriting Eligibility Guidelines Total Points Range    ${data1['TC_Forms_007']['TotalPoints']}
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Management Attitude    ${data1['TC_Forms_007']['ManagementAttitudevalues']}
    Run Keyword And Continue On Failure    Verify Form NY Underwriting Eligibility Guidelines Company Inspection Details    ${data1['TC_Forms_007']['CompanyInspectionValues']}
    Run Keyword And Continue On Failure    Save Changes in Form    ${data1['TC_Forms_007']}
    Run Keyword And Continue On Failure    Complete Form    ${data1['TC_Forms_007']}

Complete Forms Tab Details Verification

    [Arguments]    ${data1}

    Run Keyword And Continue On Failure    Policy Instruction Form Verification    ${data1['TC_Forms_001']['PrimaryProperty']}
    
    Run Keyword And Continue On Failure    NY Free TRade Zone Verification    ${data1['TC_Forms_002']}
    Run Keyword And Continue On Failure    RATE FORM Verification    ${data1['TC_Forms_003']}
    Run Keyword And Continue On Failure    Manuscript Data Verification    ${data1['TC_Forms_004']}    
    Run Keyword And Continue On Failure    Underwriting Eligibility Form Verification    ${data1['TC_Forms_005']}

    switch to Reinsurance Form
    Run Keyword And Continue On Failure    Verify Reinsurance Form    ${data1['TC_Forms_006']}
    Verify Check Box Reinsurance Form    ${data1['TC_Forms_006']}
    # Select Check Box Reinsurance Form    ${data1['TC_Forms_006']}

    switch to NY Underwriting Eligibility Guidelines Form
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility General    ${data1['TC_Forms_007']['GeneralData']}
    Run Keyword And Continue On Failure    Verify Form NY Underwriting Eligibility Guidelines Total Points Range    ${data1['TC_Forms_007']['TotalPoints']}
    Run Keyword And Continue On Failure    Verify Form Company Underwriting Eligibility Management Attitude    ${data1['TC_Forms_007']['ManagementAttitudevalues']}

    Run Keyword And Continue On Failure    NY Underwriting Eligibility Guidelines Form Verification    ${data1['TC_Forms_007']} 

# PIF Ceded Reinsurance Verification
#     [Documentation]    This method verifies the ceded reinsurance field should be empty and it should appears the percentile symbol
#     [Arguments]    ${ExceptedHeader}

#     Navigate to Form
#     Switch to Policy Instruction Form

#     #percentile symbol
#     # Wait For Elements State    ${PIF_Reinsurance_Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIF_Reinsurance_Field    ${PIF_Reinsurance_Field}    visible
#     ${ActualInsuredPerc}    Get Attribute    ${PIF_Reinsurance_Field}    class
#     Log    ${ActualInsuredPerc}

#     Run Keyword And Continue On Failure    Should Contain    ${ActualInsuredPerc}     ${ExceptedHeader['ReinsuranceDetails']['cededPrecentage']}

#     #ceded reinsurance field should be empty Not to be Zero

#     # Wait For Elements State    ${PIFReinsuranceCdedPrescentage}
#     Run Keyword And Continue On Failure    Wait For Element With Message    PIFReinsuranceCdedPrescentage    ${PIFReinsuranceCdedPrescentage}    visible
#     ${Actualvalue}    Get Attribute    ${PIFReinsuranceCdedPrescentage}    value
#     Log    ${Actualvalue}
#     Run Keyword And Continue On Failure    Should Be Empty    ${Actualvalue}
PIF Ceded Reinsurance Verification
    [Documentation]    Verifies that the ceded reinsurance field is empty and the percentile symbol appears.
    [Arguments]    ${ExceptedHeader}

    Navigate to Form

    Switch to Policy Instruction Form

    # Percentile symbol
    ${statusField}=    Run Keyword And Return Status    Wait For Elements State    ${PIF_Reinsurance_Field}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${statusField}    msg=PIF Reinsurance Field is not visible.

    ${ActualInsuredPerc}=    Get Attribute    ${PIF_Reinsurance_Field}    class
    Run Keyword And Continue On Failure    Should Contain    ${ActualInsuredPerc}    ${ExceptedHeader['ReinsuranceDetails']['cededPrecentage']}    msg=Reinsurance field class does not contain expected percentile symbol.

    # Ceded reinsurance field should be empty, not zero
    ${statusCeded}=    Run Keyword And Return Status    Wait For Elements State    ${PIFReinsuranceCdedPrescentage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${statusCeded}    msg=Ceded Reinsurance Percentage field is not visible.

    ${Actualvalue}=    Get Attribute    ${PIFReinsuranceCdedPrescentage}    value
    Run Keyword And Continue On Failure    Should Be Empty    ${Actualvalue}    msg=Ceded Reinsurance Percentage field is not empty; expected empty.

# Rating Details Numeric Verification
#     [Documentation]    This method is used to verify that the Premises/Products field should not accept string values.
#     [Arguments]    ${data}
#      Navigate to Form
#     Switch to Rate Form
#     #Rating Details
#     ${ManualFactors}    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{ManualFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['premises']}
#         ${ActualFactor}    Get Text    ${factorPrefix}
#         Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor}
 
#         ${factorPrefix}    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['products']}
#         ${ActualFactor1}    Get Text    ${factorPrefix}
#         Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor1}
#     END
 

#     ${SelectedFactors}    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
#     FOR    ${factor}    IN    @{SelectedFactors}
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['premises']}
#         ${ActualFactor}    Get Text    ${factorPrefix}
#         Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor}
 
#         ${factorPrefix}    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
#         # Wait For Elements State    ${factorPrefix}    visible
#         Run Keyword And Continue On Failure    Wait For Element With Message    factorPrefix    ${factorPrefix}    visible
#         Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['products']}
#         ${ActualFactor1}    Get Text    ${factorPrefix}
#         Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor1}
#     END
Rating Details Numeric Verification
    [Documentation]    Verifies that the Premises/Products fields do not accept string values.
    [Arguments]    ${data}

    Navigate to Form

    Switch to Rate Form

    # Rating Details - Manual Factors
    ${ManualFactors}=    Create List    Rate:    Incr. Limit Factor:    Deductible/SIR Factor:
    FOR    ${factor}    IN    @{ManualFactors}
        ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorPremisesValuePrefix}    ${factor}    ${ManualFactorPremissesSuffix}
        ${statusField}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${statusField}    msg=Manual Factor Premises field "${factor}" is not visible.

        Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['premises']}
        ${ActualFactor}=    Get Text    ${factorPrefix}
        Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor}    msg=Manual Factor Premises field "${factor}" accepted text; expected empty.

        ${factorPrefix}=    Catenate    SEPARATOR=    ${ManualFactorProductsValuePrefix}    ${factor}    ${ManualFactorProductsSuffix}
        ${statusField}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${statusField}    msg=Manual Factor Products field "${factor}" is not visible.

        Fill Text    ${factorPrefix}    ${data['ManualFactors']['${factor}']['products']}
        ${ActualFactor1}=    Get Text    ${factorPrefix}
        Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor1}    msg=Manual Factor Products field "${factor}" accepted text; expected empty.
    END

    # Selected Factors
    ${SelectedFactors}=    Create List    Rate:    Incr. Limits:    Deductible/SIR Factor:
    FOR    ${factor}    IN    @{SelectedFactors}
        ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorPremisesValuePrefix}    ${factor}    ${SelectedFactorPremisesValueSuffix}
        ${statusField}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${statusField}    msg=Selected Factor Premises field "${factor}" is not visible.

        Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['premises']}
        ${ActualFactor}=    Get Text    ${factorPrefix}
        Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor}    msg=Selected Factor Premises field "${factor}" accepted text; expected empty.

        ${factorPrefix}=    Catenate    SEPARATOR=    ${SelectedFactorProductsValuePrefix}    ${factor}    ${SelectedFactorProductsSuffix}
        ${statusField}=    Run Keyword And Return Status    Wait For Elements State    ${factorPrefix}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${statusField}    msg=Selected Factor Products field "${factor}" is not visible.

        Fill Text    ${factorPrefix}    ${data['SelectedFactors']['${factor}']['products']}
        ${ActualFactor1}=    Get Text    ${factorPrefix}
        Run Keyword And Continue On Failure    Should Be Empty    ${ActualFactor1}    msg=Selected Factor Products field "${factor}" accepted text; expected empty.
    END

# verify the NYUEG Average ratio 
#     [Documentation]    this method for verify the NYUEG Average ratio 
#     [Arguments]    ${Excepted_ratio}
#     Sleep    2s   
#     Scroll To    ${NYUEGAverageRatio}
#     ${Actual_ratio}    Get Text    ${NYUEGAverageRatio}    
#     Log    ${Actual_ratio}
#     Should Be Equal    ${Actual_ratio}    ${Excepted_ratio}    

Verify NYUEG Average Ratio
    [Documentation]    This keyword verifies the NYUEG Average Ratio value on the form.
    [Arguments]    ${Expected_ratio}

    Sleep    2s
    Scroll To    ${NYUEGAverageRatio}

    # Get the actual value
    ${Actual_ratio}    Get Text    ${NYUEGAverageRatio}
    ${Actual_ratio}    Strip String    ${Actual_ratio}    # Remove extra spaces

    Log    Actual NYUEG Average Ratio: ${Actual_ratio}

    # Verify the ratio matches the expected value
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_ratio}    ${Expected_ratio}    msg=NYUEG Average Ratio does not match the expected value


# verify the Slider value in forms tab
#     [Documentation]    This method is used to verify the Slider in forms tab
#     Navigate to Form
#     switch to NY Underwriting Eligibility Guidelines Form 
#     Click    ${SLIDER}
#     # Move slider using arrow keys (repeat as needed)
#     Press Keys    ${SLIDER}    ArrowRight
#     Press Keys    ${SLIDER}    ArrowRight
#     Press Keys    ${SLIDER}    ArrowRight
#     Sleep    1s
#     ${text}=    Get Text    ${DISPLAY}
#     Log    Current slider text: ${text}
#     Run Keyword And Continue On Failure    Should Contain    ${text}    $20,001 – $30,000 (8 points)      
Verify Slider Value in Forms Tab
    [Documentation]    Verify the slider value in Forms tab and check if it is clickable
    [Arguments]    ${ExpectedText}=${EMPTY}

    Navigate to Form
    Switch To NY Underwriting Eligibility Guidelines Form

    # Check if slider is visible and clickable
    ${SliderClickable}=    Run Keyword And Return Status    Wait For Elements State    ${SLIDER}    visible    timeout=5s
    IF    ${SliderClickable}
        Click    ${SLIDER}
        # Move slider using arrow keys
        Press Keys    ${SLIDER}    ArrowRight
        Press Keys    ${SLIDER}    ArrowRight
        Press Keys    ${SLIDER}    ArrowRight

        Sleep    1s

        ${CurrentText}=    Get Text    ${DISPLAY}
        ${CurrentText}=    Strip String    ${CurrentText}
        Log    Current slider text: ${CurrentText}

        ${ExpectedText}=    Set Variable If    '${ExpectedText}'=='${EMPTY}'    $20,001 – $30,000 (8 points)    ${ExpectedText}
        Run Keyword And Continue On Failure    Should Contain    ${CurrentText}    ${ExpectedText}    msg=Slider value does not match expected
    ELSE
        Log    Slider is not clickable or not visible
    END
