*** Settings ***
Library  Browser

*** Keywords ***

Přihlásit se na webovou stránku
   [Arguments]    ${username}    ${password}
   New Browser      headless=False
   Open Browser     http://testovani.kitner.cz/courses    chromium
   Click            data-test=login_link
   Type Text        data-test=email_input            ${username}
   Type Text        data-test=password_input         ${password}
   Click            data-test=login_button

Odhlásit se z webové stránky
    Click    data-test=logout_button
    [Teardown]    Close Browser

*** Test Cases ***

Přihlášení a odhlášení
    Přihlásit se na webovou stránku    giyipem264@v1zw.com    tajnenovak
    Odhlásit se z webové stránky

