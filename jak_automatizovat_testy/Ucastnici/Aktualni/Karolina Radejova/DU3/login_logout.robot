*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses

*** Keywords ***
Open login page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Click           data-test=login_link
    Log             Button was clicked
    Get Url     *=  login
    Log             Url contains "kitner.cz/login"

Fill and send login form
    [Arguments]     ${email}     ${password}

    Open login page
    #CSS selector via atributte data-testid
    #Type Text    css=[data-testid=email_input]       ${email}
    #XPATH selector (select all inputs that have attribute named id and it is equal to email_input)
    Type Text     xpath=//input[@id='email_input']    ${email}
    Log           ${email} is filled
    #CSS selector via atributte data-test - the best way to select selector (it is supported via Browser library
    Type Text     data-test=password_input    ${password}
    #CSS selector via class
    #Type Text    css=#password_input    ${password}
    #XPATH selector
    #Type Text     xpath=//input[@id='password_input']    ${password}
    Log           ${password} is filled
    #CSS selector via attribute data-test
    #Click        data-test=login_button
    Click         xpath=//button[@type='submit']|//button[@id='login_button']
    Log           Login button was clicked

Check user is logged in
    Get Text    data-test=logout_button     ==      Odhlásit se
    Log         Button Logout is displayed, user is logged

Check user is logged out
    Get Text    data-test=login_link        ==      Přihlásit se
    Log         Login button is displayed, user is logged out

Forgotten password
    [Arguments]     ${email}
    
    Open login page
    Check user is logged out
    Click       xpath=//a[@id='forgot_password_link']|//a[@href='/forgot_password']
    Get Url     *=      kitner.cz/forgot-password
    Log         Page /forgot_password is opened
    Type Text   xpath=//input[@type='email']|//input[@placeholder='Email']    ${email}
    Log         ${email} was filled
    Click       //button[@data-test='submit_button']
    Log         Submit button was clicked
    
Registration link
    Open login page
    Check user is logged out
    Click       xpath=//a[@id='register_link']|//a[@data-test='register_link']
    Get Url     *=      kitner.cz/register
    Log         Registration form was opened

*** Test Cases ***

User is successfully logged in and logged out
    Open login page
    Check user is logged out
    Fill and send login form    user1@user1.com    somethingclever
    Check user is logged in
    Wait For Elements State     xpath=//h1[@data-test='courses_title']     visible
    Take Screenshot
    Click                       data-test=logout_button
    Log                         Logout button was clicked
    Check user is logged out
    Wait For Elements State     xpath=//a[@data-test='login_link']     visible
    Take Screenshot

User is not logged in - wrong email
    Open login page
    Check user is logged out
    Fill and send login form    user111@user.com    somethingclever
    Get Text                    data-test=email_input_errors        ==      These credentials do not match our records.
    Log                         "These credentials do not match our records." message is displayed
    Check user is logged out
    Take Screenshot

User is not logged in - wrong password
    Open login page
    Check user is logged out
    Fill and send login form    user1@user1.com    somethingclever1
    Get Text                    data-test=email_input_errors        ==      These credentials do not match our records.
    Log                         "These credentials do not match our records." message is displayed
    Check user is logged out
    Take Screenshot

Forgotten password - wrong email
    Forgotten password          random2734@random.cz
    Take Screenshot

Forgotten password - correct email
    Forgotten password          user1@user1.com
    Get Text                    xpath=//div[@data-test='status_div']      ==      We have emailed your password reset link.
    Take Screenshot

User without account
    Registration link
    Take Screenshot