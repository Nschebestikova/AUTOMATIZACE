

*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://practicetestautomation.com/practice-test-login/
${URL_S}    https://practicetestautomation.com/logged-in-successfully/

*** Test Cases ***

Wrong Login
    Login               expert                    Password123
    User wrong login
Wrong Password
    Login               student                   123456PAS
    User wrong password
Login Success
    Login               student                   Password123
    User is logged in
    User has logged out

*** Keywords ***

Login
    [Arguments]     ${login}      ${password}

    log             ${login}
    log             ${password}


    New Browser           CHROMIUM          headless=false
    New Page              ${URL}
    Get Title            *=                 Test Login | Practice Test Automation
    Type Text            id=username        ${login}
    Type Text            id=password        ${password}
    Click                id=submit
    Take Screenshot


User is logged in
       Get Text        css=[class=post-title]        ==        Logged In Successfully      # AssertPoz1
       Get Url                                       ==        ${URL_S}           # AssertPoz2
       Take Screenshot

User has logged out

        Click        css=.wp-block-button__link.has-text-color.has-background.has-very-dark-gray-background-color
        Get Text        css=[id=submit]              *=         Submit
        Take Screenshot

User wrong login
        Get Text   //*[@id="error"]                  ==        Your username is invalid!      # AssertNeg1
        Take Screenshot

User wrong password
        Get Text   //*[@id="error"]                  ==        Your password is invalid!      # AssertNeg1
        Take Screenshot
