*** Settings ***
Resource   ../../utils/common_keywords.robot
Variables  ../locators/submissions.py
Variables  ../locators/all_submissions.py

*** Keywords ***

# Verify Submissions and Tasks are displayed
#     [Documentation]    Verifies that the main 'Submissions' and 'Tasks' menu items are visible on the side navigation panel.
#     ...
#     ...    *Arguments:*
#     ...    - `@{data_menu}`: A list of menu item names to verify.
#     [Arguments]    @{data_menu}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Search_Submission_Button    ${Search_Submission_Button}    visible    Search_Submission_Button is not avilable in AllSubmission page
#     # Wait For Elements State    ${Search_Submission_Button}    visible
#     FOR    ${menuName}    IN    @{data_menu}
#         ${menu}    Catenate    SEPARATOR=        ${SideMenu}    '    ${menuName}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    menu    ${menu}    visible    menu is not avilable in AllSubmission page
#         # Wait For Elements State    ${menu}    visible
#     END

Verify Submissions and Tasks are displayed
    [Documentation]    Verifies that the main 'Submissions' and 'Tasks' menu items are visible on the side navigation panel.
    ...    @{data_menu} is a list of menu item names to verify.
    [Arguments]    @{data_menu}

    # Ensure the Search Submission button is visible
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Search_Submission_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Search_Submission_Button is not available on the All Submissions page

    # Verify each menu item in the side menu
    FOR    ${menuName}    IN    @{data_menu}
        ${menu}=    Catenate    SEPARATOR=        ${SideMenu}    '    ${menuName}    ']
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${menu}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Menu '${menuName}' is not available on the All Submissions page
    END


