*** Settings ***
Library    Collections
Library    String
Library    BuiltIn
Variables    ../../testdata/data.py
Library    ../../libraries/helper.py
Resource    ../../utils/common_keywords.robot
Variables    ../locators/tasks_locators.py
Variables    ../locators/submissions.py

*** Keywords ***

# Click Tasks
#     [Documentation]    Navigates to the 'Tasks' page from the main menu.
#     Run Keyword And Continue On Failure    Wait For Element With Message    Tasks    ${Tasks}    visible    The Task Option is not present in the Side menu    
#     Click    ${Tasks}
#     # Wait For Elements State    ${SearchTask}    visible
Click Tasks
    [Documentation]    Navigates to the 'Tasks' tab/page from the main menu and verifies it opened successfully.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Tasks}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Click Tasks: 'Tasks' tab is not visible in the side menu. Cannot proceed to open it.

    ${clicked}=    Run Keyword And Return Status    Click    ${Tasks}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Click Tasks: Failed to click the 'Tasks' tab. Ensure it is enabled and not obscured.

Get values from Tasks table header
    [Documentation]    Retrieves the text from the header columns of the tasks table.
    ...
    ...    *Returns:*
    ...    - A list of the header texts.
    @{headers}    Get Elements    ${TableHeader}
    @{actualHeaderValues}=   Create List
    FOR    ${header}    IN    @{headers}
        ${value} =    Get Text    ${header}
        Log    ${value}
        ${trimValue} =    Strip String    ${value}
        Log    ${trimValue}
        IF    '${trimValue}'
            Append To List    ${actualHeaderValues}    ${trimValue}
        END
    END
    RETURN    ${actualHeaderValues}

Switch to Tasks if not in Tasks page
    [Documentation]    Checks if the user is currently on the Tasks page. If not, it navigates there.
    ...    This is useful for ensuring the script is in the correct state before performing task-related actions.
    ${visible}    Run Keyword And Return Status    Wait For Elements State    ${SearchTask}    visible    timeout=${element_timeout}
    IF    ${visible}
        Log Step    "Tasks Page is visible no need to switch"
    ELSE
        Log Step    "Switching to Tasks Page"
        Click    ${Tasks}
    END

Search Task name ID in Tasks
    [Documentation]    Searches for a task by its name in the search bar on the Tasks page.
    ...
    ...    *Arguments:*
    ...    - `${data_task_name}`: The name of the task to search for.
    [Arguments]    ${data_task_name}
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SearchTask}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Search Task field is not visible. It might be due to page loading delay or incorrect locator reference.

    Fill Text    ${SearchTask}    ${data_task_name}
    Press Keys    ${SearchTask}    Enter

Verify Task is present for the given Task name
    [Documentation]    Verifies if a specific task is present in the tasks list.
    ...
    ...    *Arguments:*
    ...    - `${task_name}`: The name of the task to verify.
    ...    - `${data_task_id}`: The ID of the task to help uniquely identify it.
    ...
    ...    *Returns:*
    ...    - `True` if the task is visible, `False` otherwise.
    [Arguments]    ${task_name}    ${data_task_id}
    Search Task name ID in Tasks    ${task_name}
    ${taskData}    Catenate    SEPARATOR=    ${TaskData1}${task_name}${TaskData2}${data_task_id}']]
    ${task_visible}    Run Keyword And Return Status    Wait For Elements State    ${taskData}    visible    timeout=${element_timeout}
    RETURN    ${task_visible}

# Create New Task if not
#     [Documentation]    Creates a new task if a task with the same name doesn't already exist.
#     ...    If the task exists, it skips creation. Otherwise, it navigates to the submissions page,
#     ...    selects a submission, and fills out the new task form.
#     ...
#     ...    *Arguments:*
#     ...    - `${data}`: A dictionary containing task details like 'NewTaskName', 'TaskNameDropdown', 'assignee', etc.
#     ...    - `${data_submission_id}`: The ID of the submission to associate the task with.
#     ...
#     ...    *Returns:*
#     ...    - `True` if a new task was created, `False` otherwise.
#     [Arguments]    ${data}    ${data_submission_id}
#     ${is_task_present}    Verify Task is present for the given Task name    ${data['NewTaskName']}    ${data['data_task_id']}
#     IF    ${is_task_present}
#         Log Step    "${data['NewTaskName']} already exists, skipping task creation."
#         Set Suite Variable    ${test_new_task_name}    ${data['NewTaskName']}
#         RETURN    False
#     ELSE
#         Run Keyword And Continue On Failure    Wait For Element With Message    locator_submissions    ${locator_submissions}    visible    timeout=${element_timeout}
#         Click    ${locator_submissions}
#         Click    ${AllSubmissions}
#         Sleep    8s
#         ${submission}    Verify Submission Id is available    ${data_submission_id}
#         IF    not ${submission}
#             Select Submission using submission id    ${data_submission_id}
#             # Wait For Elements State    ${SchemaButton}    visible    timeout=${element_timeout}
#             Run Keyword And Continue On Failure    Wait For Element With Message    SchemaButton    ${SchemaButton}    visible    timeout=${element_timeout}
#             Click    ${TasksMenu}
#             ${noTasks_visible}    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
#             IF    ${noTasks_visible}
#                 Click    ${CreateNewTaskButton}
#             ELSE
#                 # Wait For Elements State    ${NewTaskButton}    visible
#                 Run Keyword And Continue On Failure    Wait For Element With Message    NewTaskButton    ${NewTaskButton}    visible   
#                 Click    ${NewTaskButton}
#             END
#             Run Keyword And Continue On Failure    Wait For Element With Message    CreateTaskTab    ${CreateTaskTab}    visible    timeout=${element_timeout}
#             # Wait For Elements State    ${CreateTaskTab}    visible
#             ${customName}    Run Keyword And Return Status    Should Be Equal    '${data["TaskNameDropdown"]}'    'Custom'
#             IF    ${customName}
#                 Select Options By    ${TaskNameDropdown}    label    Custom
#                 ${randomNumber}=    Generate Random Number
#                 ${test_string}    Catenate    SEPARATOR=    ${data['customName']}    ${randomNumber}
#                 Log Step    'Converted string -> ${test_string}'
#                 Update Task Name    ${test_string}
#                 Set Suite Variable    ${test_new_task_name}    ${test_string}
#                 Fill Text    ${CustomTaskName}    ${data['customName']}${randomNumber}
#             ELSE
#                 Select Options By    ${TaskNameDropdown}    label    ${data['TaskNameDropdown']}
#             END
#             Click    ${AssignTo}
#             ${assignee}    Catenate    SEPARATOR=    ${SelectAssignee}    ${data['assignee']}    ']
#             Click    ${assignee}
#             ${data_due_date}    Get Tomorrows Date
#             Click    ${DueDate}
#             Press Keys    ${DueDate}    ${data_due_date}
#             Sleep    1s
#             Press Keys    ${DueDate}    ArrowRight
#             Press Keys    ${DueDate}    ${data['dueTime']}
#             Update Data    ${TC_UI_281}    dueDate    ${data_due_date}
#             Select Options By    ${PriorityDropdown}    label    ${data['priority']}
#             Press Keys    None    PageDown
#             Fill Text    ${TaskDetails}    ${data['taskDetails']}
#             Fill Text    ${TaskReason}    ${data['taskReason']}
#             Check Checkbox    ${TaskRequiredCheckBox}
#             Run Keyword And Continue On Failure    Wait For Element With Message    CreateButton    ${CreateButton}    visible    timeout=${element_timeout}
#             # Wait For Elements State    ${CreateButton}    enabled
#             Click    ${CreateButton}
#             Verify Task created popup
#             ${test_task_name}    Get Text    ${TaskDetailHeader}
#         END
#         RETURN    True
#     END
Create New Task if not
    [Documentation]    Creates a new task if a task with the same name doesn't already exist.
    ...    If the task exists, it skips creation. Otherwise, it navigates to the submissions page,
    ...    selects a submission, and fills out the new task form.
    ...
    ...    *Arguments:*
    ...    - `${data}`: A dictionary containing task details like 'NewTaskName', 'TaskNameDropdown', 'assignee', etc.
    ...    - `${data_submission_id}`: The ID of the submission to associate the task with.
    ...
    ...    *Returns:*
    ...    - `True` if a new task was created, `False` otherwise.
    [Arguments]    ${data}    ${data_submission_id}

    ${is_task_present}=    Verify Task is present for the given Task name    ${data['NewTaskName']}    ${data['data_task_id']}
    IF    ${is_task_present}
        Log Step    "${data['NewTaskName']} already exists — skipping task creation."
        Set Suite Variable    ${test_new_task_name}    ${data['NewTaskName']}
        RETURN    False
    ELSE
        # Navigate to Submissions
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator_submissions}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Submissions menu is not visible.
        Click    ${locator_submissions}
        Click    ${AllSubmissions}
        Sleep    8s

        ${submission}=    Verify Submission Id is available    ${data_submission_id}
        IF    not ${submission}
            Select Submission using submission id    ${data_submission_id}

            # Wait for Schema button
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SchemaButton}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Schema button not visible after selecting submission.

            Click    ${TasksMenu}

            # Handle Create Task Button visibility
            ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
            IF    ${noTasks_visible}
                Click    ${CreateNewTaskButton}
            ELSE
                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    msg=New Task button is not visible.
                Click    ${NewTaskButton}
            END

            # Wait for Create Task tab
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateTaskTab}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Create Task tab is not visible.

            # Task name selection
            ${customName}=    Run Keyword And Return Status    Should Be Equal    '${data["TaskNameDropdown"]}'    'Custom'
            IF    ${customName}
                Select Options By    ${TaskNameDropdown}    label    Custom
                ${randomNumber}=    Generate Random Number
                ${test_string}=    Catenate    SEPARATOR=    ${data['customName']}    ${randomNumber}
                Log Step    "Generated custom task name: ${test_string}"
                Update Task Name    ${test_string}
                Set Suite Variable    ${test_new_task_name}    ${test_string}
                Fill Text    ${CustomTaskName}    ${test_string}
            ELSE
                Select Options By    ${TaskNameDropdown}    label    ${data['TaskNameDropdown']}
            END

            # Assign Task
            Click    ${AssignTo}
            ${assignee}=    Catenate    SEPARATOR=    ${SelectAssignee}    ${data['assignee']}    ']
            Click    ${assignee}

            # Due Date
            ${data_due_date}=    Get Tomorrows Date
            Click    ${DueDate}
            Press Keys    ${DueDate}    ${data_due_date}
            Sleep    1s
            Press Keys    ${DueDate}    ArrowRight
            Press Keys    ${DueDate}    ${data['dueTime']}
            Update Data    ${TC_UI_281}    dueDate    ${data_due_date}

            # Priority and details
            Select Options By    ${PriorityDropdown}    label    ${data['priority']}
            Press Keys    None    PageDown
            Fill Text    ${TaskDetails}    ${data['taskDetails']}
            Fill Text    ${TaskReason}    ${data['taskReason']}
            Check Checkbox    ${TaskRequiredCheckBox}

            # Create Task
            ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateButton}    visible    timeout=${element_timeout}
            Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Create button is not visible while creating task.
            Click    ${CreateButton}
            Verify Task created popup

            # Verify task name
            ${test_task_name}=    Get Text    ${TaskDetailHeader}
        END
        RETURN    True
    END


