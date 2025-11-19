*** Settings ***
Resource     ../../utils/common_keywords.robot
Variables     ../locators/risk360_locators.py

*** Keywords ***
# Verify Risk360 Card Pages Navigation
#     [Documentation]    Verifies that clicking on each card on the Risk360 page navigates to the correct corresponding page.
#     ...
#     ...    *Arguments:*
#     ...    - `@{card_names_List}`: A list of card names (the text visible on the card) to be clicked.
#     ...    - `@{card_pages_List}`: A list of expected page header texts, corresponding to each card.
#     [Arguments]    ${card_names_List}    ${card_pages_List}
#     # Handle Future Dialogs    action=accept    
#     # Click   ${Side_Bar_Risk360_Button}
#     Click   ${Risk360_Empty_Cards}
#     ${card_names}=    Set Variable    @{card_names_List}
#     ${card_pages}=    Set Variable    @{card_pages_List}
#     ${length}=    Get Length    ${card_names}
#     FOR    ${index}    IN RANGE    0    ${length}
#         ${card}=    Get From List    ${card_names}    ${index}
#         ${CardLocator}=    Catenate    SEPARATOR=    ${Risk360_Cards}    ${card}']
#         Scroll To Element    ${CardLocator}
#         Click    ${CardLocator}
#         ${cardPageHeader}=    Get From List    ${card_pages}    ${index}
#         ${PageHeader}=    Catenate    SEPARATOR=    ${Risk360_Cards_Pages_Header}    ${cardPageHeader}')]
#         Get Element States    ${PageHeader}    validate    value & visible    'PageHeader should be visible.'
#         Click    ${Risk360_Cards_Pages_Close_Button}
#     END    
Verify Risk360 Card Pages Navigation
    [Documentation]    Verifies that clicking on each card on the Risk360 page navigates to the correct corresponding page.
    ...    *Arguments:*
    ...    - `@{card_names_List}`: A list of card names (the text visible on the card) to be clicked.
    ...    - `@{card_pages_List}`: A list of expected page header texts, corresponding to each card.
    [Arguments]    ${card_names_List}    ${card_pages_List}
    Switch To Risk360 Tab
    # Step 1: Click on Risk360 empty cards container
    ${status}=    Run Keyword And Return Status    Click    ${Risk360_Empty_Cards}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Risk360 empty cards container.

    # Step 2: Prepare card names and pages
    ${card_names}=    Set Variable    @{card_names_List}
    ${card_pages}=    Set Variable    @{card_pages_List}
    ${length}=    Get Length    ${card_names}

    # Step 3: Loop through each card
    FOR    ${index}    IN RANGE    0    ${length}
        ${card}=    Get From List    ${card_names}    ${index}
        ${CardLocator}=    Catenate    SEPARATOR=    ${Risk360_Cards}    ${card}']

        # Scroll to the card
        ${status}=    Run Keyword And Return Status    Scroll To Element    ${CardLocator}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to scroll to card '${card}' on Risk360 page.

        # Wait for card to be visible
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${CardLocator}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Card '${card}' not visible on Risk360 page.

        # Click the card
        ${status}=    Run Keyword And Return Status    Click    ${CardLocator}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on card '${card}'.

        # Verify page header
        ${cardPageHeader}=    Get From List    ${card_pages}    ${index}
        ${PageHeader}=    Catenate    SEPARATOR=    ${Risk360_Cards_Pages_Header}    ${cardPageHeader}')]

        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${PageHeader}    visible    timeout=${display_timeout}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Page header '${cardPageHeader}' not visible after clicking card '${card}'.

        # Close the page
        ${status}=    Run Keyword And Return Status    Click    ${Risk360_Cards_Pages_Close_Button}
        Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to close Risk360 card page for card '${card}'.
    END


