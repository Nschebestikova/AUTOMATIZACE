

*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   Test login with check
Metadata    Created   3.1.2024

Library  Browser

*** Variables ***
${URL}      https://practicetestautomation.com/practice-test-login/
${URL_S}    https://practicetestautomation.com/logged-in-successfully/

*** Test Cases ***

Wrong Login
    Login               expert                    Password123       no
    User wrong login
Wrong Password
    Login               student                   123456PAS         no
    User wrong password
Login Success
    Login               student                   Password123       yes
    User is logged in
    User has logged out

*** Keywords ***

Login
    [Arguments]     ${login}      ${password}       ${text}

    log             ${login}
    log             ${password}


    New Browser           CHROMIUM          headless=false
    New Page              ${URL}
    Get Title            *=                 Test Login | Practice Test Automation
    Type Text            id=username        ${login}
    Type Text            id=password        ${password}
    Click                id=submit
    Take Screenshot


    IF    "${text}" == "yes"
       Get Text     css=[class=post-title]       ==            Logged In Successfully
       Log To Console    !!!Je prihlasen!!!
    ELSE
       Get Text     css=[id=submit]              ==            Submit
       Log To Console    !!!Neni prihlasen!!!
    END

User is logged in
       Get Text        css=[class=post-title]        ==        Logged In Successfully      # AssertPoz1

       Take Screenshot

User has logged out

        Click        css=.wp-block-button__link.has-text-color.has-background.has-very-dark-gray-background-color

        Take Screenshot

User wrong login
        Get Text   //*[@id="error"]                  ==        Your username is invalid!      # AssertNeg1
        Take Screenshot

User wrong password
        Get Text   //*[@id="error"]                  ==        Your password is invalid!      # AssertNeg1
        Take Screenshot