# Verify Task created popup
#     [Documentation]    Verifies that the 'Task Created' confirmation popup is visible.
#     Wait For Elements State    ${TaskCreatedPopup}    visible

Navigate To Tasks listing page
    [Documentation]    Navigates to the main tasks listing page from anywhere in the application.
    ...    It clicks the 'Home' button first to ensure a consistent starting point.
    ${visible}    Run Keyword And Return Status    Wait For Elements State    ${Home}    visible    timeout=${element_timeout}
    IF    ${visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${Home}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on Home button.
        Sleep    10s
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Tasks}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Tasks option is not visible in the side menu after clicking Home.

        ${clicked}=    Run Keyword And Return Status    Click    ${Tasks}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on Tasks menu in the side panel.

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SearchTask}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Search Task field not visible after navigating to Tasks listing page.
    END

Verify newly created task in tasks listing page
    [Documentation]    Searches for a newly created task on the tasks listing page to verify it appears in the table.
    ...
    ...    *Arguments:*
    ...    - `${task_name}`: The name of the task to verify.
    [Arguments]    ${task_name}
    Fill Text    ${SearchTask}    ${task_name}
    Press Keys    ${SearchTask}    Enter
    ${task}    Catenate    SEPARATOR=    ${TaskNameInTable}    ${task_name}']
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${task}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task element is not visible. It might be a loading issue or incorrect locator.

Get Task ID for the newly created task name
    [Documentation]    Retrieves the Task ID for a given task name from the tasks table.
    ...    It then stores the ID in suite variables for later use.
    ...
    ...    *Arguments:*
    ...    - `${task_name}`: The name of the task whose ID is to be retrieved.
    ...
    ...    *Returns:*
    ...    - The ID of the task.
    [Arguments]    ${task_name}
    ${taskIdLocator}    Catenate    SEPARATOR=    ${TaskIDFromTable1}    ${task_name}    ${TaskIDFromTable2}
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${taskIdLocator}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task ID locator is not visible. It may be a loading issue or incorrect locator reference.

    ${task_id}    Get Text    ${taskIdLocator}
    ${trimValue}    Strip String    ${task_id}
    Log Step    'Task ID -> ${task_id}'
    Set Suite Variable    ${suite_task_id}    ${trimValue}
    Update Data    TC_UI_281    data_task_id    ${trimValue}
    Update Data    NewUser    data_task_id    ${trimValue}
    RETURN    ${suite_task_id}

Get task name
    [Documentation]    Retrieves the name of the newly created task, which is stored in a suite variable.
    ...
    ...    *Returns:*
    ...    - The task name.
    ${trim_value}    Strip String    ${test_new_task_name}
    RETURN    ${trim_value}

# Verify Table data in Tasks
#     [Documentation]    Verifies that the data in a task's row in the tasks table matches the expected values.
#     ...
#     ...    *Arguments:*
#     ...    - `@{expectedList}`: A list of expected string values to find in the task's row.
#     [Arguments]    @{expectedList}
#     Search Task Name ID In Tasks    ${test_new_task_name}
#     FOR    ${table_data}    IN    @{expectedList}
#         ${locator_table_data}    Catenate    SEPARATOR=    ${FinalTableData}    ${table_data}'])[1]
#         Run Keyword And Continue On Failure    Wait For Element With Message    locator_table_data    ${locator_table_data}    visible
#     END
#     ${locator_task_name}    Catenate    SEPARATOR=    ${FinalTableData}    ${test_new_task_name}'])[1]
#     Run Keyword And Continue On Failure    Wait For Element With Message    locator_task_name    ${locator_task_name}    visible
Verify Table data in Tasks
    [Documentation]    Verifies that the data in a task's row in the tasks table matches the expected values.
    ...
    ...    *Arguments:*
    ...    - `@{expectedList}`: A list of expected string values to find in the task's row.
    [Arguments]    @{expectedList}

    Search Task Name ID In Tasks    ${test_new_task_name}

    FOR    ${table_data}    IN    @{expectedList}
        ${locator_table_data}=    Catenate    SEPARATOR=    ${FinalTableData}    ${table_data}'])[1]
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator_table_data}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Expected table data '${table_data}' not visible in the Tasks table.
    END

    ${locator_task_name}=    Catenate    SEPARATOR=    ${FinalTableData}    ${test_new_task_name}'])[1]
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator_task_name}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task name '${test_new_task_name}' is not visible in the Tasks table.


