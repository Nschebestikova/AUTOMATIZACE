*** Settings ***
Library  Browser

*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

*** Keywords ***
 Login
   [Arguments]     ${USER1_EMAIL}        ${USER1_PASSWORD}
    Type text  data-test=email_input  ${USER1_EMAIL}
    Type text  id=password_input  ${USER1_PASSWORD}
    Sleep   5
    Take Screenshot
    Click   data-test=login_button  left
    Sleep   5
    Take Screenshot
 Odhlaseni
   [Arguments]
    Click  data-test=logout_button
    Take Screenshot
    Sleep   5

*** Test Case ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page        http://testovani.kitner.cz/login
    #titulek stránka kde hledáme
    Get Title      ==    Testování - přihlášení
    Login  ${USER1_EMAIL}  ${USER1_PASSWORD}
    Odhlaseni
    Close Browser    ALL
