*** Settings ***
Resource    ../../config/browser.robot
Variables        ../locators/my_assignments_locators.py

*** Keywords ***
# Verify My Assignments Tab is displayed as a default tab
#     [Documentation]    Verifies that the 'My Assignments' tab is visible and selected by default when the page loads.
#     # Wait For Element With Message    MyAssignments    ${MyAssignments}    visible    MyAssignments is not avilable in All Submission page
#     Wait For Elements State    ${MyAssignments}    visible    timeout=30s
#     Get Element States    ${MyAssignments}    validate    value & visible    'MyAssignments should be visible.'




Verify My Assignments Tab is displayed as a default tab
    [Documentation]    Verifies that the 'My Assignments' tab is visible and selected by default when the page loads.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${MyAssignments}    visible    timeout=30s
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Verify My Assignments Tab: 'My Assignments' tab is not visible on the page.

    ${tab_state}=    Run Keyword And Return Status    Get Element States    ${MyAssignments}    validate    value & visible
    Run Keyword And Continue On Failure    Should Be True    ${tab_state}    msg=Verify My Assignments Tab: 'My Assignments' tab is not in the expected visible state.