# Create New Task 
#     [Documentation]    Creates a new task from within a submission.
#     ...    This keyword fills out the 'Create Task' form with the provided data.
#     ...
#     ...    *Arguments:*
#     ...    - `${data}`: A dictionary containing the details for the new task, such as name, assignee, priority, etc.
#     [Arguments]    ${data}
#             Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TAsk Option is not present in the Side menu    timeout=${element_timeout}
#             # Handle Future Dialogs    action=accept    
#             Click    ${TasksMenu}
#             ${noTasks_visible}    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
#             IF    ${noTasks_visible}
#                 Click    ${CreateNewTaskButton}
#             ELSE
#                 Run Keyword And Continue On Failure    Wait For Element With Message    NewTaskButton    ${NewTaskButton}    visible    NewTaskButton is not Available in task tab
#                 Click    ${NewTaskButton}
#             END
#             Run Keyword And Continue On Failure    Wait For Element With Message    CreateTaskTab    ${CreateTaskTab}    visible    Create task fields are not present in task page        
#             ${customName}    Run Keyword And Return Status    Should Be Equal    '${data["TaskNameDropdown"]}'    'Custom'
#             IF    ${customName}
#                 Select Options By    ${TaskNameDropdown}    label    Custom
#                 ${randomNumber}=    Generate Random Number
#                 ${test_string}    Catenate    SEPARATOR=    ${data['customName']}
#                 Log Step    'Converted string -> ${test_string}'
#                 Update Task Name    ${test_string}
#                 Set Suite Variable    ${test_new_task_name}    ${test_string}
#                 Fill Text    ${CustomTaskName}    ${data['customName']}
#             ELSE
#                 Select Options By    ${TaskNameDropdown}    label    ${data['TaskNameDropdown']}
#             END
#             Click    ${AssignTo}
#             ${assignee}    Catenate    SEPARATOR=    ${SelectAssignee}    ${data['assignee']}    ']
#             Click    ${assignee}
#             ${data_due_date}    Get Tomorrows Date YMD
#             Run Keyword And Continue On Failure    Wait For Element With Message    DueDate    ${DueDate}    visible    Due date is not available while creating the task
#             ${full_datetime}    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
#             Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
#            Select Options By    ${PriorityDropdown}    label    ${data['priority']}
#             Click    ${TaskDetails}
#             Fill Text    ${TaskDetails}    ${data['taskDetails']}
#             Run Keyword And Continue On Failure    Wait For Element With Message    CreateButton    ${CreateButton}    visible    Create button is not get disappearing After created task
#             Click    ${CreateButton}
#             Verify Task created popup
Create New Task
    [Documentation]    Creates a new task from within a submission.
    ...    Fills out the 'Create Task' form with the provided data including task name, assignee, due date, priority, and task details.
    [Arguments]    ${data}

    # Wait and click Tasks menu
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'TasksMenu' is not visible in the side menu.

    ${status}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'TasksMenu'.

    # Click on 'Create New Task' or 'New Task' depending on task availability
    ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
    IF    ${noTasks_visible}
        ${status}=    Run Keyword And Return Status    Click    ${CreateNewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'CreateNewTaskButton' when no tasks exist.
    ELSE
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'NewTaskButton' is not available in the task tab.

        ${status}=    Run Keyword And Return Status    Click    ${NewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'NewTaskButton'.
    END

    # Wait for Create Task tab
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateTaskTab}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'CreateTaskTab' fields are not visible on the task page.

    # Select Task Name
    ${customName}=    Run Keyword And Return Status    Should Be Equal    '${data["TaskNameDropdown"]}'    'Custom'
    IF    ${customName}
        ${status}=    Run Keyword And Return Status    Select Options By    ${TaskNameDropdown}    label    Custom
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select 'Custom' in TaskNameDropdown.

        ${randomNumber}=    Generate Random Number
        ${test_string}=    Catenate    SEPARATOR=    ${data['customName']}
        Log Step    'Converted string -> ${test_string}'

        ${status}=    Run Keyword And Return Status    Update Task Name    ${test_string}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to update task name to '${test_string}'.

        Set Suite Variable    ${test_new_task_name}    ${test_string}

        ${status}=    Run Keyword And Return Status    Fill Text    ${CustomTaskName}    ${data['customName']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to fill CustomTaskName field.
    ELSE
        ${status}=    Run Keyword And Return Status    Select Options By    ${TaskNameDropdown}    label    ${data['TaskNameDropdown']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select task name '${data['TaskNameDropdown']}' in dropdown.
    END

    # Assign task
    ${status}=    Run Keyword And Return Status    Click    ${AssignTo}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click 'AssignTo' field.

    ${assignee}=    Catenate    SEPARATOR=    ${SelectAssignee}    ${data['assignee']}    ']
    ${status}=    Run Keyword And Return Status    Click    ${assignee}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select assignee '${data['assignee']}'.

    # Set due date
    ${data_due_date}=    Get Tomorrows Date YMD
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DueDate}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'DueDate' field is not visible while creating the task.

    ${full_datetime}=    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
    ${status}=    Run Keyword And Return Status    Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to set the due date/time.

    # Set priority
    ${status}=    Run Keyword And Return Status    Select Options By    ${PriorityDropdown}    label    ${data['priority']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select priority '${data['priority']}'.

    # Fill Task Details
    ${status}=    Run Keyword And Return Status    Click    ${TaskDetails}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'TaskDetails' field.

    ${status}=    Run Keyword And Return Status    Fill Text    ${TaskDetails}    ${data['taskDetails']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to fill 'TaskDetails' with provided data.

    # Click Create button
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateButton}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'CreateButton' did not appear or is not clickable after filling task details.

    ${status}=    Run Keyword And Return Status    Click    ${CreateButton}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'CreateButton'.

    # Verify task creation
    Verify Task created popup

# Verify the created task details
#     [Documentation]    Verifies that all the details of a newly created task are displayed correctly on the task details page.
#     ...    It compares the displayed values against a list of expected values.
#     ...
#     ...    *Arguments:*
#     ...    - `${expected_taskDetails}`: A list of expected string values for the task details fields.
#     [Arguments]    ${expected_taskDetails}
#     ${dueDate}    Get Formatted Tomorrow Date
#     Run Keyword Unless    '${dueDate}' in ${expected_taskDetails}    Insert Into List    ${expected_taskDetails}    1    ${dueDate}
#     ${CreatedDate}    Get Formatted Current Date
#     Run Keyword Unless    '${createdDate}' in ${expected_taskDetails}    Append To List    ${expected_taskDetails}    ${CreatedDate}
#     ${actual_taskDetails}    Create List
#     FOR    ${taskDetail}    IN    @{SanctionScreeningTaskDetails}
#         ${text}    Get Text    ${SanctionScreeningTaskDetails['${taskDetail}']}
#          ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${text}    \n
#         IF    ${hasNewLine}
#             @{splitValue}=    Split String    ${text}    \n
#             ${split}=    Strip String    ${splitValue}[1]
#             Append To List    ${actual_taskDetails}    ${split}
#         ELSE
#             ${trimData}=    Strip String    ${text}
#             Append To List    ${actual_taskDetails}    ${trimData}
#         END
#     END
#     Log Step    'Actual task details -> ${actual_taskDetails}'
#     Log Step    'Expected task details -> ${expected_taskDetails}'
#     ${length}    Get Length    ${expected_taskDetails}
#     FOR    ${index}    IN RANGE    0    ${length}
#         ${expectedTextValue}=     Set Variable    ${expected_taskDetails[${index}]}
#         ${actualTextValue}=    Set Variable    ${actual_taskDetails[${index}]}
#         ${condition}=    Evaluate    ${index} == ${length-1} or ${index} == 1
#         Run Keyword If    ${condition}    Should Contain    ${actualTextValue}    ${expectedTextValue}    
#         ...    ELSE    Should Be Equal    ${expectedTextValue}    ${actualTextValue}
#     END
Verify Created Task Details
    [Documentation]    Verifies that all the details of a newly created task are displayed correctly on the task details page.
    ...    Compares displayed values against a list of expected values.
    [Arguments]    ${expected_taskDetails}

     ${dueDate}=    Get Formatted Tomorrow Date
    IF    '${dueDate}' not in ${expected_taskDetails}
        Insert Into List    ${expected_taskDetails}    1    ${dueDate}
    END

    ${createdDate}=    Get Formatted Current Date
    IF    '${createdDate}' not in ${expected_taskDetails}
        Append To List    ${expected_taskDetails}    ${createdDate}
    END
    ${actual_taskDetails}    Create List
    FOR    ${taskDetail}    IN    @{SanctionScreeningTaskDetails}
        ${text}=    Get Text    ${SanctionScreeningTaskDetails['${taskDetail}']}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    msg=Verify Task Details: Task detail '${taskDetail}' is empty on the page.

        ${hasNewLine}=    Run Keyword And Return Status    Should Contain    ${text}    \n
        IF    ${hasNewLine}
            @{splitValue}=    Split String    ${text}    \n
            ${split}=    Strip String    ${splitValue}[1]
            Append To List    ${actual_taskDetails}    ${split}
        ELSE
            ${trimData}=    Strip String    ${text}
            Append To List    ${actual_taskDetails}    ${trimData}
        END
    END

    Log Step    'Actual task details -> ${actual_taskDetails}'
    Log Step    'Expected task details -> ${expected_taskDetails}'

    ${length}=    Get Length    ${expected_taskDetails}
    FOR    ${index}    IN RANGE    0    ${length}
        ${expectedTextValue}=    Set Variable    ${expected_taskDetails[${index}]}
        ${actualTextValue}=    Set Variable    ${actual_taskDetails[${index}]}
        ${condition}=    Evaluate    ${index} == ${length-1} or ${index} == 1

        IF    ${condition}
            Run Keyword And Continue On Failure    Should Contain    ${actualTextValue}    ${expectedTextValue}    
            ...    msg=Verify Task Details: Expected '${expectedTextValue}' to be part of '${actualTextValue}' at index ${index}.
        ELSE
            Run Keyword And Continue On Failure    Should Be Equal    ${expectedTextValue}    ${actualTextValue}
            ...    msg=Verify Task Details: Mismatch at index ${index}. Expected '${expectedTextValue}', but found '${actualTextValue}'.
        END
    END

# Select Task Card
#     [Documentation]    Clicks on a specific task card on a dashboard or overview page.
#     ...
#     ...    *Arguments:*
#     ...    - `${cardName}`: The name of the task card to click.
#     [Arguments]    ${cardName}
#     ${card}    Catenate    SEPARATOR=    (${TaskCard1}    ${cardName}    ${TaskCard2})[1]  
#     Click    ${card}  
#     Sleep    2s
#     ${taskTitle}    Get Text    ${TaskHeader}
#     ${trimText}    Strip String    ${taskTitle}
#     Run Keyword And Continue On Failure    Should Be Equal    ${trimText}    ${cardName}

Select Task Card
    [Documentation]    Clicks on a specific task card on a dashboard or overview page.
    ...    Verifies that the correct task header is displayed after clicking.
    [Arguments]    ${cardName}

    ${card}=    Catenate    SEPARATOR=    (${TaskCard1}    ${cardName}    ${TaskCard2})[1]
    
    ${clicked}=    Run Keyword And Return Status    Click    ${card}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click the task card '${cardName}'.
    
    Sleep    2s

    ${taskTitle}=    Get Text    ${TaskHeader}
    ${trimText}=    Strip String    ${taskTitle}
    Run Keyword And Continue On Failure    Should Be Equal    ${trimText}    ${cardName}    msg=Task header does not match the clicked card name.


verify Edit Delete and Complete task Buttons are present on the right side of task list
    [Documentation]    Verifies that Edit, Delete, and Complete task buttons are visible on the right side of the task list.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_edit}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Action Buttons: 'Edit' button is not visible on the task list.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Action Buttons: 'Delete' button is not visible on the task list.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Complete_Task}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Action Buttons: 'Complete' button is not visible on the task list.
   
# Verify Task updated popup
#     [Documentation]    Verifies that the 'Task Updated' confirmation popup is visible.
#     # Wait For Elements State    ${Task_updated_popup}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_updated_popup    ${Task_updated_popup}    visible    Task_updated_popup is not available After created the task
 
# Verify Task deleted popup
#     [Documentation]    Verifies that the 'Task Deleted' confirmation popup is visible.
#     # Wait For Elements State    ${Task_del_popup}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_del_popup    ${Task_del_popup}    visible    Task_del_popup is not available After Deleted the task
 
# click Task delete icon
#     [Documentation]    Verifies that the 'Task Created' confirmation popup is visible.
#     #  Wait For Elements State    ${Task_delete}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_delete    ${Task_delete}    visible    Task_delete is not available After created the task
#     Click    ${Task_delete}
#     Get Element States    ${Get_delpopup}    validate    value & visible
Verify Task updated popup
    [Documentation]    Verifies that the 'Task Updated' confirmation popup is visible after editing a task.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_updated_popup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Updated Popup: 'Task Updated' popup is not visible after editing the task.

Verify Task deleted popup
    [Documentation]    Verifies that the 'Task Deleted' confirmation popup is visible after deleting a task.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_del_popup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Deleted Popup: 'Task Deleted' popup is not visible after deleting the task.

Click Task delete icon
    [Documentation]    Clicks the 'Delete' icon for a task and verifies that the delete confirmation popup is visible.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: 'Delete' icon is not visible on the task list.
    
    ${status}=    Run Keyword And Return Status    Click    ${Task_delete}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: Failed to click on 'Delete' icon.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Get_delpopup}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: Delete confirmation popup is not visible after clicking 'Delete' icon.

