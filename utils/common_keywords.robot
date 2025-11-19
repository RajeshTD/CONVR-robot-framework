*** Settings ***
Variables     ../resources/locators/logout.py
Variables     ../resources/locators/login_locators.py
Resource      ../config/browser.robot
Resource      ../resources/pages/users_page.robot
Resource      ../resources/pages/login_page.robot
Variables     ../testdata/data.py
Resource      ../resources/pages/my_assignments_page.robot
Resource      ../resources/pages/submissions_page.robot
Resource      ../resources/pages/all_submissions_page.robot
Resource      ../resources/pages/tasks_page.robot
Resource      ../resources/pages/answers_page.robot
Resource      ../resources/pages/tasks_page.robot
Resource      ../resources/pages/email_page.robot
Resource      ../resources/pages/documents_page.robot
Resource      ../resources/pages/risk360_pages.robot
Resource      ../resources/pages/referral_page.robot
Resource      ../resources/pages/lost_page.robot
Resource      ../resources/pages/summary_page.robot
Library       ../libraries/helper.py
# Library        ../libraries/DialogScreenshotListener.py
Resource      ../resources/pages/Forms_page.robot
*** Variables ***
${processing_stage_timeout}    1200s
${upload_procesing_timeout}    1800s
${element_timeout}    30s
${display_timeout}    10s

*** Keywords ***

Logout from application
    ${user}=    Run Keyword And Return Status    Wait For Elements State    ${UserIcon}    visible    timeout=5s
    IF    ${user}
        Click    ${UserIcon}
        Wait For Elements State    ${UserMenu}    visible
        Wait For Elements State    ${Logout}    visible
        Click    ${Logout}
        Wait For Elements State    ${LoginPage}    visible
    END

Log Step
    [Arguments]    ${message}
    Log    ${message}    html=True    console=True    formatter=repr

Create New User if not exists in Users list
    Open Browser and Launch URL
    Login with username and password    ${Login['username']}    ${Login['password']}
    Verify Home Page is Displayed
    Create User If the User is not present    ${NewUser}
    Search Client name    ${NewUser['search_user']}
    Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Verify My Assignments Tab is displayed as a default tab
    Click All submissions option
    ${new_submission_id}=    Create new submission if the submission not exists    ${NewUser['submission_id']}
    RETURN    ${new_submission_id}

# Handle Future Dialogs With Logs And Screenshot
#     [Arguments]    ${action}=accept
#     Log    ⚡ Setting up future dialog handler: ${action}    console=yes
#     Handle Future Dialogs    ${action}
#     ${timestamp}=    Get Time    epoch
#     ${filename}=     Set Variable    dialog_${timestamp}.png
#     Take Screenshot    ${filename}
#     Log    📸 Screenshot taken for future dialog handling: ${filename}    console=yes

Launch URL and Login in to the application
    Open Browser and Launch URL
    Handle Future Dialogs    accept
    Login with username and password    ${Login['username']}    ${Login['password']}
    # Verify Home Page is Displayed

# Wait For Element With Message
#     [Arguments]    ${varName}    ${locator}    ${element_State}    ${Custom_Msg}=''    ${timeout}=${display_timeout}
#     Log To Console    Waiting for element: ${varName} (${locator}) to be ${element_State} within ${timeout}
#     ${status}    ${message}=    Run Keyword And Ignore Error
#     ...    Wait For Elements State    ${locator}    ${element_State}    timeout=${timeout}
#     Run Keyword If    '${status}' == 'FAIL'
#     ...    Fail    Element '${varName}' (${locator}) did not become ${element_State} within ${timeout}. ${Custom_Msg}

Capture Custom Screenshot
    [Arguments]    ${filename}=custom_screenshot.png
    Log To Console    Taking screenshot: ${filename}
    Take Screenshot    ${filename}

Create new Task in Tasks page
    [Arguments]    ${task_data}    ${submission_id}
    Open Browser and Launch URL
    Login with username and password    ${Login['username']}    ${Login['password']}
    Verify Home Page is Displayed
    Search Client name    ${NewUser['search_user']}
    Select Impersonate option from the actions    ${NewUser['email']}    ${NewUser['search_user']}
    Verify My Assignments Tab is displayed as a default tab
    Switch to Tasks if not in Tasks page
    ${new_task_created}=    Create New Task if not    ${task_data}    ${submission_id}
    IF    ${new_task_created}
        ${get_task}=    Get task name
        Update Task Name    ${get_task}
        Navigate To Tasks listing page
        Verify newly created task in tasks listing page    ${get_task}
        ${task_id}=    Get Task ID for the newly created task name    ${get_task}
        RETURN    ${task_id}
    ELSE
        RETURN    ${TC_UI_281['data_task_id']}
    END
