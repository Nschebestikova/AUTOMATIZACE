*** Settings ***
Library  Browser

*** Keywords ***
Login
    [Arguments]     ${email}      ${heslo}
    Type Text       data-test=email_input        ${email}
    Type Text       data-test=password_input     ${heslo}
    Click           data-test=login_button
    Get Text        data-test=logout_button == Odhlásit se

*** Test Cases ***
Přihlášení a odhlášení
   New Browser    chromium    headless=false
   New Page       http://testovani.kitner.cz/login
   Get title      contains    Testování
   #   přihlášení
   Login            giyipem264@v1zw.com                 tajnenovak
   Get Text         data-test=logout_button    ==    Odhlásit se
   #  odhlášení
   Click            data-testid=logout_button


# DATA:
#     ${USER1_NAME}         Michal Novák
#     ${USER1_EMAIL}         giyipem264@v1zw.com
#     ${USER1_password}        tajnenovak