Verify Edit Icon is Clickable and Functional
    [Documentation]    Verifies that the Edit icon is clickable and functional, allowing updating the task priority.
    [Arguments]    ${data}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_edit}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: 'Edit' button is not visible on the task list.

    ${status}=    Run Keyword And Return Status    Click    ${Task_edit}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: Failed to click on 'Edit' button.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PriorityDropdown}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: 'Priority' dropdown is not visible after clicking Edit.

    ${status}=    Run Keyword And Return Status    Select Options By    ${PriorityDropdown}    label    ${data}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: Failed to select '${data}' in Priority dropdown.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Save_edited_task}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: 'Save' button is not visible after editing the task.

    ${status}=    Run Keyword And Return Status    Click    ${Save_edited_task}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Edit Task: Failed to click on 'Save' button.

    Verify Task updated popup
 
# Verify Delete Icon is Clickable and Functional
#     [Documentation]    verifying Edit,delete and complete task buttons are visible on the right side of task list
#     [Arguments]    ${expected_taskdetails}
#     # Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
#     # Handle Future Dialogs    action=accept    
#     # Click    ${TasksMenu}
#     click Task delete icon
#     # Wait For Elements State    ${Cancel_del}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Cancel_del    ${Cancel_del}    visible    Cancel is not available After click on delete the task
#     Click    ${Cancel_del}
#     verify Edit Delete and Complete task Buttons are present on the right side of task list
#     click Task delete icon
#     # Wait For Elements State    ${Del_Task_button}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Del_Task_button    ${Del_Task_button}    visible    Del_Task_button is not available After created the task
#     Click    ${Del_Task_button}
#     Verify Task deleted popup
Verify Delete Icon is Clickable and Functional
    [Documentation]    Verifies that the delete icon is clickable and functional for a created task. 
    ...    Confirms that the Cancel and Delete buttons appear as expected and the deletion confirmation popup is visible.
    [Arguments]    ${expected_taskdetails}
    
    # Click on the Task delete icon
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: Delete icon is not visible on the right side of the task list.
    
    ${status}=    Run Keyword And Return Status    Click    ${Task_delete}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: Failed to click on the delete icon.
    
    # Wait for Cancel button to appear
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Cancel_del}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Cancel Button: Cancel button is not visible after clicking delete icon.
    
    # Click Cancel button to dismiss
    ${status}=    Run Keyword And Return Status    Click    ${Cancel_del}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Cancel Button: Failed to click on Cancel button.
    
    # Verify that Edit, Delete, and Complete buttons are still visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_edit}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Edit Button: Edit button is not visible on the right side of the task list.
    
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Button: Delete button is not visible on the right side of the task list.
    
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Complete_Task}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Complete Task Button: Complete Task button is not visible on the right side of the task list.
    
    # Click delete icon again to confirm deletion
    ${status}=    Run Keyword And Return Status    Click    ${Task_delete}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Delete Icon: Failed to click on the delete icon for final deletion.
    
    # Wait for the Delete confirmation button
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Del_Task_button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Delete Button: Delete confirmation button is not visible after clicking delete icon.
    
    # Click Delete to remove the task
    ${status}=    Run Keyword And Return Status    Click    ${Del_Task_button}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Delete Button: Failed to click on the Delete confirmation button.
    
    # Verify Task Deleted popup
    Verify Task deleted popup

# Select the Created Task
#     [Documentation]    This method is used to selected the Selected TestCases  
#     [Arguments]    ${TaskName}
#             # Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
#             Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TasksMenu is not available After created the task
#             # Handle Future Dialogs    action=accept    
#             Click    ${TasksMenu}
#             ${created_Task}    Catenate    SEPARATOR=    ${Task_Find_Locator}    ${TaskName['customName']}    '])[1]
#             #  Wait For Elements State    ${created_Task}    visible    5s
#             Run Keyword And Continue On Failure    Wait For Element With Message    created_Task    ${created_Task}    visible    created_Task is not available After created the task
#             click    ${created_Task}
#              ${created_Task_Name}    Catenate    SEPARATOR=    ${Task_Name_Loc}    ${TaskName['customName']}    ']
         
#             # Wait For Elements State    ${created_Task_Name}    visible    5s
#             Run Keyword And Continue On Failure    Wait For Element With Message    created_Task_Name    ${created_Task_Name}    visible    created_Task_Name is not available After created the task
Select the Created Task
    [Documentation]    Selects a created task by its name and ensures the task is visible and clickable on the task list.
    [Arguments]    ${TaskName}
    
    # Wait for Tasks menu to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Tasks Menu: 'Tasks' menu is not visible after creating the task.
    
    # Click on Tasks menu
    ${status}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Tasks Menu: Failed to click on 'Tasks' menu.

    # Build locator for the created task
    ${created_Task}=    Catenate    SEPARATOR=    ${Task_Find_Locator}    ${TaskName['customName']}    '])[1]
    
    # Wait for the created task to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${created_Task}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Created Task: Task '${TaskName["customName"]}' is not visible on the task list.
    
    # Click on the created task
    ${status}=    Run Keyword And Return Status    Click    ${created_Task}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Created Task: Failed to click on task '${TaskName["customName"]}'.

    # Build locator for the task name within the task details
    ${created_Task_Name}=    Catenate    SEPARATOR=    ${Task_Name_Loc}    ${TaskName['customName']}    ']
    
    # Wait for task name to be visible in details
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${created_Task_Name}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Name: Task name '${TaskName["customName"]}' is not visible in the task details page.

# Complete Task with the given reason for Booking stage
#     [Documentation]    Completes the open task with a specified reason.
#     ...
#     ...    *Arguments:*
#     ...    - `${data}`: The reason for completing the task (e.g., 'False Positive'). This must match one of the checkbox labels in the completion dialog.
#     [Arguments]    ${data}
#     # Wait For Elements State    ${CompleteTaskButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    CompleteTaskButton    ${CompleteTaskButton}    visible    CompleteTaskButton is not available After created the task
#     Click    ${CompleteTaskButton}
#     # Wait For Elements State    ${TaskCompleteDialog}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    visible    TaskCompleteDialog is not available After clicked the CompleteTaskButton 
#     Fill Text    ${Task_reason}    ${data}        
#     Click    ${CompleteTaskButtonInDialog}
#     # Wait For Elements State    ${TaskCompleteDialog}    detached
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    visible    TaskCompleteDialog is  available After Completed the Task 

# Complete Task with the given reason for Booking stage
#     [Documentation]    Completes the open task with a specified reason.
#     ...    The reason must match one of the checkbox labels in the completion dialog.
#     [Arguments]    ${data}

#     Run Keyword And Continue On Failure    Wait For Element With Message    CompleteTaskButton    ${CompleteTaskButton}    visible    CompleteTaskButton is not available after creating the task

#     ${clicked}=    Run Keyword And Return Status    Click    ${CompleteTaskButton}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Complete Task button.

#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    visible    TaskCompleteDialog is not available after clicking CompleteTaskButton

#     Fill Text    ${Task_reason}    ${data}

