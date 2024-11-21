*** Settings ***
Library    Browser
Resource        Testdata.robot
Suite Setup       Open Browser    https://www.zajezdy.cz/    Chromium
Suite Teardown    Close Browser

*** Keywords ***

Browser Settings
    New Browser         chromium    headless=false
    New Page            ${URL1}
    Click               ${cookies}
    Get Text            ${SEL_Findsomething}
    Set Strict Mode     False
    Take Screenshot


Login
    [Arguments]         ${email}      ${heslo}
    Click               ${SEL_LoginLink}
    Type Text           ${SEL_LoginFormEmail}     ${e-mail}
    Type Text           ${SEL_LoginFormPwd}  ${heslo}
    Click               ${SEL_UserLoginBtn}
    Take Screenshot

Logout
    Click               ${SEL_MyAcount}
    Sleep               2
    Click               ${SEL_UserLogoutBtn}
    Take Screenshot
    Close Browser