# Switch to Risk360 tab
#     Run Keyword And Continue On Failure    Wait For Element With Message    Risk360 button    ${Side_Bar_Risk360_Button}    visible    wait for Risk360 button to verify that the Risk360 Tab is present in the side menu
#     Click    ${Side_Bar_Risk360_Button}
Switch To Risk360 Tab
    [Documentation]    Switches the view to the 'Risk360' tab for the current submission.

    ${tab_visible}=    Run Keyword And Return Status    Wait For Elements State    ${Side_Bar_Risk360_Button}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${tab_visible}    msg=Switch To Risk360 Tab: The 'Risk360' button is not visible in the side menu. Cannot proceed to click it.

    ${clicked}=    Run Keyword And Return Status    Click    ${Side_Bar_Risk360_Button}
    Should Be True    ${clicked}    msg=Switch To Risk360 Tab: Failed to click the 'Risk360' tab. Ensure the element is enabled, not obscured, and clickable.

# Verify NAICS is ReUpdated in Risk360 Tab

#     [Documentation]    This method verifies that after deleting and reprocessing, the NAICS returns to the same state 
#     [Arguments]    ${Value}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NAIC_Delete    ${NAIC_Delete}    visible    NAIC_Delete is not avilable in Risk360 page
#     # Wait For Elements State    ${NAIC_Delete}    visible
#     Click    ${NAIC_Delete}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NAIC_Reprocess    ${NAIC_Reprocess}    visible    NAIC_Reprocess is not avilable in Risk360 page
#     # Wait For Elements State    ${NAIC_Reprocess}    visible
#     Click    ${NAIC_Reprocess}

#     ${Actual_popup}    Get text    ${Reprocess_Popup}
#     Run Keyword And Continue On Failure    Should Be Equal    ${Value['ExceptedReprocessPopup']}    ${Actual_popup}
#     Run Keyword And Continue On Failure    Wait For Element With Message    NAIC_Reprocess    ${NAIC_Delete}    visible    NAIC_Delete is not avilable in Risk360 page
    # Wait For Elements State    ${NAIC_Delete}    visible    5s
Verify NAICS is ReUpdated in Risk360 Tab
    [Documentation]    Verifies that after deleting and reprocessing, the NAICS returns to the expected state.
    [Arguments]    ${Value}

    # Step 1: Wait for NAIC_Delete to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NAIC_Delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    NAIC_Delete is not available in Risk360 page.

    # Step 2: Click NAIC_Delete
    ${status}=    Run Keyword And Return Status    Click    ${NAIC_Delete}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on NAIC_Delete in Risk360 page.

    # Step 3: Wait for NAIC_Reprocess to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NAIC_Reprocess}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    NAIC_Reprocess is not available in Risk360 page.

    # Step 4: Click NAIC_Reprocess
    ${status}=    Run Keyword And Return Status    Click    ${NAIC_Reprocess}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on NAIC_Reprocess in Risk360 page.

    # Step 5: Verify Reprocess popup text
    ${Actual_popup}=    Get Text    ${Reprocess_Popup}
    Run Keyword And Continue On Failure    Should Be Equal    ${Actual_popup}    ${Value['ExceptedReprocessPopup']}    Reprocess popup text mismatch. Expected: '${Value['ExceptedReprocessPopup']}', Got: '${Actual_popup}'

    # Step 6: Verify NAIC_Delete visible again after reprocessing
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${NAIC_Delete}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    NAIC_Delete is not visible after reprocessing in Risk360 page.


# verify the Risk360 social media link
#     [Documentation]    This method is used to verify the Risk360 social media link
 
