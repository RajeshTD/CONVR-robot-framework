*** Settings ***
Library    Collections
Library    String
Variables    ../locators/users_locators.py
Resource    ../../utils/common_keywords.robot

*** Keywords ***

# Search Client name
#     [Documentation]    Searches for a user by their name in the user management page.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_clientName}`: The name of the client/user to search for.
#     [Arguments]    ${data_clientName}
#     Run Keyword And Continue On Failure    Wait For Element With Message    ClientSearch    ${ClientSearch}    visible    ClientSearch option is not avilable TO Searching the client
#     # Wait For Elements State    ${ClientSearch}    visible
#     Fill Text    ${ClientSearch}    ${data_clientName}
Search Client name
    [Documentation]    Searches for a client/user by name in the User Management page.
    ...    Waits for the search field to be visible, then enters the provided client/user name.
    [Arguments]    ${data_clientName}

    ${search_field_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ClientSearch}    visible    timeout=10s
    Run Keyword And Continue On Failure    Should Be True    ${search_field_visible}    msg=Search Client: Search field not visible on the page. Cannot search for '${data_clientName}'.

    ${text_filled}=    Run Keyword And Return Status    Fill Text    ${ClientSearch}    ${data_clientName}
    Run Keyword And Continue On Failure    Should Be True    ${text_filled}    msg=Search Client: Failed to enter '${data_clientName}' into the search field.

Get values from table header
    [Documentation]    Retrieves the text from the header columns of the users table.
    ...
    ...    *Returns:*
    ...    - A list of the header texts.
    @{headers}    Get Elements    ${TableHeader}
    @{actualHeaderValues}=   Create List
    FOR    ${header}    IN    @{headers}
        ${value}=    Get Text    ${header}
        Log    ${value}
        ${trimValue}=    Strip String    ${value}
        Log    ${trimValue}
        Append To List    ${actualHeaderValues}    ${trimValue}
    END
    RETURN    ${actualHeaderValues}

Get user data from the table
    [Documentation]    Retrieves all data for a specific user from the users table.
    ...    It finds the row corresponding to the user's name and extracts the text from each cell.
    ...
    ...    *Arguments:*
    ...    - `${data_searchUserName}`: The name of the user whose data is to be retrieved.
    ...
    ...    *Returns:*
    ...    - A list of strings containing the user's details from the table.
    [Arguments]    ${data_searchUserName}
    ${userNameToSearch}=    Catenate    SEPARATOR=    ${ClientData}    '    ${data_searchUserName}    ']//ancestor::tr/td
    @{tableData}=    Browser.Get Elements        ${userNameToSearch}
    ${length}=    Get Length    ${tableData}
    @{actualUserDetails}=    Create List
    FOR    ${i}    IN RANGE    0    ${length}
        ${data}=    Get Text    ${tableData}[${i}]
        ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${data}    \n
        IF    ${hasNewLine}
            @{splitValue}=    Split String    ${data}    \n
            ${split}=    Strip String    ${splitValue}[1]
            Append To List    ${actualUserDetails}    ${split}
        ELSE
            ${trimData}=    Strip String    ${data}
            Append To List    ${actualUserDetails}    ${trimData}
        END
    END
    RETURN    ${actualUserDetails}