# Select Date Filter option
#     [Documentation]    Selects a specific option from the date filter dropdown on the submissions page.
#     ...    It first checks if the desired option is already selected.
#     ...
#     ...    *Arguments:*
#     ...    - `${Date_Options_Value}`: The text of the date filter option to select (e.g., 'Today', 'Last 7 days').
#     [Arguments]    ${Date_Options_Value}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Date_Filter_Options_Button    ${Date_Filter_Options_Button}    visible    Date_Filter_Options_Button is not avilable in AllSubmission page
#     # Wait For Elements State    ${Date_Filter_Options_Button}    visible
#     ${Date_Option_text}    Get Text    ${Date_Filter_Options_Button}
#     IF    '${Date_Option_text}' == '${Date_Options_Value}'
#         Log    Submission Alredy in ${Date_Option_text} option
#     ELSE
#         Click    ${Date_Filter_Options_Button}
#         ${date_options_locator}    Catenate    SEPARATOR=        ${Date_Options}    ${Date_Options_Value}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    date_options_locator    ${date_options_locator}    visible    date_options_locator is not avilable in AllSubmission page
#         # Wait For Elements State    ${date_options_locator}    visible
#         Click    ${date_options_locator}
#     END
Select Date Filter option
    [Documentation]    Selects a specific option from the date filter dropdown on the submissions page.
    ...    Checks if the desired option is already selected; otherwise, selects it.
    [Arguments]    ${Date_Options_Value}

    ${date_filter_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Date_Filter_Options_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${date_filter_visible}    msg=Select Date Filter option: 'Date Filter Options' button is not visible on the submissions page.

    ${current_option}=    Get Text    ${Date_Filter_Options_Button}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${current_option}    msg=Select Date Filter option: Failed to retrieve currently selected date filter option.

    IF    '${current_option}' == '${Date_Options_Value}'
        Log Step    "Select Date Filter option: Submission already in '${Date_Options_Value}' option."
    ELSE
        ${clicked_filter}=    Run Keyword And Return Status    Click    ${Date_Filter_Options_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_filter}    msg=Select Date Filter option: Failed to click 'Date Filter Options' button.

        ${option_locator}=    Catenate    SEPARATOR=    ${Date_Options}    ${Date_Options_Value}    ']
        ${option_visible}=    Run Keyword And Return Status    Wait For Elements State    ${option_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${option_visible}    msg=Select Date Filter option: Option '${Date_Options_Value}' not visible in the dropdown.

        ${clicked_option}=    Run Keyword And Return Status    Click    ${option_locator}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_option}    msg=Select Date Filter option: Failed to select '${Date_Options_Value}' from the date filter dropdown.
    END

# Click All submissions option
#     [Documentation]    Ensures that the 'All submissions' filter is selected on the submissions page.
#     ...    If it's not already selected, it will open the dropdown and click it.
#     # Wait For Elements State    ${Submission_Filter_Options_Button}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submission_Filter_Options_Button    ${Submission_Filter_Options_Button}    visible    Submission_Filter_Options_Button is not avilable in AllSubmission page
#     ${submission_text}    Get Text    ${Submission_Filter_Options_Button}
#     ${Submission_Options_Value}    Set Variable    All submissions
#     IF    '${submission_text}' == '${Submission_Options_Value}'
#         Log    Submission Alredy in All submissions option
#     ELSE
#         Sleep    3s
#         Click    ${Submission_Filter_Options_Button}
#         ${submission_options_text}    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    submission_options_text    ${submission_options_text}    visible    submission_options_text is not avilable in AllSubmission page
#         # Wait For Elements State    ${submission_options_text}    visible
#         Click    ${submission_options_text}
#     END
Click All submissions option
    [Documentation]    Ensures that the 'All submissions' filter is selected on the submissions page.
    ...    If it's not already selected, it will open the dropdown and click it.

    ${filter_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${filter_visible}    msg=Click All submissions option: 'Submission Filter Options' button is not visible on the submissions page.

    ${current_selection}=    Get Text    ${Submission_Filter_Options_Button}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${current_selection}    msg=Click All submissions option: Failed to retrieve currently selected submission filter option.

    ${all_submissions_value}=    Set Variable    Created by me
    IF    '${current_selection}' == '${all_submissions_value}'
        Log Step    "Click All submissions option: Submission already in 'All submissions' option."
    ELSE
        Sleep    3s
        ${clicked_filter}=    Run Keyword And Return Status    Click    ${Submission_Filter_Options_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_filter}    msg=Click All submissions option: Failed to click 'Submission Filter Options' button.

        ${option_locator}=    Catenate    SEPARATOR=    ${Submission_Options}    ${all_submissions_value}    ']
        ${option_visible}=    Run Keyword And Return Status    Wait For Elements State    ${option_locator}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${option_visible}    msg=Click All submissions option: Option 'All submissions' not visible in the dropdown.

        ${clicked_option}=    Run Keyword And Return Status    Click    ${option_locator}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_option}    msg=Click All submissions option: Failed to select 'All submissions' from the filter dropdown.
    END


Click submissions option
    [Documentation]    Selects a specific option from the submission filter dropdown (e.g., 'All submissions', 'Assigned to me').
    ...    It first checks if the desired option is already selected.
    ...
    ...    *Arguments:*
    ...    - `${Submission_Options_Value}`: The text of the submission filter option to select.
    [Arguments]    ${Submission_Options_Value}
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Submission_Filter_Options_Button is not available on the All Submissions page
    # Wait For Elements State    ${Submission_Filter_Options_Button}    visible
    ${submission_text}    Get Text    ${Submission_Filter_Options_Button}
    IF    '${submission_text}' == '${Submission_Options_Value}'
        Log    Submission Alredy in ${Submission_Options_Value} option
    ELSE
        Click    ${Submission_Filter_Options_Button}
        ${submission_options_text}    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']
        ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${submission_options_text}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=submission_options_text is not available on the All Submissions page
        # Wait For Elements State    ${submission_options_text}    visible
        Click    ${submission_options_text}
      
    END

# Rearrange Submission Page Columns
#     [Documentation]    Configures the visible columns on the main submissions table.
#     ...    It first de-selects all columns and then selects only the ones specified.
#     ...
#     ...    *Arguments:*
#     ...    - `@{ColumnNames}`: A list of column header names to be displayed.
#     [Arguments]    @{ColumnNames}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submissions_Page_Columns_Button    ${Submissions_Page_Columns_Button}    visible    Submissions_Page_Columns_Button is not avilable in AllSubmission page
#     # Wait For Elements State    ${Submissions_Page_Columns_Button}
#     Click    ${Submissions_Page_Columns_Button}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submission_Columns_Select_All_Checkbox    ${Submission_Columns_Select_All_Checkbox}    visible    Submission_Columns_Select_All_Checkbox is not avilable in AllSubmission page
#     # Wait For Elements State    ${Submission_Columns_Select_All_Checkbox}
#     Check Checkbox    ${Submission_Columns_Select_All_Checkbox}
#     Uncheck Checkbox    ${Submission_Columns_Select_All_Checkbox}
#     FOR    ${column_name}    IN    @{ColumnNames}
#         ${Column_Locator}    Catenate    SEPARATOR=        ${Submission_Columns_Status_CheckBox}    ${column_name}    ${Submission_Columns_Status_CheckBox_1}
#         Scroll To Element    ${Column_Locator}
#         Run Keyword And Continue On Failure    Wait For Element With Message    Column_Locator    ${Column_Locator}    visible    Column_Locator is not avilable in AllSubmission page
#         # Wait For Elements State    ${Column_Locator}    visible
#         Check Checkbox    ${Column_Locator}
#     END
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submissions_Page_Columns_Button    ${Submissions_Page_Columns_Button}    visible    Submissions_Page_Columns_Button is not avilable in AllSubmission page
#     # Wait For Elements State    ${Submissions_Page_Columns_Button}

#     Click    ${Submissions_Page_Columns_Button}
Rearrange Submission Page Columns
    [Documentation]    Configures the visible columns on the main submissions table.
    ...    It first de-selects all columns and then selects only the ones specified.
    [Arguments]    @{ColumnNames}

    ${button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submissions_Page_Columns_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${button_visible}    msg=Rearrange Submission Page Columns: 'Submissions Page Columns' button is not visible on the submissions page.

    ${clicked_button}=    Run Keyword And Return Status    Click    ${Submissions_Page_Columns_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_button}    msg=Rearrange Submission Page Columns: Failed to click 'Submissions Page Columns' button.

    ${select_all_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Columns_Select_All_Checkbox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${select_all_visible}    msg=Rearrange Submission Page Columns: 'Select All' checkbox for columns is not visible.

    ${checked}=    Run Keyword And Return Status    Check Checkbox    ${Submission_Columns_Select_All_Checkbox}
    Run Keyword And Continue On Failure    Should Be True    ${checked}    msg=Rearrange Submission Page Columns: Failed to check 'Select All' checkbox.

    ${unchecked}=    Run Keyword And Return Status    Uncheck Checkbox    ${Submission_Columns_Select_All_Checkbox}
    Run Keyword And Continue On Failure    Should Be True    ${unchecked}    msg=Rearrange Submission Page Columns: Failed to uncheck 'Select All' checkbox.

    FOR    ${column_name}    IN    @{ColumnNames}
        ${column_locator}=    Catenate    SEPARATOR=        ${Submission_Columns_Status_CheckBox}    ${column_name}    ${Submission_Columns_Status_CheckBox_1}

        ${scroll}=    Run Keyword And Return Status    Scroll To Element    ${column_locator}
        Run Keyword And Continue On Failure    Should Be True    ${scroll}    msg=Rearrange Submission Page Columns: Failed to scroll to column '${column_name}' checkbox.

        ${column_visible}=    Run Keyword And Return Status    Wait For Elements State    ${column_locator}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${column_visible}    msg=Rearrange Submission Page Columns: Column '${column_name}' checkbox not visible.

        ${checked_column}=    Run Keyword And Return Status    Check Checkbox    ${column_locator}
        Run Keyword And Continue On Failure    Should Be True    ${checked_column}    msg=Rearrange Submission Page Columns: Failed to select column '${column_name}' checkbox.
    END

    ${clicked_button_again}=    Run Keyword And Return Status    Click    ${Submissions_Page_Columns_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_button_again}    msg=Rearrange Submission Page Columns: Failed to close 'Submissions Page Columns' menu.


# Click My submissions option
#     [Documentation]    Selects the 'Assigned to me' filter from the submission filter dropdown.
#     ${Submission_Options_Value}    Set Variable    Assigned to me
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submission_Filter_Options_Button    ${Submission_Filter_Options_Button}    visible    Submission_Filter_Options_Button is not avilable in AllSubmission page
#     # Wait For Elements State    ${Submission_Filter_Options_Button}    visible
#     Click    ${Submission_Filter_Options_Button}
#     ${submission_options_text}    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']
#     Run Keyword And Continue On Failure    Wait For Element With Message    submission_options_text    ${submission_options_text}    visible    submission_options_text is not avilable in AllSubmission page
#     # Wait For Elements State    ${submission_options_text}    visible
#     Click    ${submission_options_text}
Click My submissions option
    [Documentation]    Selects the 'Assigned to me' filter from the submission filter dropdown.

    ${Submission_Options_Value}=    Set Variable    Assigned to me

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission Filter Options button not visible'

    ${status}=    Run Keyword And Return Status    Click    ${Submission_Filter_Options_Button}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Submission Filter Options button'

    ${submission_options_text}=    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${submission_options_text}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission options text not visible'

    ${status}=    Run Keyword And Return Status    Click    ${submission_options_text}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click submission options text'


# Click All tasks option
#     [Documentation]    Ensures that the 'All submissions' filter is selected on the submissions page.
#     ...    If it's not already selected, it will open the dropdown and click it.
#     # Wait For Elements State    ${Submission_Filter_Options_Button}    visible    5s
#     Run Keyword And Continue On Failure    Wait For Element With Message    Submission_Filter_Options_Button    ${Submission_Filter_Options_Button}    visible    Submission_Filter_Options_Button is not avilable in AllSubmission page
#     ${submission_text}    Get Text    ${Submission_Filter_Options_Button}
#     ${Submission_Options_Value}    Set Variable    All tasks    
#     IF    '${submission_text}' == '${Submission_Options_Value}'
#         Log    All tasks
#     ELSE
#         Sleep    3s
#         Run Keyword And Continue On Failure    Wait For Element With Message    Submission_Filter_Options_Button    ${Submission_Filter_Options_Button}    visible    Submission_Filter_Options_Button is not avilable in AllSubmission page
#         # Wait For Elements State    ${Submission_Filter_Options_Button}    visible    5s
#         Click    ${Submission_Filter_Options_Button}
#         ${submission_options_text}    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    submission_options_text    ${submission_options_text}    visible    submission_options_text is not avilable in AllSubmission page
#         #  Wait For Elements State    ${submission_options_text}    visible    5s
#          Click    ${submission_options_text}
#     END  
select the Options as per given data in Submission page
    [Documentation]    Ensures that the 'All submissions' filter is selected on the submissions page.
    ...    If it's not already selected, it will open the dropdown and click it.
    [Arguments]    ${Submission_Options_Value}
    ${filter_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${filter_visible}    msg=Click All submissions option: 'Submission Filter Options' button is not visible on the submissions page.

    ${current_selection}=    Get Text    ${Submission_Filter_Options_Button}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${current_selection}    msg=Click All submissions option: Failed to retrieve currently selected submission filter option.

    ${all_submissions_value}=    Set Variable    ${Submission_Options_Value}
    IF    '${current_selection}' == '${all_submissions_value}'
        Log Step    "Click All submissions option: Submission already in '${Submission_Options_Value}' option."
    ELSE
        Sleep    3s
        ${clicked_filter}=    Run Keyword And Return Status    Click    ${Submission_Filter_Options_Button}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_filter}    msg=Click ${Submission_Options_Value} option: Failed to click 'Submission Filter Options' button.

        ${option_locator}=    Catenate    SEPARATOR=    ${Submission_Options}    ${all_submissions_value}    ']
        ${option_visible}=    Run Keyword And Return Status    Wait For Elements State    ${option_locator}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${option_visible}    msg=Click ${Submission_Options_Value}: Option '${Submission_Options_Value}' not visible in the dropdown.

        ${clicked_option}=    Run Keyword And Return Status    Click    ${option_locator}
        Run Keyword And Continue On Failure    Should Be True    ${clicked_option}    msg=Click ${Submission_Options_Value} option: Failed to select '${Submission_Options_Value}' from the filter dropdown.
    END
Click All tasks option
    [Documentation]    Ensures that the 'All tasks' filter is selected on the submissions page.
    ...    If it's not already selected, it will open the dropdown and click it.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission Filter Options button not visible'

    ${submission_text}=    Get Text    ${Submission_Filter_Options_Button}
    ${Submission_Options_Value}=    Set Variable    All tasks

    IF    '${submission_text}' == '${Submission_Options_Value}'
        Log    'All tasks is already selected'
    ELSE
        Sleep    3s
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Filter_Options_Button}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission Filter Options button not visible'

        ${status}=    Run Keyword And Return Status    Click    ${Submission_Filter_Options_Button}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click Submission Filter Options button'

        ${submission_options_text}=    Catenate    SEPARATOR=        ${Submission_Options}    ${Submission_Options_Value}    ']

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${submission_options_text}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Submission options text not visible'

        ${status}=    Run Keyword And Return Status    Click    ${submission_options_text}
        Run Keyword And Continue On Failure    Should Be True    ${status}    'Failed to click submission options text'
    END
Get the length of the created task in the Convr Task Tab
    [Documentation]    Gets the length of the created task in the Convr Task Tab.
    # [Arguments]    ${ColumnNames} 
    select the Options as per given data in Submission page    Created by me 
    Sleep    2
    ${Created_Task}    Get Elements    ${Convr_cell_column}
    ${Created_Task_length}    Get Length    ${Created_Task}
    Log    ${Created_Task_length}
    RETURN    ${Created_Task_length}
Get the length of the Assigned task in the Convr Task Tab
        [Documentation]    Gets the length of the created task in the Convr Task Tab.
    # [Arguments]    ${ColumnNames} 
    select the Options as per given data in Submission page    Assigned to me  
    Sleep    2s
    ${Assigned_Task}    Get Elements    ${Convr_cell_column}
    ${Assigned_Task_length}    Get Length    ${Assigned_Task}
    Log    ${Assigned_Task_length}
    RETURN    ${Assigned_Task_length}


Verify the created task data reflected in Convr Task submission page
    [Documentation]    Verifies that the created task data is reflected in the Convr submission page.
    [Arguments]    ${expected_Header}
    ${Excepted_Task_detials}    Create List
    ${status}    Run Keyword And Return Status    Wait For Elements State    ${Convr_cell_column}    visible    ${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Convr submission
    FOR    ${Column_header}    IN    @{expected_Header}
        ${column_locator}=    Catenate    SEPARATOR=        ${Convr_cell_value}    ${Column_header}    ${Convr_cell_value_suffix}
        Wait For Elements State    ${column_locator}    visible    ${element_timeout}
        ${cell_text}=    Get Text    ${column_locator}
        ${cell_text}    Strip String    ${cell_text}
        Log    ${cell_text}
        Append To List    ${Excepted_Task_detials}    ${cell_text}
    END
    Log    ${Excepted_Task_detials}
Verify that Detials should be Hidden
    [Documentation]    Verifies that specific details are hidden on the submissions page.
    [Arguments]    ${ColumnNames}

    ${button_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submissions_Page_Columns_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${button_visible}    msg=Rearrange Submission Page Columns: 'Submissions Page Columns' button is not visible on the submissions page.

    ${clicked_button}=    Run Keyword And Return Status    Click    ${Submissions_Page_Columns_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_button}    msg=Rearrange Submission Page Columns: Failed to click 'Submissions Page Columns' button.
    Sleep   2s
    ${select_all_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Submission_Columns_Select_All_Checkbox}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${select_all_visible}    msg=Rearrange Submission Page Columns: 'Select All' checkbox for columns is not visible.

    ${column_locator}=    Catenate    SEPARATOR=        ${Submission_Columns_Status_CheckBox}    ${ColumnNames}    ${Submission_Columns_Status_CheckBox_1}

    ${scroll}=    Run Keyword And Return Status    Scroll To Element    ${column_locator}
    Run Keyword And Continue On Failure    Should Be True    ${scroll}    msg=Rearrange Submission Page Columns: Failed to scroll to column '${ColumnNames}' checkbox.

    ${column_visible}=    Run Keyword And Return Status    Wait For Elements State    ${column_locator}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${column_visible}    msg=Rearrange Submission Page Columns: Column '${ColumnNames}' checkbox not visible.
    ${state}    Get Checkbox State    ${column_locator}
    Log    ${state}
    ${status}    Run Keyword And Return Status    Should Not Be True    ${state}
    Should Be True    ${status}    By default Details column should be Hidden but its not hidden is visible on Convr Task Page
    # IF    '${state}' == 'True'
    # ${checked_column}=    Run Keyword And Return Status    Check Checkbox    ${column_locator}
    # Run Keyword And Continue On Failure    Should Be True    ${checked_column}    msg=Rearrange Submission Page Columns: Failed to select column '${ColumnNames}' checkbox.
    # END
    ${clicked_button_again}=    Run Keyword And Return Status    Click    ${Submissions_Page_Columns_Button}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_button_again}    msg=Rearrange Submission Page Columns: Failed to close 'Submissions Page Columns' menu.
    ${status}    Run Keyword And Return    Wait For Elements State    ${Convr_detials_field}    hidden    timeout=5s
    Should Be True    ${status}    Details column is not hidden on Convr Task Page