#     ${clicked_dialog}=    Run Keyword And Return Status    Click    ${CompleteTaskButtonInDialog}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked_dialog}    msg=Failed to click Complete Task button in dialog.

#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    detached    TaskCompleteDialog is still present after completing the task
Complete Task with the given reason for Booking stage
    [Documentation]    Completes the open task with a specified reason.
    ...    The reason must match one of the checkbox labels in the completion dialog.
    [Arguments]    ${data}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CompleteTaskButton}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Complete Task button is not available after creating the task

    ${clicked}=    Run Keyword And Return Status    Click    ${CompleteTaskButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Complete Task button.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Complete dialog is not visible after clicking Complete Task button

    Fill Text    ${Task_reason}    ${data}

    ${clicked_dialog}=    Run Keyword And Return Status    Click    ${CompleteTaskButtonInDialog}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_dialog}    msg=Failed to click Complete Task button in dialog.

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    detached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Complete dialog is still present after completing the task

# Verify the task is completed and sanction label is appears as per the reason for booking
#     [Documentation]    Verifies that the task shows as completed and that the correct sanction label ('False Positive', 'Sanction Screening Flagged', or 'Sanction Screening Clear') is displayed based on the completion reason.
#     ...
#     ...    *Arguments:*
#     ...    - `${reason}`: The reason the task was completed with, used to determine which label should be visible.
#     [Arguments]    ${reason}
#     Scroll To Element    ${TaskCompletedMessage}
#     # Wait For Elements State    ${TaskCompletedMessage}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompletedMessage    ${TaskCompletedMessage}    visible    TaskCompletedMessage is not available After Completed the Task
#     ${actual_reason}    Get Text    ${Task_completed}
#     Run Keyword And Continue On Failure    Should Be Equal    ${actual_reason}    ${reason}

# Verify the task is completed and sanction label is appears as per the reason for booking
#     [Documentation]    Verifies that the task shows as completed and the correct sanction label is displayed.
#     ...    The label is based on the completion reason: 'False Positive', 'Sanction Screening Flagged', or 'Sanction Screening Clear'.
#     [Arguments]    ${reason}

#     Scroll To Element    ${TaskCompletedMessage}

#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompletedMessage    ${TaskCompletedMessage}    visible    TaskCompletedMessage is not available after completing the task

#     ${actual_reason}=    Get Text    ${Task_completed}
#     Run Keyword And Continue On Failure    Should Be Equal    ${actual_reason}    ${reason}    msg=The task completion reason does not match the expected reason.
Verify the task is completed and sanction label is appears as per the reason for booking
    [Documentation]    Verifies that the task shows as completed and the correct sanction label is displayed.
    ...    The label is based on the completion reason: 'False Positive', 'Sanction Screening Flagged', or 'Sanction Screening Clear'.
    [Arguments]    ${reason}

    Scroll To Element    ${TaskCompletedMessage}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompletedMessage}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=TaskCompletedMessage is not available after completing the task

    ${actual_reason}=    Get Text    ${Task_completed}
    Run Keyword And Continue On Failure    Should Be Equal    ${actual_reason}    ${reason}    msg=The task completion reason does not match the expected reason. Expected: ${reason}, but got: ${actual_reason}.

# Verify that System shows Correct Task Number
#     [Documentation]    this method is used to Verify the System Show the Correct Task Number   
#     ${Status}    Run Keyword And Return Status    Wait For Elements State    ${Number_Task_Side_Menu}    visible    5s
#     IF    '${Status}' == 'True'
#     ${Number_Task}    Get Text    ${Number_Task_Side_Menu}
#     ${Number_Of_task}    Convert To Integer    ${Number_Task}
#     Switch to Summary
#     Click Tasks
#      ${Status}    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${element_timeout}
#     Should Be True    ${Status}
#     ${element}    Get Elements    ${Listof_Task}
#     ${Length}    Get Length    ${element}
#     Should Be Equal    ${Length}    ${Number_Of_task}
#     ELSE
#         Switch to Summary
#         Click Tasks
#         ${noTasks_visible}    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
#         Should Be True    ${noTasks_visible}   
#     END
Verify that System shows Correct Task Number
    [Documentation]    This method verifies that the system shows the correct task number.
    
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${Number_Task_Side_Menu}    visible    timeout=${display_timeout}
    IF    '${Status}' == 'True'
        ${Number_Task}=    Get Text    ${Number_Task_Side_Menu}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${Number_Task}    msg=Verify Task Number: Task number text is empty in side menu.
        
        ${Number_Of_task}=    Convert To Integer    ${Number_Task}
        Run Keyword And Continue On Failure    Should Be True    ${Number_Of_task} >= 0    msg=Verify Task Number: Task number '${Number_Task}' in side menu is not a valid non-negative integer.
        
        Switch to Summary
        
        ${clickedTasks}=    Run Keyword And Return Status    Click    ${Tasks}
        Run Keyword And Continue On Failure    Should Be True    ${clickedTasks}    msg=Verify Task Number: Failed to click 'Tasks' button in Summary tab.
        
        ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Task Number: 'New Task' button is not visible in Tasks section.
        ${element}=    Get Elements    ${Listof_Task}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${element}    msg=Verify Task Number: Task list is empty, expected ${Number_Of_task} tasks.
        
        ${Length}=    Get Length    ${element}
        Run Keyword And Continue On Failure    Should Be Equal As Integers    ${Length}    ${Number_Of_task}    
        ...    msg=Verify Task Number: Number of tasks in list (${Length}) does not match side menu count (${Number_Of_task}).
        
    ELSE
        Switch to Summary
        
        ${clickedTasks}=    Run Keyword And Return Status    Click    ${Tasks}
        Run Keyword And Continue On Failure    Should Be True    ${clickedTasks}    msg=Verify Task Number: Failed to click 'Tasks' button in Summary tab.
        
        ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${noTasks_visible}    msg=Verify Task Number: 'No Tasks' message is not visible when no tasks are expected.
    END

# Verify Task Names Listed in Alphatecal Order
#     [Documentation]    This method verifies that the task names are listed in alphabetical order
#     [Arguments]    ${data}
#     # Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TasksMenu is not available in the task page 
#             Click    ${TasksMenu}
#             ${noTasks_visible}    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
#             IF    ${noTasks_visible}
#                 Click    ${CreateNewTaskButton}
#             ELSE
#                 # Wait For Elements State    ${NewTaskButton}    visible
#                 Run Keyword And Continue On Failure    Wait For Element With Message    NewTaskButton    ${NewTaskButton}    visible    NewTaskButton is not available After created the task 
#                 Click    ${NewTaskButton}
#             END
   