# Select Impersonate option from the actions
#     [Documentation]    Finds a user and selects the 'Impersonate' option from their actions menu.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_UserEmail}`: The email of the user to impersonate, used to locate the correct action icon.
#     ...    - `${client_name}`: The name of the client/user to search for first.
#     [Arguments]    ${data_UserEmail}    ${client_name}
#     Search Client name    ${client_name}
#     ${ActionIcon}=    Catenate    SEPARATOR=    ${ActionsIcon}    ${data_UserEmail}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    ActionIcon    ${ActionIcon}    visible    ActionIcon is not avilable 
#     # Wait For Elements State    ${ActionIcon}    enabled
#     Click    ${ActionIcon}
#     ${ImpersonateOption}=    Catenate    SEPARATOR=    ${Impersonate}    ${data_UserEmail}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    ImpersonateOption    ${ImpersonateOption}    visible    ImpersonateOption is not avilable 
#     # Wait For Elements State    ${ImpersonateOption}    visible
#     Click    ${ImpersonateOption}
Select Impersonate option from the actions
    [Documentation]    Selects the 'Impersonate' option for a specific user from the Actions menu.
    ...
    ...    *Description:*
    ...    Searches for the specified client/user, locates their corresponding action icon,
    ...    clicks it to open the actions menu, and then selects the 'Impersonate' option.
    ...
    ...    *Arguments:*
    ...    - `${data_UserEmail}`: The email ID of the user whose 'Impersonate' option should be selected.
    ...    - `${client_name}`: The client/user name to search for before performing the action.
    ...
    ...    Each UI action has descriptive failure messages for better debugging.
    [Arguments]    ${data_UserEmail}    ${client_name}

    Search Client name    ${client_name}

    ${ActionIcon}=    Catenate    SEPARATOR=    ${ActionsIcon}    ${data_UserEmail}    ']
    ${action_icon_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ActionIcon}    visible    timeout=15s
    Run Keyword And Continue On Failure    Should Be True    ${action_icon_visible}    msg=Select Impersonate: Action icon for '${data_UserEmail}' not visible on the page.

    ${clicked_action_icon}=    Run Keyword And Return Status    Click    ${ActionIcon}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_action_icon}    msg=Select Impersonate: Unable to click Action icon for '${data_UserEmail}'. It might be disabled or overlapped.

    ${ImpersonateOption}=    Catenate    SEPARATOR=    ${Impersonate}    ${data_UserEmail}    ']
    ${impersonate_option_visible}=    Run Keyword And Return Status    Wait For Elements State    ${ImpersonateOption}    visible    timeout=15s
    Run Keyword And Continue On Failure    Should Be True    ${impersonate_option_visible}    msg=Select Impersonate: 'Impersonate' option not visible for '${data_UserEmail}' after opening the menu.

    ${clicked_impersonate}=    Run Keyword And Return Status    Click    ${ImpersonateOption}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_impersonate}    msg=Select Impersonate: Failed to click on 'Impersonate' option for '${data_UserEmail}'.


# Verify User is already exists
#     [Documentation]    Checks if a user already exists in the users list.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_userName}`: The name of the user to verify.
#     ...
#     ...    *Returns:*
#     ...    - `True` if the user exists, `False` otherwise.
#     [Arguments]    ${data_userName}
#     Search Client name    ${data_userName}
#     ${userNameToSearch}=    Catenate    SEPARATOR=    ${ClientData}    '    ${data_userName}    ']
#     ${user}=    Run Keyword And Return Status    Wait For Elements State    ${userNameToSearch}    visible    timeout=30s
#     RETURN    ${user}
Verify User is already exists
    [Documentation]    Verifies whether a user already exists in the Users list.
    ...    This keyword searches for the provided username and checks if the element appears.
    ...    Returns True if the user exists, otherwise False.
    ...    Each step has a descriptive failure message for better readability.
    [Arguments]    ${data_userName}

    ${searched}=    Run Keyword And Return Status    Search Client name    ${data_userName}
    Run Keyword And Continue On Failure    Should Be True    ${searched}    msg=Verify User: Failed - Unable to perform search for user '${data_userName}' in the Users list.

    ${user_locator}=    Catenate    SEPARATOR=    ${ClientData}    '    ${data_userName}    ']
    ${user_visible}=    Run Keyword And Return Status    Wait For Elements State    ${user_locator}    visible    timeout=30s
    IF    '${user_visible}' == 'True'
        Log Step    "Verify User: '${data_userName}' exists in the Users list."
        RETURN    True
    ELSE
        Log Step    "Verify User: '${data_userName}' not found in the Users list."
        RETURN    False
    END

# Create User If the User is not present
#     [Documentation]    Creates a new user if they do not already exist.
#     ...    It first calls `Verify User is already exists`. If the user is not found, it proceeds to fill out and submit the 'New User' form.
#     ...
#     ...    *Arguments:*
#     ...    - `${user_data}`: A dictionary containing the new user's details (e.g., email, firstName, lastName, clientName, clientRole).
#     [Arguments]    ${user_data}
#     ${userIsPresent}=    Verify User is already exists    ${user_data['search_user']}
#     IF    ${userIsPresent}
#         Log Step    '${user_data["search_user"]} already exists, skipping user creation.'
#     ELSE
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewUserButton    ${NewUserButton}    visible    NewUserButton is not avilable 
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewUserButton    ${NewUserButton}    visible    NewUserButton is  avilable
#         # Wait For Elements State    ${NewUserButton}    visible
#         # Wait For Elements State    ${NewUserButton}    enabled
#         Click    ${NewUserButton}
#         Run Keyword And Continue On Failure    Wait For Element With Message    NewUserForm    ${NewUserForm}    visible    NewUserForm is not avilable 
#         # Wait For Elements State    ${NewUserForm}    visible
#         Fill Text    ${FormEmail}    ${user_data['email']}
#         Fill Text    ${FirstName}    ${user_data['firstName']}
#         Fill Text    ${LastName}    ${user_data['lastName']}
#         Select Options By    ${ClientDropdown}    label    ${user_data['clientName']}
#         Select Options By    ${RoleDropdown}    label    ${user_data['clientRole']}
#         ${selected_client}=    Get Text    select#client >> option:checked
#         ${selected_role}=     Get Text    select#role >> option:checked
#         Should Be Equal    ${selected_client}    ${user_data['clientName']}
#         Should Be Equal    ${selected_role}    ${user_data['clientRole']}
#         Sleep    2s
#         Scroll To Element    ${AddUserButton}
#         Run Keyword And Continue On Failure    Wait For Element With Message    AddUserButton    ${AddUserButton}    visible    AddUserButton is not avilable 
#         # Wait For Elements State    ${AddUserButton}    enabled
#         Click    ${AddUserButton}
#     END