#     Switch to Risk360 tab
#      ${current_tab}=    Get Page Ids
#     ${first_tab}=    Set Variable    ${current_tab}[0]
#     ${status}    Get Element    ${Social_media_Link}
#     Run Keyword And Return Status    Should Contain    ${status}    visible
#     Click    ${Social_media_Link}
#     Switch Page    NEW
#     Wait For Load State    load
#     Run Keyword And Continue On Failure    Wait For Element With Message    linked_In_profile    ${linked_In_profile}    visible    linked_In_profile is not avilable in the new tab
#     # Wait For Elements State    ${linked_In_profile}    visible    10s    
#     ${Status}    Get Element States    ${linked_In_profile}
#     Run Keyword And Return Status    Should Contain    ${Status}    visible
#     ${all_tabs}=    Get Page Ids
#     ${second_tab}=    Set Variable    ${all_tabs}[1]
#     Run Keyword And Return Status    Should Not Be Equal    ${first_tab}    ${second_tab}
#     Close Page
#     Switch Page    CURRENT
#     ${status}    Get Element    ${Social_media_Link}
#     Run Keyword And Return Status    Should Contain    ${status}    visible
Verify Risk360 Social Media Link
    [Documentation]    Verifies that the Risk360 social media link opens a new page and that the LinkedIn profile is visible.
    
    # Step 1: Switch to Risk360 tab
    Switch To Risk360 Tab

    # Step 2: Capture current tabs
    ${current_tabs}=    Get Page Ids
    ${first_tab}=    Set Variable    ${current_tabs}[0]

    # Step 3: Verify Social Media Link is visible
    ${status}=    Run Keyword And Return Status    Get Element States    ${Social_media_Link}    validate    value & visible    'Social_media_Link should be visible in Risk360 tab.'
    Run Keyword And Continue On Failure    Should Be True    ${status}    Social_media_Link is not visible in Risk360 tab.

    # Step 4: Click the Social Media Link
    ${status}=    Run Keyword And Return Status    Click    ${Social_media_Link}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Failed to click on Social_media_Link.

    # Step 5: Switch to the new tab
    Switch Page    NEW
    Wait For Load State    load

    # Step 6: Wait for LinkedIn profile element to be visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${linked_In_profile}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    linked_In_profile is not available in the new tab.

    # Step 7: Verify LinkedIn profile element state
    ${status}=    Run Keyword And Return Status    Get Element States    ${linked_In_profile}    validate    value & visible    'linked_In_profile should be visible in new tab.'
    Run Keyword And Continue On Failure    Should Be True    ${status}    linked_In_profile is not visible in new tab.

    # Step 8: Validate that a new tab opened
    ${all_tabs}=    Get Page Ids
    ${second_tab}=    Set Variable    ${all_tabs}[1]
    Run Keyword And Continue On Failure    Should Not Be Equal    ${first_tab}    ${second_tab}    A new tab did not open after clicking Social_media_Link.

    # Step 9: Close the new tab and switch back
    Close Page
    Switch Page    CURRENT

    # Step 10: Verify Social Media Link is still visible in the original tab
    ${status}=    Get Element States    ${Social_media_Link}    validate    value & visible    'Social_media_Link should be visible after returning to original tab.'
    Run Keyword And Continue On Failure    Should Not Be Empty    ${status}    Social_media_Link is not visible after returning to original tab.


# Verify Elements Are Alphabetically Ordered
#     [Documentation]    This method is used to verify the given locators element or in alphabetical order or not
#     [Arguments]    ${locator}
#     ${elements}=    Get Elements    ${locator}
#     ${texts}=    Create List
#     FOR    ${el}    IN    @{elements}
#         ${text}=    Get Text    ${el}
#         Append To List    ${texts}    ${text}
#     END
#     ${sorted}=    Evaluate    sorted(${texts}, key=str.lower)
#     Run Keyword And Continue On Failure    Should Be Equal As Strings    ${texts}    ${sorted}    msg=Elements are not in alphabetical order  
Verify Elements Are Alphabetically Ordered
    [Documentation]    Verifies that the elements located by the given locator are in alphabetical order.
    [Arguments]    ${locator}

    # Step 1: Get all elements
    ${elements}=    Get Elements    ${locator}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${elements}    No elements found for locator: ${locator}.

    # Step 2: Extract text from each element
    ${texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Run Keyword And Continue On Failure    Should Not Be Empty    ${text}    Failed to get text from element: ${el}.
        Append To List    ${texts}    ${text}
    END

    # Step 3: Compare with sorted version
    ${sorted_texts}=    Evaluate    sorted(${texts}, key=str.lower)
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${texts}    ${sorted_texts}    Elements are not in alphabetical order for locator: ${locator}.