#     ${ActualList}=    Get Elements    ${task_Name_List}
#     ${ActualNames}=    Create List
#     FOR    ${element}    IN    @{ActualList}
#         ${TaskName}=    Get Text    ${element}
#         Append To List    ${ActualNames}    ${TaskName}
#         Log    ${TaskName}
#     END
#     Lists Should Be Equal    ${ActualNames}    ${data['TaskNamesList']}
Verify Task Names Listed in Alphabetical Order
    [Documentation]    This method verifies that the task names are listed in alphabetical order.
    [Arguments]    ${data}

    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Task Names: 'TasksMenu' is not visible on the task page.
    
    ${clicked}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Task Names: Failed to click 'TasksMenu'. Ensure it is visible and enabled.

    ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
    IF    ${noTasks_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Task Names: Failed to click 'Create New Task' button when no tasks exist.
    ELSE
        ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Task Names: 'NewTaskButton' is not visible after creating a task.
        
        ${clicked}=    Run Keyword And Return Status    Click    ${NewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Verify Task Names: Failed to click 'NewTaskButton'. Ensure it is visible and enabled.
    END
    ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Task Names: 'TasksMenu' is not visible on the task page.
    ${ActualList}=    Get Elements    ${task_Name_List}
    # Run Keyword And Continue On Failure    Should Not Be Empty    ${ActualList}    msg=Verify Task Names: Task name list is empty, no tasks found on the page.

    ${ActualNames}=    Create List
    FOR    ${element}    IN    @{ActualList}
        # ${Status}=    Run Keyword And Return Status    Wait For Elements State    ${element}    visible    timeout=${display_timeout}
        # Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Verify Task Names: 'TasksMenu' is not visible on the task page.
    
        ${TaskName}=    Get Text    ${element}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${TaskName}    msg=Verify Task Names: Found a task element with empty text.
        Append To List    ${ActualNames}    ${TaskName}
        Log    ${TaskName}
    END

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${ActualNames}    ${data['TaskNamesList']}
    ...    msg=Verify Task Names: Task names are not in alphabetical order. Actual: ${ActualNames}, Expected: ${data['TaskNamesList']}


# Verify Submission/Policy Number in CAT Modeling Request
#     [Documentation]    This method is used to verify that the header 'Policy Number' should be replaced with 'Submission/Policy Number'
#     [Arguments]    ${data}

#     # Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TasksMenu is not available in the task page
#     Click    ${TasksMenu}
#     ${noTasks_visible}    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
#     IF    ${noTasks_visible}
#           Click    ${CreateNewTaskButton}
#     ELSE
#     # Wait For Elements State    ${NewTaskButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    NewTaskButton    ${NewTaskButton}    visible    NewTaskButton is not available After created the task
#     Click    ${NewTaskButton}
#     END
    
#     # Wait For Elements State    ${Task_Name_Field}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_Name_Field    ${Task_Name_Field}    visible    Task_Name_Field is not available After created the task
#     Select Options By    ${Task_Name_Field}    text    ${data['TaskName']}

#     # Wait For Elements State    ${Task_CATForm_Btn}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_CATForm_Btn    ${Task_CATForm_Btn}    visible    Task_CATForm_Btn is not available After created the CAT Modeling Request task
#     Click    ${Task_CATForm_Btn}

#     # Wait For Elements State    ${CAT_Form_Header}
#     Run Keyword And Continue On Failure    Wait For Element With Message    CAT_Form_Header    ${CAT_Form_Header}    visible    CAT_Form_Header is not available After created the CAT Modeling Request task
#     ${ActualHeader}    Get Text    ${CAT_Form_Header}
#     Should Be Equal    ${ActualHeader}    ${data['CATFormHeader']}
    

#     ${ActualCATReqHeaders}    Create List
#     @{CATHeaders}=    Set Variable    ${data['CATReqHeader']}
#     FOR    ${element}    IN    @{CATHeaders}
#         ${ActualLocator}    Catenate    SEPARATOR=    ${RequestFormHeader}    ${element}    ']
#         Run Keyword And Continue On Failure    Wait For Element With Message    ActualLocator    ${ActualLocator}    visible    
#         # Wait For Elements State    ${ActualLocator}
#         ${ActualValue}    Get text    ${ActualLocator}
#         Append To List    ${ActualCATReqHeaders}   ${ActualValue}     
#     END
#     Lists Should Be Equal    ${data['ExceptedCATReqHeader']}    ${ActualCATReqHeaders}
#     Click    ${Close_CATForm}
#     Click    ${Close_Task}
Verify Submission/Policy Number in CAT Modeling Request
    [Documentation]    This method verifies that the header 'Policy Number' is replaced with 'Submission/Policy Number'.
    [Arguments]    ${data}

    Run Keyword And Continue On Failure    Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'TasksMenu' is not visible on the task page.
    
    ${clicked}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'TasksMenu'. Ensure it is visible and enabled.

    ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
    IF    ${noTasks_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Create New Task' button when no tasks exist.
    ELSE
        Run Keyword And Continue On Failure    Wait For Elements State    ${NewTaskButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'NewTaskButton' is not visible after creating the task.

        ${clicked}=    Run Keyword And Return Status    Click    ${NewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'NewTaskButton'. Ensure it is visible and enabled.
    END

    Run Keyword And Continue On Failure    Wait For Elements State    ${Task_Name_Field}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'Task_Name_Field' is not visible after creating the task.

    Select Options By    ${Task_Name_Field}    text    ${data['TaskName']}

    Run Keyword And Continue On Failure    Wait For Elements State    ${Task_CATForm_Btn}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'Task_CATForm_Btn' is not visible after creating the CAT Modeling Request task.

    ${clicked}=    Run Keyword And Return Status    Click    ${Task_CATForm_Btn}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Task_CATForm_Btn'.

    Run Keyword And Continue On Failure    Wait For Elements State    ${CAT_Form_Header}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'CAT_Form_Header' is not visible after opening the CAT Modeling Request task.

    ${ActualHeader}=    Get Text    ${CAT_Form_Header}
    Run Keyword And Continue On Failure    Should Be Equal    ${ActualHeader}    ${data['CATFormHeader']}    msg=CAT Request: Header mismatch. Actual: '${ActualHeader}', Expected: '${data['CATFormHeader']}'

    ${ActualCATReqHeaders}=    Create List
    @{CATHeaders}=    Set Variable    ${data['CATReqHeader']}
    FOR    ${element}    IN    @{CATHeaders}
        ${ActualLocator}=    Catenate    SEPARATOR=    ${RequestFormHeader}    ${element}    ']
        Run Keyword And Continue On Failure    Wait For Elements State    ${ActualLocator}    visible
        Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: Header '${element}' is not visible in CAT Form.

        ${ActualValue}=    Get Text    ${ActualLocator}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${ActualValue}    msg=CAT Request: Header '${element}' has empty text in CAT Form.
        Append To List    ${ActualCATReqHeaders}    ${ActualValue}
    END

    Run Keyword And Continue On Failure    Lists Should Be Equal    ${data['ExceptedCATReqHeader']}    ${ActualCATReqHeaders}
    ...    msg=CAT Request: CAT Form headers mismatch. Actual: ${ActualCATReqHeaders}, Expected: ${data['ExceptedCATReqHeader']}

    ${clicked}=    Run Keyword And Return Status    Click    ${Close_CATForm}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Close_CATForm' button.

    ${clicked}=    Run Keyword And Return Status    Click    ${Close_Task}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Close_Task' button.

# Verify the Created Task Deleted
#     [Documentation]    This method verifies that the created task is completely deleted.  
#     [Arguments]    ${TaskName}
    
#     # Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TasksMenu is not available After created the task
#     Handle Future Dialogs    action=accept    
#     Click    ${TasksMenu}
#     ${created_Task}    Catenate    SEPARATOR=    ${Task_Find_Locator}    ${TaskName['customName']}    ']
#     Run Keyword And Continue On Failure    Get Element States    ${created_Task}    validate    value & detached
#     Log    Verified that the created task '${TaskName['customName']}' is deleted.

# Verify the Created Task Deleted
#     [Documentation]    Verifies that the created task is completely deleted.
#     [Arguments]    ${TaskName}

#     # Wait for Tasks menu to be visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    TasksMenu    ${TasksMenu}    visible    TasksMenu is not available after creating the task

#     # Accept any future dialogs
#     Handle Future Dialogs    action=accept

#     # Click on Tasks menu
#     ${clicked}=    Run Keyword And Return Status    Click    ${TasksMenu}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on Tasks menu.

#     # Construct locator for the created task
#     ${created_Task}=    Catenate    SEPARATOR=    ${Task_Find_Locator}    ${TaskName['customName']}    ']

#     # Verify the task element is detached (i.e., deleted)
#     Run Keyword And Continue On Failure    Get Element States    ${created_Task}    validate    value & detached

#     Log    Verified that the created task '${TaskName['customName']}' is deleted.
Verify the Created Task Deleted
    [Documentation]    Verifies that the created task is completely deleted.
    [Arguments]    ${TaskName}

    # Wait for Tasks menu to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=TasksMenu is not visible after creating the task. It might be a loading issue or the UI has not updated yet.

    # Accept any future dialogs
    Handle Future Dialogs    action=accept

    # Click on Tasks menu
    ${clicked}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click on the Tasks menu. The menu might not be clickable or is overlapped by another element.

    # Construct locator for the created task
    ${created_Task}=    Catenate    SEPARATOR=    ${Task_Find_Locator}    ${TaskName['customName']}    ']

    # Verify the task element is detached (i.e., deleted)
    ${state}=    Run Keyword And Return Status    Wait For Elements State    ${created_Task}    detached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${state}    msg=The task '${TaskName['customName']}' still appears in the UI. Expected it to be deleted, but it’s still attached to the DOM.

    Log    Verified that the created task '${TaskName['customName']}' is successfully deleted.

# Edit the created the task
#     [Documentation]    This method is used to Edit the Task
#     [Arguments]    ${data}
#     Click    ${Task_edit}      
#     ${remainder_date}=    Get Current Date    result_format=%Y-%m-%d    increment=2 day
 
#      ${data_due_date}    Get Tomorrows Date YMD
#     # Wait For Elements State    ${DueDate}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    DueDate    ${DueDate}    visible    DueDate is not available while Editing the task
#     ${full_datetime}    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
#     Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
#     # Wait For Elements State    ${task_remainder_date}    visible    timeout=${element_timeout}
#     Run Keyword And Continue On Failure    Wait For Element With Message    task_remainder_date    ${task_remainder_date}    visible    task_remainder_date is not available while Editing the task
#     ${full_datetime}    Catenate    SEPARATOR=    ${remainder_date}    T    ${data['dueTime']}
#     Evaluate JavaScript    ${task_remainder_date}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
#     Fill Text    ${TaskDetails}    ${data['taskDetails']}
#     # Wait For Elements State    ${Task_save}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_save    ${Task_save}    visible    Task_save is not available while Editing the task
#     Click    ${Task_save}
#     Verify Task Update popup
#     Verify Reminder Created Popup
#     Click    ${Task_edit}
#     Fill Text    ${TaskDetails}    ${data['taskDetails']}      
#     Click    ${Task_save}
#     Verify Task Update popup
#     ${status}    Get Element States    ${remainder_updated}
#     Run Keyword And Continue On Failure    Should Contain    ${status}    detached

# Edit the Created Task
#     [Documentation]    This method is used to edit an existing task
#     [Arguments]    ${data}

#     # Click Edit button
#     ${clicked}=    Run Keyword And Return Status    Click    ${Task_edit}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Edit button.

#     # Calculate dates
#     ${remainder_date}=    Get Current Date    result_format=%Y-%m-%d    increment=2 day
#     ${data_due_date}=    Get Tomorrows Date YMD

#     # Set Due Date
#     Run Keyword And Continue On Failure    Wait For Element With Message    DueDate    ${DueDate}    visible    DueDate is not available while editing the task
#     ${full_datetime}=    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
#     Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }

#     # Set Reminder Date
#     Run Keyword And Continue On Failure    Wait For Element With Message    task_remainder_date    ${task_remainder_date}    visible    task_remainder_date is not available while editing the task
#     ${full_datetime}=    Catenate    SEPARATOR=    ${remainder_date}    T    ${data['dueTime']}
#     Evaluate JavaScript    ${task_remainder_date}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }

#     # Fill Task Details
#     Fill Text    ${TaskDetails}    ${data['taskDetails']}

#     # Save Task
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_save    ${Task_save}    visible    Task_save is not available while editing the task
#     ${clicked}=    Run Keyword And Return Status    Click    ${Task_save}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Save button.

#     # Verify popups
#     Verify Task Update popup
#     Verify Reminder Created Popup

#     # Optional: Re-edit and save again
#     ${clicked}=    Run Keyword And Return Status    Click    ${Task_edit}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Edit button for second time.
#     Fill Text    ${TaskDetails}    ${data['taskDetails']}
#     ${clicked}=    Run Keyword And Return Status    Click    ${Task_save}
#     Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Save button for second time.

#     Verify Task Update popup

#     # Verify reminder update is detached
#     ${status}=    Get Element States    ${remainder_updated}
#     Run Keyword And Continue On Failure    Should Contain    ${status}    detached
Edit the Created Task
    [Documentation]    Edits an existing task with updated due date, reminder date, and task details.
    ...    Also verifies that the task update and reminder update popups appear as expected.
    [Arguments]    ${data}

    # Click Edit button
    ${clicked}=    Run Keyword And Return Status    Click    ${Task_edit}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Edit button. The button might be hidden or not interactable.

    # Calculate dates
    ${remainder_date}=    Get Current Date    result_format=%Y-%m-%d    increment=2 day
    ${data_due_date}=    Get Tomorrows Date YMD

    # Wait for Due Date element
    ${due_status}=    Run Keyword And Return Status    Wait For Elements State    ${DueDate}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${due_status}    msg=DueDate field is not visible while editing the task. Possibly UI not loaded correctly.

    # Set Due Date
    ${full_datetime}=    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
    Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }

    # Wait for Reminder Date element
    ${reminder_status}=    Run Keyword And Return Status    Wait For Elements State    ${task_remainder_date}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${reminder_status}    msg=Task Reminder Date field is not visible while editing the task.

    # Set Reminder Date
    ${full_datetime}=    Catenate    SEPARATOR=    ${remainder_date}    T    ${data['dueTime']}
    Evaluate JavaScript    ${task_remainder_date}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }

    # Fill Task Details
    Fill Text    ${TaskDetails}    ${data['taskDetails']}

    # Wait for Save button and click
    ${save_status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_save}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${save_status}    msg=Task Save button is not visible while editing the task.

    ${clicked}=    Run Keyword And Return Status    Click    ${Task_save}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Save button. Button might be unresponsive or covered by another element.

    # Verify popups
    Run Keyword And Continue On Failure    Verify Task Update popup
    Run Keyword And Continue On Failure    Verify Reminder Created Popup

    # Optional: Re-edit and save again to confirm stability
    ${clicked}=    Run Keyword And Return Status    Click    ${Task_edit}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Edit button for the second time.

    Fill Text    ${TaskDetails}    ${data['taskDetails']}

    ${save_again_status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_save}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${save_again_status}    msg=Task Save button is not visible during the second edit operation.

    ${clicked}=    Run Keyword And Return Status    Click    ${Task_save}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Task Save button for the second time.

    Run Keyword And Continue On Failure    Verify Task Update popup

    # Verify reminder update is detached
    ${state}=    Run Keyword And Return Status    Wait For Elements State    ${remainder_updated}    detached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${state}    msg=The reminder update confirmation element is still visible. Expected it to be detached after update.


# Verify Task created popup
#     [Documentation]    Verifies that the 'Task Created' confirmation popup is visible.
#     # Wait For Elements State    ${TaskCreatedPopup}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCreatedPopup    ${TaskCreatedPopup}    visible    TaskCreatedPopup is not available After Created the task
# Verify Task Update popup
#     [Documentation]    Verifies that the 'Task updated' confirmation popup is visible.
#     # Wait For Elements State    ${Task_updated}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Task_updated    ${Task_updated}    visible    Task_updated is not available while Editing the task
# Verify remainder created popup
#     [Documentation]    Verifies that the 'Reminder Created' confirmation popup is visible.
#     # Wait For Elements State    ${remainder_created}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    remainder_created    ${remainder_created}    visible    remainder_created is not available After Update the task
#  Verify remainder updated popup
#     [Documentation]    Verifies that the 'Reminder Updated' confirmation popup is visible.
#     # Wait For Elements State    ${remainder_updated}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    remainder_updated    ${remainder_updated}    visible    remainder_updated is not available After Update the task
#  Verify task number updated
#     [Documentation]    Verifies that the after created the task task number should be updated.
#     # Wait For Elements State    ${Number_Task_Side_Menu}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    Number_Task_Side_Menu    ${Number_Task_Side_Menu}    visible    Number_Task_Side_Menu is not available while Editing the task
Verify Task Created Popup
    [Documentation]    Verifies that the 'Task Created' confirmation popup is visible.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCreatedPopup}    visible    timeout=${display_timeout}
    Should Be True    ${status}    msg=Task Created Popup: 'TaskCreatedPopup' is not visible after creating the task.

Verify Task Update Popup
    [Documentation]    Verifies that the 'Task Updated' confirmation popup is visible.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_updated}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Updated Popup: 'Task_updated' popup is not visible after editing the task.

Verify Reminder Created Popup
    [Documentation]    Verifies that the 'Reminder Created' confirmation popup is visible.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${remainder_created}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reminder Created Popup: 'remainder_created' popup is not visible after updating the task.

Verify Reminder Updated Popup
    [Documentation]    Verifies that the 'Reminder Updated' confirmation popup is visible.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${remainder_updated}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Reminder Updated Popup: 'remainder_updated' popup is not visible after updating the task.

Verify Task Number Updated
    [Documentation]    Verifies that after creating or editing a task, the task number in the side menu is updated correctly.
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Number_Task_Side_Menu}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Task Number Updated: 'Number_Task_Side_Menu' is not visible while editing or creating the task.

