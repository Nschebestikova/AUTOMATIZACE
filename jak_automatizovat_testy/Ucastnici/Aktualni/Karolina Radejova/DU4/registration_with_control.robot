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
#registration via login page
User is successfully registered
    Fill and send registration form    ${USER_NAME}    ${USER_EMAIL_registration}       ${USER_PASSWORD}    ${USER_PASSWORD}     registered

User is not registered - email is already taken
    Fill and send registration form    ${USER_NAME}    ${USER_EMAIL}                    ${USER_PASSWORD}    ${USER_PASSWORD}     not registered
    Email has already taken

User is not registered - too short password
    Fill and send registration form    ${USER_NAME}    ${USER_EMAIL_registration2}      someth              someth               not registered
    Password has to be 8 characters long

User is not registered - password verification failed
    Fill and send registration form    ${USER_NAME}    ${USER_EMAIL_registration2}      ${USER_PASSWORD}    ${USER_PASSWORD}1    not registered
    Password field confirmation does not match

*** Keywords ***
Fill and send registration form
    [Arguments]     ${name}     ${email}    ${password}     ${password_verification}    ${should_be_registered}
    Log             ${name}
    Log             ${email}
    Log             ${password}

    Click           ${SEL_login_link}
    Log             Button was clicked
    Get Url         *=  ${URL_login}
    Log             Url contains "${URL_login}"
    Click           ${SEL_register_link}
    Get Url         *=  ${URL_register}
    Log             ${URL_register} page is opened
    Fill Text       ${SEL_name_input}                   ${name}
    Log             Name is filled
    Fill Text       ${SEL_email_input}                  ${email}
    Log             Email is filled
    Fill Text       ${SEL_password_input}               ${password}
    Log             Password is filled
    Fill Text       ${SEL_password_verification}        ${password_verification}
    Log             Password again is filled
    Click           ${SEL_register_button}
    Log             Register button was clicked
    
    IF    "${should_be_registered}" == "not registered"
        Get Url     *=      ${URL_register}
        Take Screenshot
    ELSE
        Get Text    ${SEL_home_section}     ==      ${TEXT_welcome_user} ${name}!
        Log         Home page with ${TEXT_welcome_user} is displayed
        Take Screenshot
    END

 Email has already taken
    Get Text    ${SEL_email_taken}      ==      ${ERROR_MSG_already_taken_email}
    Log         ${ERROR_MSG_already_taken_email} message is displayed
    Take Screenshot

 Password has to be 8 characters long
    Get Text    ${SEL_short_password}        ==      ${ERROR_MSG_short_password}
    Log         ${ERROR_MSG_short_password} message is displayed
    Take Screenshot

 Password field confirmation does not match
    Get Text    ${SEL_password_wrong_confirmation}        ==      ${ERROR_MSG_password_confirmation}
    Log         ${ERROR_MSG_password_confirmation} message is displayed
    Take Screenshot

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