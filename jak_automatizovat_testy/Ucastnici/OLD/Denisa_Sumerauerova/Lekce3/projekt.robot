*** Settings ***
Library  Browser

*** Variables ***
${url}  http://testovani.kitner.cz/login

*** Keywords ***
Get to the page
    New Browser  chromium       headless=false
    New Page  ${url}
    Get Title   ==   Testování   # ověření, že se stránka otevřele správně

Login
    [Arguments]     ${email}        ${password}
    log             ${email}
    log             ${password}


*** Test Cases ***

Login
    Get to the page

    Get Text        //div[@data-testid="login_button"]
    Login       denisa.sumerauerova@tesena.com      heslo789
    Click  data-test="login_button"

Logout
    Get to the page

    Get Text     //div[@data-testid="logout_button"]
    Click  data-test="logout_button"

    Sleep 3