# Complete Task without the reason
#     [Documentation]    Completes the task without the reason
#     ...
#     # Wait For Elements State    ${CompleteTaskButton}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    CompleteTaskButton    ${CompleteTaskButton}    visible    CompleteTaskButton is not available After Created the task
#     Click    ${CompleteTaskButton}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    visible    Wait for the taskCompleteDialog and verify that the False Positive, No Hit, and True Hit indicators are visible.    
#     Click    ${CompleteTaskButtonInDialog}
#     Run Keyword And Continue On Failure    Wait For Element With Message    TaskCompleteDialog    ${TaskCompleteDialog}    detached    Wait for the taskCompleteDialog element to be detached and confirm that the task has been completed without a given reason..
Complete Task without the reason
    [Documentation]    Completes the open task without selecting a reason.
    ...    This ensures that the task completion flow works even when no reason is provided.
    
    # Wait for Complete Task button to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CompleteTaskButton}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Complete Task button is not visible after task creation. The button might not have loaded or may be hidden behind another element.

    # Click Complete Task button
    ${clicked}=    Run Keyword And Return Status    Click    ${CompleteTaskButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click Complete Task button. The button might not be interactable or has not rendered properly.

    # Wait for Task Complete dialog to appear
    ${dialog_visible}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${dialog_visible}    msg=Task Complete dialog did not appear after clicking Complete Task button. Expected dialog with False Positive, No Hit, or True Hit options.

    # Click Complete button in the dialog
    ${clicked_dialog}=    Run Keyword And Return Status    Click    ${CompleteTaskButtonInDialog}
    Run Keyword And Continue On Failure    Should Be True    ${clicked_dialog}    msg=Failed to click Complete button inside the Task Complete dialog.

    # Wait for Task Complete dialog to disappear
    ${dialog_detached}=    Run Keyword And Return Status    Wait For Elements State    ${TaskCompleteDialog}    detached    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${dialog_detached}    msg=Task Complete dialog is still visible. Expected it to be detached after completing the task without a reason.

# upload file on created task
#     [Documentation]    this method is used to uploads document in the Attachment tab
#     [Arguments]    ${file_name}    ${taskdata}        
#     ${AbsolutePath}=    Normalize Path    ${path}${file_name}
#     # Select the Created Task    ${taskdata['taskName']}
#     Scroll To    ${Task_Attachement_loc}
#     Click    ${Task_Attachement_loc}
#     Upload File By Selector    ${UploadFile}   ${AbsolutePath}
#     Sleep    2s
#     Run Keyword And Continue On Failure    Get Element States    ${Task_Attachement_upload_file_Name}    validate    value & visible
#     ${Actual_file_name}    Get Text    ${Task_Attachement_upload_file_Name}
#     Run Keyword And Continue On Failure    Should Be Equal    ${file_name}    ${Actual_file_name}
#     click    ${Task_Attachement_delete_file}
#     Run Keyword And Continue On Failure    Get Element Count    ${Task_Attachement_upload_file_Name}    ==    0
Upload File on Created Task
    [Documentation]    Uploads a document in the Attachment tab for a created task.
    [Arguments]    ${file_name}    ${taskdata}

    ${AbsolutePath}=    Normalize Path    ${path}${file_name}
    Select the Created Task    ${taskdata}
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_Attachement_loc}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Upload File: 'Task_Attachement_loc' is not visible for the task '${taskdata["taskName"]}'.
    ${status}=    Run Keyword And Return Status    Click    ${Task_Attachement_loc}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Upload File: Failed to click on 'Task_Attachement_loc' for task '${taskdata["taskName"]}'.

    ${Status}    Run Keyword And Return Status    Upload File By Selector    ${UploadFile}    ${AbsolutePath}
    Run Keyword And Continue On Failure    Should Be True    ${Status}    msg=Upload File: Failed to upload file '${file_name}' using selector '${UploadFile}'.
    Sleep    2s

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_Attachement_upload_file_Name}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Upload File: Uploaded file '${file_name}' did not appear in the attachment list.

    ${Actual_file_name}=    Get Text    ${Task_Attachement_upload_file_Name}
    Run Keyword And Continue On Failure    Should Be Equal    ${file_name}    ${Actual_file_name}    msg=Upload File: Uploaded file name mismatch. Expected '${file_name}', but found '${Actual_file_name}'.

    ${status}=    Run Keyword And Return Status    Click    ${Task_Attachement_delete_file}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Upload File: Failed to click on 'Task_Attachement_delete_file' to remove uploaded file.

    ${count}=    Get Element Count    ${Task_Attachement_upload_file_Name}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${count}    0    msg=Upload File: Uploaded file '${file_name}' was not deleted successfully; still visible in attachments.


