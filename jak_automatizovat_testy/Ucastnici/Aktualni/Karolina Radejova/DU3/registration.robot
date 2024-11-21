*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Keywords ***
Fill registration form
    [Arguments]     ${name}     ${email}    ${password}     ${password_verification}
    Log             ${name}
    Log             ${email}
    Log             ${password}

    New Browser     chromium    headless=false
    New Context     viewport={'width': 1920, 'height': 1080}
    New Page        ${URL}
    Click           data-test=login_link
    Log             Button was clicked
    Get Url         *=  login
    Log             Url contains "kitner.cz/login"
    Click           data-test=register_link
    Get Url         *=  kitner.cz/register
    Log             Registration page is opened
    Fill Text       data-test=name_input                ${name}
    Log             Name is filled
    Fill Text       data-test=email_input               ${email}
    Log             Email is filled
    Fill Text       data-test=password_input            ${password}
    Log             Password is filled
    Fill Text       data-test=password_again_input      ${password_verification}
    Log             Password again is filled
    Click           data-test=register_button
    Log             Register button was clicked

Successfull registration
    [Arguments]                 ${name}        ${email}     ${password}     ${password_verification}

    Fill registration form      ${name}     ${email}        ${password}     ${password_verification}
    Log         User was registered
    Get Text    data-test=home_section      ==      Vítej uživateli ${name}!
    Log         Home page with correct welcome msg is displayed

Email has already taken
    [Arguments]                 ${name}     ${email}    ${password}     ${password_verification}

    Fill registration form      ${name}    ${email}    ${password}      ${password_verification}
    Get Text    data-test=email_input_errors      ==      The email has already been taken.
    Log         Email has already been taken message is displayed
    
Password has to be 8 characters long
    [Arguments]                 ${name}     ${email}    ${password}     ${password_verification}
    
    Fill registration form      ${name}     ${email}    ${password}     ${password_verification}
    Get Text    data-test=password_input_errors     ==      The password field must be at least 8 characters.
    Log         The password field must be at least 8 characters message is displayed

Password field confirmation does not match
    [Arguments]                 ${name}     ${email}    ${password}     ${password_verification}
    
    Fill registration form      ${name}     ${email}    ${password}     ${password_verification}
    Get Text    data-test=password_input_errors     ==      The password field confirmation does not match.
    Log         Password field confirmation does not match message is displayed

*** Test Cases ***
User is registered
    Successfull registration    user18    user18@user.com    somethingstupid    somethingstupid

Email exists
    Email has already taken    user1    user1@user1.com    somethingsomething   somethingsomething

Password has to be 8 characters long
    Password has to be 8 characters long    user14    user14@user.com    abcdef     abcdef

Password field confirmation does not match
    Password field confirmation does not match    random16    random123@random.com    somethingclever    somethingstupid
