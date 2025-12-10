*** Settings ***
Library    String
Library    Collections
Variables  ../locators/lost_locators.py
Resource   ../../utils/common_keywords.robot

*** Keywords ***

# Lost Submission
#     [Arguments]    ${data}
#     Get Element States    ${Lost}    validate    value & visible
#     Click    ${Lost}
#     Run Keyword And Continue On Failure    Wait For Element With Message    LostUpdateWorkflowStage    ${LostUpdateWorkflowStage}    visible    LostUpdateWorkflowStage is not avilable in Lostsubmission
#     # Wait For Elements State    ${LostUpdateWorkflowStage}    visible
#     FOR    ${reason}    IN    @{data['Reasons']}
#         ${reasonCheckbox}    Catenate    SEPARATOR=    ${LostReason1}    ${reason}    ${LostReason2}    
#         Check Checkbox    ${reasonCheckbox}
#     END
#     Fill Text    ${LostDetails}    ${data['details']}
#     Get Element States    ${LostAcceptButton}    validate    value & enabled
#     Click    ${LostAcceptButton}
#     Wait For Processing Stage

Lost Submission
    [Documentation]    Marks a submission as Lost with given reasons and details, then accepts.
    [Arguments]    ${data}

    # Check Lost button visibility and click
    ${status}=    Run Keyword And Return Status    Get Element States    ${Lost}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Lost button is not visible'
    ${clicked}=    Run Keyword And Return Status    Click    ${Lost}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Lost button'

    # Wait for workflow stage
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${LostUpdateWorkflowStage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Lost update workflow stage not visible'

    # Select reasons
    FOR    ${reason}    IN    @{data['Reasons']}
        ${reasonCheckbox}=    Catenate    SEPARATOR=    ${LostReason1}    ${reason}    ${LostReason2}
        ${checked}=    Run Keyword And Return Status    Check Checkbox    ${reasonCheckbox}
        Run Keyword And Continue On Failure    Should Be True    ${checked}    'Failed to check reason: ${reason}'
    END

    # Fill lost details
    ${filled}=    Run Keyword And Return Status    Fill Text    ${LostDetails}    ${data['details']}
    Run Keyword And Continue On Failure    Should Be True    ${filled}    'Failed to fill Lost details'

    # Click accept
    ${status}=    Run Keyword And Return Status    Get Element States    ${LostAcceptButton}    validate    value & enabled
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Lost Accept button is not visible or enabled'

    ${clicked}=    Run Keyword And Return Status    Click    ${LostAcceptButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    'Failed to click Lost Accept button'

    Wait For Processing Stage


# Verify lost Tagname
#     Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
#     ${status}    Run Keyword And Return Status    Get Element States    ${LostTag}    validate    value & visible
#     IF    ${status}
#     Get Element States    ${LostTag}    validate    value & visible    'LostTag should be visible.'
#     ELSE
#     Switch to Documents
#     Get Element States    ${LostTag}    validate    value & visible    'LostTag should be visible.'
#     END
Verify Lost Tagname
    [Documentation]    Verifies that the Lost tag is displayed. Switches to Documents tab if not visible initially.

    # Verify Reactive element is visible
    ${status_reactive}=    Run Keyword And Return Status    Get Element States    ${Reactive}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${status_reactive}    'Reactive should be visible.'

    # Verify Lost tag visibility
    ${status_lost}=    Run Keyword And Return Status    Get Element States    ${LostTag}    validate    value & visible
    IF    ${status_lost}
        Log    'LostTag is visible on current tab.'
    ELSE
        # Switch to Documents tab and check again
        Switch To Documents
        ${status_lost2}=    Run Keyword And Return Status    Get Element States    ${LostTag}    validate    value & visible
        Run Keyword And Continue On Failure    Should Be True    ${status_lost2}    'LostTag should be visible after switching to Documents tab.'
    END

Cancelled the Submission
    [Documentation]    This method is used to cancel the submission from documents tab
    [Arguments]    ${data}
    Click Answers Tab
    Switch To Documents
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Cancelled}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Cancelled button is not visible in Documents tab'    
    ${status}    Run Keyword And Return Status    Click    ${Cancelled}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Cancelled button in Documents tab'

    ${status}    Run Keyword And Return Status    Wait For Elements State    ${CancelledHeader}    visible    ${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Cancelled Submission header is not visible'
    ${header}    Get Text    ${CancelledHeader}
    Log    ${header}
    Log    ${data['Header']}
    ${status}    Run Keyword And Return Status    Should Be Equal    ${header}    ${data['Header']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Cancelled Submission header text is not matching Act:${header} & Exp:${data['Header']}'
    ${label}    Get Elements    ${Cancelledlabel}
    ${Actual_label}    Create List    
    FOR    ${element}    IN    @{label}
        ${Text}    Get Text    ${element}
        Strip String    ${Text}
        Append To List    ${Actual_label}    ${Text}
    END
    Log    ${Actual_label}
    ${Status}    Run Keyword And Return Status    Lists Should Be Equal    ${Actual_label}    ${data['Labels']}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    'Cancelled Submission labels are not matching'
    
    # ${status}    Run Keyword And Return Status    Wait For Elements State    ${Cancelled_SubmitButton}    visible    ${display_timeout}
    # Run Keyword    Should Be True    ${status}    'Cancelled_SubmitButton is not visible'
    # ${status}    Run Keyword And Return Status    Click    ${Cancelled_SubmitButton}    
    # Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Cancelled_SubmitButton
    # ${locator}    Get Elements    ${Cancelled_Popup}
    # ${Actual_popup}    Create List
    # FOR    ${element}    IN    @{locator}
    #     ${popup}    Get Text    ${element}
    #     Strip String    ${popup}
    #     Append To List    ${Actual_popup}    ${popup}
    # END
    # Log    ${Actual_popup}
    # Log    ${data['Excepted_popup']}
    # ${Status}    Run Keyword And Return Status    Lists Should Be Equal    ${Actual_popup}    ${data['Excepted_popup']}
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Detials_input}    visible    ${display_timeout}
    Run Keyword    Should Be True    ${status}    'Details input box is not visible'
    ${status}    Run Keyword And Return Status    Fill Text    ${Detials_input}    ${data['Reason']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to fill Details input box'

    # ${status}    Run Keyword And Return Status    Wait For Elements State    ${Cancelled_SubmitButton}    visible    ${display_timeout}
    # Run Keyword    Should Be True    ${status}    'Cancelled_SubmitButton is not visible'
    # ${status}    Run Keyword And Return Status    Click    ${Cancelled_SubmitButton}    
    # Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Cancelled_SubmitButton
    # ${popup}    Get Text    ${Cancelled_Popup}
    # Strip String    ${popup}
    # Log    ${popup}
    # Run Keyword And Continue On Failure    Should Be Equal    ${popup}    ${data['Excepted_datepopup']}
    ${clicked}=    Run Keyword And Return Status    Click    ${Cancelled_effectiveDate}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click 'Needed By Date' field to open date picker

    # ${day}=    Get Current Day Number
    # ${actualCurrentDate}=    Convert To Integer    ${day}
    # ${currentdate}=    Catenate    SEPARATOR=    ${PIFGeneralDateSelect}    ${actualCurrentDate}    '])[1]

    # ${status}=    Run Keyword And Return Status    Wait For Elements State    ${currentdate}    visible    timeout=${display_timeout}
    # Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Expected date option for Needed By Date (${actualCurrentDate}) not visible within ${element_timeout}s

    # ${clicked}=    Run Keyword And Return Status    Click    ${currentdate}
    # Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to select the calculated Needed By Date (${actualCurrentDate})
    # Wait For Processing Stage    ""
    # Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
    # ${today}=    Get Time    result_format=%Y-%m-%d
    # Evaluate    document.querySelector('input[type="date"]').value = "${today}";
    
    # ${today}=    Get Time    result_format=%Y-%m-%d
    # Evaluate JavaScript    document.querySelector('input[type="date"]').value = "${today}";


    ${data_due_date}=    Get Current Date    result_format=%Y-%m-%d
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Cancelled_effectiveDate}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'DueDate' field is not visible while creating the task.
    Fill Text    ${Cancelled_effectiveDate}    ${data_due_date}
    # ${status}=    Run Keyword And Return Status    Evaluate JavaScript    ${Cancelled_effectiveDate}    (el) => { el.value = "${data_due_date}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
    # Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to set the due date/time.

    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Cancelled_SubmitButton}    visible    ${display_timeout}
    Run Keyword    Should Be True    ${status}    'Cancelled_SubmitButton is not visible'
    ${status}    Run Keyword And Return Status    Click    ${Cancelled_SubmitButton}    
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Cancelled_SubmitButton
    Switch To Documents
    Wait For Processing Stage    ""
    Get Element States    ${Reactive}    validate    value & visible    'Reactive should be visible.'
    ${date}    Create List
    # ${data_due_date}=    Get Current Date    result_format=%Y-%m-%d
    # ${expected_norm}=    Convert Date    ${data_due_date}    result_format=%Y-%m-%d    date_format=%m/%d/%Y
    ${expected_norm}=    Convert Date    2025-12-10    date_format=%Y-%m-%d    result_format=%m/%d/%Y

    Append To List    ${date}    ${expected_norm}
    RETURN    ${date}
    
    