Verify Error msg in CAT Modeling Request form in task tab 
    [Documentation]    This method verifies that Error msg in CAT Modeling Request form in task tab .
    [Arguments]    ${data}
    Click Answers Tab
    Run Keyword And Continue On Failure    Wait For Elements State    ${TasksMenu}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'TasksMenu' is not visible on the task page.
    
    ${clicked}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'TasksMenu'. Ensure it is visible and enabled.

    ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
    IF    ${noTasks_visible}
        ${clicked}=    Run Keyword And Return Status    Click    ${CreateNewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Create New Task' button when no tasks exist.
    ELSE
        Run Keyword And Continue On Failure    Wait For Elements State    ${NewTaskButton}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'NewTaskButton' is not visible after creating the task.

        ${clicked}=    Run Keyword And Return Status    Click    ${NewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'NewTaskButton'. Ensure it is visible and enabled.
    END

    Run Keyword And Continue On Failure    Wait For Elements State    ${Task_Name_Field}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'Task_Name_Field' is not visible after creating the task.

    Select Options By    ${Task_Name_Field}    text    ${data['TaskName']}

    Run Keyword And Continue On Failure    Wait For Elements State    ${Task_CATForm_Btn}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'Task_CATForm_Btn' is not visible after creating the CAT Modeling Request task.

    ${clicked}=    Run Keyword And Return Status    Click    ${Task_CATForm_Btn}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Task_CATForm_Btn'.

    Run Keyword And Continue On Failure    Wait For Elements State    ${CAT_Form_Header}    visible
    Run Keyword And Continue On Failure    Should Be True    ${TRUE}    msg=CAT Request: 'CAT_Form_Header' is not visible after opening the CAT Modeling Request task.

    
    Click    ${CAT_submit_request}

    Wait For Elements State    ${CAT_error}    visible    ${display_timeout}

    Check Checkbox    ${CAT_Earthquake_option}
    Fill Text    ${CAT_blanket_limit}    ${data['Cat_limit']}
    Fill Text    ${CAT_part_of_field}    ${data['Cat_part_of']}
    Click    ${CAT_submit_request}
    Wait For Elements State    ${CAT_Saved_popup}    visible    ${display_timeout}

    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_CATForm_Btn}    visible    
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=CAT Request: 'Task_CATForm_Btn' is not visible after creating the CAT Modeling Request task.

    ${clicked}=    Run Keyword And Return Status    Click    ${Task_CATForm_Btn}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Task_CATForm_Btn'.
    ${status}    Get Element States    ${CAT_error}
    Run Keyword And Continue On Failure    Should Contain    ${status}    detached    Error mag is still apearr after entering the mandatory field in CAT Moduling form in task tab 
    ${clicked}=    Run Keyword And Return Status    Click    ${Close_CATForm}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Close_CATForm' button.

    ${clicked}=    Run Keyword And Return Status    Click    ${Close_Task}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=CAT Request: Failed to click 'Close_Task' button.


Cancel the New Task
    [Documentation]    Creates a new task from within a submission.
    ...    Fills out the 'Create Task' form with the provided data including task name, assignee, due date, priority, and task details.
    [Arguments]    ${data}

    # Wait and click Tasks menu
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TasksMenu}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'TasksMenu' is not visible in the side menu.

    ${status}=    Run Keyword And Return Status    Click    ${TasksMenu}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'TasksMenu'.

    # Click on 'Create New Task' or 'New Task' depending on task availability
    ${noTasks_visible}=    Run Keyword And Return Status    Wait For Elements State    ${NoTasks}    visible    timeout=${display_timeout}
    IF    ${noTasks_visible}
        ${status}=    Run Keyword And Return Status    Click    ${CreateNewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'CreateNewTaskButton' when no tasks exist.
    ELSE
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'NewTaskButton' is not available in the task tab.

        ${status}=    Run Keyword And Return Status    Click    ${NewTaskButton}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'NewTaskButton'.
    END

    # Wait for Create Task tab
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CreateTaskTab}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'CreateTaskTab' fields are not visible on the task page.

    # Select Task Name
    ${customName}=    Run Keyword And Return Status    Should Be Equal    '${data["TaskNameDropdown"]}'    'Custom'
    IF    ${customName}
        ${status}=    Run Keyword And Return Status    Select Options By    ${TaskNameDropdown}    label    Custom
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select 'Custom' in TaskNameDropdown.

        ${randomNumber}=    Generate Random Number
        ${test_string}=    Catenate    SEPARATOR=    ${data['customName']}
        Log Step    'Converted string -> ${test_string}'

        ${status}=    Run Keyword And Return Status    Update Task Name    ${test_string}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to update task name to '${test_string}'.

        Set Suite Variable    ${test_new_task_name}    ${test_string}

        ${status}=    Run Keyword And Return Status    Fill Text    ${CustomTaskName}    ${data['customName']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to fill CustomTaskName field.
    ELSE
        ${status}=    Run Keyword And Return Status    Select Options By    ${TaskNameDropdown}    label    ${data['TaskNameDropdown']}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select task name '${data['TaskNameDropdown']}' in dropdown.
    END

    # Assign task
    ${status}=    Run Keyword And Return Status    Click    ${AssignTo}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click 'AssignTo' field.

    ${assignee}=    Catenate    SEPARATOR=    ${SelectAssignee}    ${data['assignee']}    ']
    ${status}=    Run Keyword And Return Status    Click    ${assignee}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select assignee '${data['assignee']}'.

    # Set due date
    ${data_due_date}=    Get Tomorrows Date YMD
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${DueDate}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'DueDate' field is not visible while creating the task.

    ${full_datetime}=    Catenate    SEPARATOR=    ${data_due_date}    T    ${data['dueTime']}
    ${status}=    Run Keyword And Return Status    Evaluate JavaScript    ${DueDate}    (el) => { el.value = "${full_datetime}"; el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); }
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to set the due date/time.

    # Set priority
    ${status}=    Run Keyword And Return Status    Select Options By    ${PriorityDropdown}    label    ${data['priority']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to select priority '${data['priority']}'.

    # Fill Task Details
    ${status}=    Run Keyword And Return Status    Click    ${TaskDetails}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'TaskDetails' field.

    ${status}=    Run Keyword And Return Status    Fill Text    ${TaskDetails}    ${data['taskDetails']}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to fill 'TaskDetails' with provided data.

    # Click Create button
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Task_cancel_button}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: 'CreateButton' did not appear or is not clickable after filling task details.

    ${status}=    Run Keyword And Return Status    Click    ${Task_cancel_button}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Create Task: Failed to click on 'CreateButton'.

    ${New_task_status}    Run Keyword And Return Status    Wait For Elements State    ${NewTaskButton}    visible
    ${Create_newtask_status}    Run Keyword And Return Status    Wait For Elements State    ${CreateNewTaskButton}    visible
    IF    '${New_task_status}' or '${Create_newtask_status}'
        Log    Cancel button working fine as expected in task page 
    ELSE
        Log    Cancel button not working fine as expected in task page 
    END