Create User If the User is not present
    [Documentation]    Creates a new user if they do not already exist.
    ...    This keyword first verifies whether the user already exists.
    ...    If not found, it opens the 'New User' form, fills in the details, and submits the form.
    ...    Each step includes a descriptive failure message for easier troubleshooting.
    [Arguments]    ${user_data}

    ${userIsPresent}=    Verify User is already exists    ${user_data['search_user']}
    IF    ${userIsPresent}
        Log Step    "${user_data['search_user']} already exists. Skipping user creation."
    ELSE
        ${new_user_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewUserButton}    visible    10s
        Run Keyword And Continue On Failure    Should Be True    ${new_user_button_visible}    msg=Create User: Failed - 'New User' button not visible on the page.

        ${clicked_new_user}=    Run Keyword And Return Status    Click    ${NewUserButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_new_user}    msg=Create User: Failed - Could not click 'New User' button. Ensure it’s visible and clickable.

        ${new_user_form_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NewUserForm}    visible    10s
        Run Keyword And Continue On Failure    Should Be True    ${new_user_form_visible}    msg=Create User: Failed - 'New User' form did not appear after clicking 'New User' button.

        ${email_filled}=    Run Keyword And Return Status    Fill Text    ${FormEmail}    ${user_data['email']}
        Run Keyword And Continue On Failure    Should Be True    ${email_filled}    msg=Create User: Failed - Unable to enter Email '${user_data["email"]}' into the form.

        ${first_name_filled}=    Run Keyword And Return Status    Fill Text    ${FirstName}    ${user_data['firstName']}
        Run Keyword And Continue On Failure    Should Be True    ${first_name_filled}    msg=Create User: Failed - Unable to enter First Name '${user_data["firstName"]}'.

        ${last_name_filled}=    Run Keyword And Return Status    Fill Text    ${LastName}    ${user_data['lastName']}
        Run Keyword And Continue On Failure    Should Be True    ${last_name_filled}    msg=Create User: Failed - Unable to enter Last Name '${user_data["lastName"]}'.

        ${client_selected}=    Run Keyword And Return Status    Select Options By    ${ClientDropdown}    label    ${user_data['clientName']}
        Run Keyword And Continue On Failure    Should Be True    ${client_selected}    msg=Create User: Failed - Unable to select Client Name '${user_data["clientName"]}' from dropdown.

        ${role_selected}=    Run Keyword And Return Status    Select Options By    ${RoleDropdown}    label    ${user_data['clientRole']}
        Run Keyword And Continue On Failure    Should Be True    ${role_selected}    msg=Create User: Failed - Unable to select Client Role '${user_data["clientRole"]}' from dropdown.

        ${selected_client}=    Get Text    select#client >> option:checked
        ${selected_role}=     Get Text    select#role >> option:checked
        Run Keyword And Continue On Failure    Should Be Equal    ${selected_client}    ${user_data['clientName']}    msg=Create User: Failed - Selected client '${selected_client}' does not match expected '${user_data["clientName"]}'.
        Run Keyword And Continue On Failure    Should Be Equal    ${selected_role}    ${user_data['clientRole']}    msg=Create User: Failed - Selected role '${selected_role}' does not match expected '${user_data["clientRole"]}'.

        Sleep    2s

        ${scrolled}=    Run Keyword And Return Status    Scroll To Element    ${AddUserButton}
        Run Keyword And Continue On Failure    Should Be True    ${scrolled}    msg=Create User: Failed - Unable to scroll to 'Add User' button. Element may not be in view.

        ${add_user_button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${AddUserButton}    visible    10s
        Run Keyword And Continue On Failure    Should Be True    ${add_user_button_visible}    msg=Create User: Failed - 'Add User' button not visible after filling user details.

        ${clicked_add_user}=    Run Keyword And Return Status    Click    ${AddUserButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_add_user}    msg=Create User: Failed - Could not click 'Add User' button. Form submission may not have occurred.
    END
