*** Settings ***
Library     Browser
Resource    ../Project/Data_and_Config/TestData.robot
Resource    ../Project/Data_and_Config/Configuration.robot

Suite Setup     Before_suite
Suite Teardown  After_suite

Test Setup      Before_test
Test Teardown   After_test

*** Variables ***

*** Test Cases ***
User is successfuly logged in
    Login with control of button login/logout text    ${USER_EMAIL}                 ${USER_PASSWORD}    log in

User is not logged in - wrong password
    Login with control of button login/logout text    ${USER_EMAIL}                 wrongpassword      not log in
    Wrong credentials - error message

User is not logged in - wrong email
    Login with control of button login/logout text    randomuser12jhs@user.com      ${USER_PASSWORD}    not log in
    Wrong credentials - error message

User is successfully logged out
    Logout with control of button login/logout text   ${USER_EMAIL}                 ${USER_PASSWORD}    log out
    
User is not logged out
    Logout with control of button login/logout text   ${USER_EMAIL}                 ${USER_PASSWORD}    not log out

Forgotten password - wrong email
    Forgotten password          random2734@random.cz
    Wait For Elements State     ${SEL_email_input_errors}
    Get Text                    ${SEL_email_input_errors}                   ==      ${ERROR_MSG_email_does_not_exist}
    Take Screenshot

Forgotten password - correct email
    Forgotten password          ${USER_EMAIL}
    Get Text                    ${SEL_reset_password_text}                  ==      ${TEXT_reset_password}
    Take Screenshot

User without account
    Registration link
    Take Screenshot

*** Keywords ***
Logout with control of button login/logout text
    [Arguments]     ${email}        ${password}     ${should_be_logged_out}
    Login without control of button login/logout text    ${email}    ${password}

    IF    "${should_be_logged_out}" == "log out"
        Click       ${SEL_logoutButton}
        Get Text    ${SEL_loginLink}        ==      ${TEXT_prihlasit_se}
    ELSE
         Get Text   ${SEL_logoutButton}     ==      ${TEXT_odhlasit_se}
    END
    
    Take Screenshot

Login with control of button login/logout text
    [Arguments]     ${email}    ${password}     ${should_be_logged_in}
    Login without control of button login/logout text    ${email}    ${password}

    IF    "${should_be_logged_in}" == "log in"
        Get Text    ${SEL_logoutButton}     ==      ${TEXT_odhlasit_se}
    ELSE
         Get Text   ${SEL_loginLink}        ==      ${TEXT_prihlasit_se}
    END

    Take Screenshot

Login without control of button login/logout text
    [Arguments]     ${email}     ${password}

    Click           ${SEL_loginLink}
    Log             Button was clicked
    Get Url     *=  login
    Log             Url contains "${URL_login}"
    Type Text     ${SEL_email_input}        ${email}
    Log           ${email} is filled
    Type Text     ${SEL_password_input}     ${password}
    Log           ${password} is filled
    Click         ${SEL_login_button}
    Log           Login button was clicked

Wrong credentials - error message
    Get Text                    ${SEL_email_input_errors}        ==      ${ERROR_MSG_wrong_credentials}
    Log                         ${ERROR_MSG_wrong_credentials} message is displayed
    Take Screenshot

Forgotten password
    [Arguments]     ${email}

    Open login page
    Click       ${SEL_forgot_password_link}
    Get Url     *=      ${URL_forgot_password}
    Log         Page ${URL_forgot_password} is opened
    Type Text   ${SEL_email_input}    ${email}
    Log         ${email} was filled
    Click       ${SEL_submit_button}
    Log         Submit button was clicked

Registration link
    Open login page
    Click       ${SEL_register_link}
    Get Url     *=      ${URL_register}
    Log         Registration form was opened

Open login page
    Click           ${SEL_loginLink}
    Log             Button was clicked
    Get Url     *=  ${URL_login}
    Log             Url contains "${URL_login}"

Before_suite
   New Browser              chromium   headless=False
   Sleep                    ${SLEEP_BEFORE_TEST}

Before_test
#   New Browser              chromium   headless=False
   New Page                 ${URL}
   Set Browser Timeout      ${TimeOut_Browser}
   Sleep                    ${SLEEP_BEFORE_TEST}

After_test
    Go To                   ${URL}

After_suite
    Close Browser





