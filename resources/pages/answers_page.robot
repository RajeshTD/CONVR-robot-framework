*** Settings ***
Resource     ../../utils/common_keywords.robot
Variables     ../locators/answers_locators.py

*** Keywords ***

# Click Answers Tab
#     [Documentation]    Navigates to the 'Answers' tab within a submission.
#     Wait For Element With Message    AnswerTab    ${Answers_Tab}    visible    Wait for Answer tab to verify that answer tab present in the Side bar menu    timeout=${element_timeout}
#     # Handle Future Dialogs    action=accept    
#     # ${promise} =         Promise To    Wait For Alert    action=accept
#     Click    ${Answers_Tab}
#     # Run Keyword And Ignore Error    Wait For      ${promise}
#     Wait For Element With Message    Answer Header    ${Answers}    visible    wait for the Answer Header to verify that the answer tab opened Sucesfully    
Click Answers Tab
    [Documentation]    Navigates to the 'Answers' tab within a submission and verifies it opened successfully.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers_Tab}    visible    timeout=${display_timeout}
    Should Be True    ${tab_visible}    msg=Click Answers Tab: 'Answers' tab is not visible in the side menu. Cannot proceed to open it.

    ${clicked}=    Run Keyword And Return Status    Click    ${Answers_Tab}
    Should Be True    ${clicked}    msg=Click Answers Tab: Failed to click the 'Answers' tab. Ensure it is enabled and not obscured.

    ${header_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers}    visible    timeout=${display_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${header_visible}    msg=Click Answers Tab: 'Answer Header' did not appear after clicking the tab. Verify the tab content loaded successfully.

# Verify Answers Lists
#     [Documentation]    Iterates through different categories of questions (e.g., Auto, Crime, General) on the Answers page.
#     ...    For each category, it expands the section and then clicks on each question to verify that an answer rationale or an AI-generated answer is displayed.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_questions}`: A dictionary where keys are the answer categories and values are lists of question texts to verify within that category.
#     [Arguments]    ${data_questions}
#     ${lists}    Get Elements    ${Answers_List}
#     FOR    ${list}    IN    @{lists}
#         ${listValues}    Get Text    ${list}
#         ${text}    Strip String    ${listValues}
#         Click    ${list}
#         IF    "${text}" == "Auto"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Auto']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "Crime"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Crime']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "General"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['General']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "General Liability"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['General Liability']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "Manufacturing"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Manufacturing']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "Property Risk"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Property Risk']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "Umbrella"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Umbrella']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         ELSE IF    "${text}" == "Workers' Comp"
#             Log    ${text}
#             FOR    ${question}    IN    @{data_questions['Workers Comp']}
#                 ${locator}    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]
#                 Scroll To Element    ${locator}
#                 # Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
#                 Wait For Element With Message    locator    ${locator}    visible
#                 Click    ${locator}
#                 ${rationable}    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
#                 ${ai_answer_status}    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
#                 Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}
#                 Click    ${Answer_Popup}
#             END
#         END
#     END
Verify Answers Lists
    [Documentation]    Iterates through different categories of questions (e.g., Auto, Crime, General, etc.) on the Answers page.
    ...    Expands each category section and clicks on each question to verify that an answer rationale or an AI-generated answer is displayed.
    [Arguments]    ${data_questions}

    ${lists}=    Get Elements    ${Answers_List}

    FOR    ${list}    IN    @{lists}
        ${listText}=    Get Text    ${list}
        ${text}=    Strip String    ${listText}

        # Expand category
        ${status}=    Run Keyword And Return Status    Click    ${list}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to expand category '${text}'.

        # Handle Auto category
        IF    "${text}" == "Auto"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Auto']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Auto category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Auto category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Auto category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Auto category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Auto category.
            END

        # Handle Crime category
        ELSE IF    "${text}" == "Crime"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Crime']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Crime category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Crime category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Crime category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Crime category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Crime category.
            END

        # Handle General category
        ELSE IF    "${text}" == "General"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['General']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in General category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in General category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in General category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in General category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in General category.
            END

        # Handle General Liability category
        ELSE IF    "${text}" == "General Liability"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['General Liability']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in General Liability category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in General Liability category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in General Liability category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in General Liability category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in General Liability category.
            END

        # Handle Manufacturing category
        ELSE IF    "${text}" == "Manufacturing"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Manufacturing']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Manufacturing category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Manufacturing category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Manufacturing category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Manufacturing category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Manufacturing category.
            END

        # Handle Property Risk category
        ELSE IF    "${text}" == "Property Risk"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Property Risk']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Property Risk category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Property Risk category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Property Risk category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Property Risk category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Property Risk category.
            END

        # Handle Umbrella category
        ELSE IF    "${text}" == "Umbrella"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Umbrella']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Umbrella category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Umbrella category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Umbrella category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Umbrella category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Umbrella category.
            END

        # Handle Workers' Comp category
        ELSE IF    "${text}" == "Workers' Comp"
            Log    Processing category: ${text}
            FOR    ${question}    IN    @{data_questions['Workers Comp']}
                ${locator}=    Catenate    SEPARATOR=    ${Questions}"    ${question}"])[1]

                ${status}=    Run Keyword And Return Status    Scroll To Element    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to question '${question}' in Workers Comp category.

                ${status}=    Run Keyword And Return Status    Wait For Elements State    ${locator}    visible    timeout=${element_timeout}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Question '${question}' in Workers Comp category not visible within timeout.

                ${status}=    Run Keyword And Return Status    Click    ${locator}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click question '${question}' in Workers Comp category.

                ${rationable}=    Run Keyword And Return Status    Get Element States    ${Answer_Rationable}    validate    value & visible    'Answer_Rationable should be visible.'
                ${ai_answer_status}=    Run Keyword And Return Status    Get Element States    ${AI_Answer}    validate    value & visible    'AI_Answer should be visible.'
                Run Keyword And Continue On Failure    Should Be True    ${rationable} or ${ai_answer_status}    Neither Answer_Rationable nor AI_Answer is visible for question '${question}' in Workers Comp category.

                ${status}=    Run Keyword And Return Status    Click    ${Answer_Popup}
                Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Answer popup for question '${question}' in Workers Comp category.
            END

        END
    END


