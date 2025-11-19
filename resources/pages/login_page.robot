*** Settings ***
Resource   ../../utils/common_keywords.robot
Variables  ../locators/login_locators.py

*** Keywords ***
# Login with username and password
#     [Documentation]    Performs the login action using a username and password.
#     ...    It handles the multi-step login process of entering the email, clicking next, and then entering the password.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_userName}`: The username (email) to log in with.
#     ...    - `${data_password}`: The password for the account.
#     [Arguments]    ${data_userName}    ${data_password}
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email    ${Email}    visible    Email is not avilable in Login page
#     # Wait For Elements State    ${Email}    visible
#     Type Text    ${Email}    ${data_userName}
#     # Wait For Elements State    ${NextButton}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    Email    ${Email}    visible    Email is not avilable in Login page
#     Click    ${NextButton}
#     # Wait For Elements State    ${LoginUser}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginUser    ${LoginUser}    visible    LoginUser is not avilable in Login page
#     Fill Text    ${LoginUser}    ${data_userName}
#     # Wait For Elements State    ${LoginPassword}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginPassword    ${LoginPassword}    visible    LoginPassword is not avilable in Login page
#     Fill Text    ${LoginPassword}    ${data_password}
#     # Wait For Elements State    ${LoginButton}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginButton    ${LoginButton}    enabled    LoginButton is not avilable in Login page
#     Click    ${LoginButton}
Login With Username And Password
    [Documentation]    Performs login using username and password.
    [Arguments]    ${data_userName}    ${data_password}

    # Wait for Email field and type username
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${Email}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=Email field not available on Login page
    ${typedEmail}=    Run Keyword And Return Status    Type Text    ${Email}    ${data_userName}
    Run Keyword And Continue On Failure    Should Be True    ${typedEmail}    Failed to type email in Email field in the login page 

    # Click Next Button
    ${nextClicked}=    Run Keyword And Return Status    Click    ${NextButton}
    Run Keyword And Continue On Failure    Should Be True    ${nextClicked}    Next button was not clickable in the login page

    # Wait for Login Username field and type username
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${LoginUser}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=LoginUser field not available
    ${typedUser}=    Run Keyword And Return Status    Fill Text    ${LoginUser}    ${data_userName}
    Run Keyword And Continue On Failure    Should Be True    ${typedUser}    Failed to type username in LoginUser field in the login page

    # Wait for Login Password field and type password
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${LoginPassword}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=LoginPassword field not available
    ${typedPassword}=    Run Keyword And Return Status    Fill Text    ${LoginPassword}    ${data_password}
    Run Keyword And Continue On Failure    Should Be True    ${typedPassword}    Failed to type password in LoginPassword field in the login page

    # Click Login Button
    ${loginClicked}=    Run Keyword And Return Status    Click    ${LoginButton}
    Run Keyword And Continue On Failure    Should Be True    ${loginClicked}    Login button was not clickable after enter the username and password in the login page


# Login with username and password After Logout
#     [Documentation]    Performs the login action using a username and password.
#     ...    It handles the multi-step login process of entering the email, clicking next, and then entering the password.
#     ...
#     ...    *Arguments:*
#     ...    - `${data_userName}`: The username (email) to log in with.
#     ...    - `${data_password}`: The password for the account.
#     [Arguments]    ${data_userName}    ${data_password}
#     # Wait For Elements State    ${LoginUser}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginUser    ${LoginUser}    visible    LoginUser is not avilable in Login page
#     Fill Text    ${LoginUser}    ${data_userName}
#     # Wait For Elements State    ${LoginPassword}    visible
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginPassword    ${LoginPassword}    visible    LoginPassword is not avilable in Login page
#     Fill Text    ${LoginPassword}    ${data_password}
#     # Wait For Elements State    ${LoginButton}    enabled
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginButton    ${LoginButton}    enabled    LoginButton is not avilable in Login page
#     Click    ${LoginButton}
# Login With Username And Password After Logout
#     [Documentation]    Performs login using username and password after logout.
#     [Arguments]    ${data_userName}    ${data_password}

#     # Wait for Login User field and type username
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginUser    ${LoginUser}    visible    LoginUser is not available on login page
#     ${typedUser}=    Run Keyword And Return Status    Fill Text    ${LoginUser}    ${data_userName}
#     Run Keyword And Continue On Failure    Should Be True    ${typedUser}    Failed to type username in LoginUser field in the login page

#     # Wait for Login Password field and type password
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginPassword    ${LoginPassword}    visible    LoginPassword is not available on login page
#     ${typedPassword}=    Run Keyword And Return Status    Fill Text    ${LoginPassword}    ${data_password}
#     Run Keyword And Continue On Failure    Should Be True    ${typedPassword}    Failed to type password in Login Password field in the login page

#     # Wait for Login Button and click
#     Run Keyword And Continue On Failure    Wait For Element With Message    LoginButton    ${LoginButton}    enabled    LoginButton is not available on login page
#     ${clickedLogin}=    Run Keyword And Return Status    Click    ${LoginButton}
#     Run Keyword And Continue On Failure    Should Be True    ${clickedLogin}    Login button was not clickable after enter the username and password in the login page

Login With Username And Password After Logout
    [Documentation]    Performs login using username and password after logout.
    [Arguments]    ${data_userName}    ${data_password}

    # Username
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${LoginUser}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=LoginUser field is not available on login page
    ${typed}=    Run Keyword And Return Status    Fill Text    ${LoginUser}    ${data_userName}
    Run Keyword And Continue On Failure    Should Be True    ${typed}    msg=Failed to type username in LoginUser field

    # Password
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${LoginPassword}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=LoginPassword field is not available on login page
    ${typed}=    Run Keyword And Return Status    Fill Text    ${LoginPassword}    ${data_password}
    Run Keyword And Continue On Failure    Should Be True    ${typed}    msg=Failed to type password in LoginPassword field

    # Login button
    ${visible}=    Run Keyword And Return Status    Wait For Elements State    ${LoginButton}    enabled    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${visible}    msg=LoginButton is not enabled or not visible on login page
    ${clicked}=    Run Keyword And Return Status    Click    ${LoginButton}
    Run Keyword And Continue On Failure    Should Be True    ${clicked}    msg=Failed to click LoginButton after entering credentials


# Verify Home Page is Displayed
#     [Documentation]    Verifies that the user has successfully logged in by checking for an element on the home page.
#     Wait For Element With Message    MyAccount    ${MyAccount}    visible    the Home page is Not displayed after login waiting for My account to be visible

Verify Home Page Is Displayed
    [Documentation]    Verifies that the user has successfully logged in by checking for an element on the home page.
    
    ${status}=    Run Keyword And Return Status    Wait For Elements State    ${MyAccount}    visible    timeout=${element_timeout}
    Run Keyword And Continue On Failure    Should Be True    ${status}    Home page verification failed: 'My Account' element not visible after login