# Verify Company Website Link
#     [Documentation]    Verifies that the company website link in the Answers section opens a new page with the correct title.
#     ...
#     ...    *Arguments:*
#     ...    - `${expected_Title}`: The expected title of the page that opens after clicking the link.
#     [Arguments]    ${expected_Title}
#     ${status}    Run Keyword And Return Status    Get Element States    ${Website_Link}    validate    value & visible    'Website_Link should be visible.'
#     IF    ${status} == True
#         Click    ${Website_Link}
#         Switch Page    NEW
#         Wait For Load State    load
#         ${page_title}    Get Title
#         Run Keyword And Continue On Failure    Should Be Equal    ${page_title}    ${expected_Title}
#         Close Page
#         Switch Page    CURRENT
#         Wait For Element With Message    AnswerHeader    ${Answers}    visible    Wait for the Answer Header to verify that the company website link opened in new tab and return to Answer tab    timeout=${element_timeout}
#     END

Verify Company Website Link
    [Documentation]    Verifies that the company website link in the Answers section opens a new page with the correct title.
    ...    *Arguments:*
    ...    - `${expected_Title}`: The expected title of the page that opens after clicking the link.
    [Arguments]    ${expected_Title}

    # Step 1: Verify Website_Link is visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Website_Link}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Website_Link should be visible before attempting to click.

    # Step 2: Click the Website Link if visible
    IF    ${status}
        ${click_status}=    Run Keyword And Return Status    Click    ${Website_Link}
        Run Keyword And Continue On Failure    Should Be True    ${click_status}    Failed to click on the Website_Link in the Answers section.

        # Step 3: Switch to the new page
        ${switch_status}=    Run Keyword And Return Status    Switch Page    NEW
        Run Keyword And Continue On Failure    Should Be True    ${switch_status}    Failed to switch to new page after clicking Website_Link.

        # Step 4: Wait for the page to fully load
        Run Keyword And Continue On Failure    Wait For Load State    load
        Log    New page opened successfully, verifying page title.

        # Step 5: Validate page title matches the expected title
        ${page_title}=    Get Title
        Run Keyword And Continue On Failure    Should Be Equal    ${page_title}    ${expected_Title}    Page title mismatch after opening the company website link. Expected '${expected_Title}', but got '${page_title}'.

        # Step 6: Close the new page and switch back
        ${close_status}=    Run Keyword And Return Status    Close Page
        Run Keyword And Continue On Failure    Should Be True    ${close_status}    Failed to close the new page after verification.

        ${switch_back}=    Run Keyword And Return Status    Switch Page    CURRENT
        Run Keyword And Continue On Failure    Should Be True    ${switch_back}    Failed to switch back to the current page after closing website tab.

        # Step 7: Verify Answers header visible again
        ${answers_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Answers}    visible    timeout=${element_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${answers_visible}    Failed to verify 'Answers' header after returning from company website tab.
    ELSE
        Log    Website link not visible, skipping verification.
    END
    # Scroll To Element    ${Website_Link}
    # Wait For Elements State    ${Website_Link}    visible    
    # Click    ${Website_Link}
    # Switch Page    NEW
    # Wait For Load State    load
    # ${page_title}    Get Title
    # Should Be Equal    ${page_title}    ${expected_Title}
    # Close Page
    # Switch Page    CURRENT
    # Wait For Elements State    ${Answers}    visible   
    # 

# Verify the Score In Answers Tab

#     [Documentation]    This method verifies that the score displayed in the Answers tab matches the score shown on the Submission page.

#     [Arguments]    ${Data}    @{ColumnValues}
#     Navigate To All Submissions page from submissions
#     ${Actual_Score}    Select Submission using submission id Draft    ${Data}    @{ColumnValues}
#     Verify Submission page is displayed
#     Click Answers Tab

#     # Wait For Elements State    ${Ans_ScoreValue}
#     Wait For Element With Message    Ans_ScoreValue    ${Ans_ScoreValue}    visible
#     ${ExceptedScoreValue}    Get Text    ${Ans_ScoreValue}
#     Log    'The Scorevalue shown in answer tab is ${ExceptedScoreValue}' 
#     Run Keyword And Continue On Failure    Should Be Equal    ${ExceptedScoreValue}    ${Actual_Score}   
Verify the Score In Answers Tab
    [Documentation]    Verifies that the score displayed in the Answers tab matches the score shown on the Submission page.
    [Arguments]    ${Data}    @{ColumnValues}

    # Navigate to All Submissions
    Navigate To All Submissions page from submissions

    # Select submission
    ${Actual_Score}=    Select Submission using submission id Draft    ${Data}    @{ColumnValues}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${Actual_Score}    msg=Failed to select submission or retrieve actual score.

    # Verify submission page is displayed
    Verify Submission page is displayed

    # Click Answers Tab
    Click Answers Tab

    # Wait for score element to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${Ans_ScoreValue}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    msg=Score value element in Answers Tab is not visible.

    # Get and verify score
    ${ExpectedScoreValue}=    Get Text    ${Ans_ScoreValue}
    Log    The Score value shown in Answers tab is ${ExpectedScoreValue}
    Run Keyword And Continue On Failure    Should Be Equal    ${ExpectedScoreValue}    ${Actual_Score}    msg=Score mismatch: Expected ${Actual_Score}, but found ${ExpectedScoreValue}. 