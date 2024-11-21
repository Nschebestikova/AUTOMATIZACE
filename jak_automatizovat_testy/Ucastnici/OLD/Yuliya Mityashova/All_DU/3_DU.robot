*** Settings ***
Library  Browser

*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak
${URL}                      http://testovani.kitner.cz/login

*** Test Cases ***
Starting a browser with a page and login
    New Browser    chromium   headless=false
    New Page        ${URL}
    Get Title       contains    Testování
    Login          ${USER1_EMAIL}    ${USER1_PASSWORD}
    Logout

*** Keywords ***
Login
     [Arguments]    ${USER1_EMAIL}    ${USER1_PASSWORD}
     Type Text      data-test=email_input    ${USER1_EMAIL}
     Type Text      data-test=password_input    ${USER1_PASSWORD}
     Click          data-test=login_button
     Get Text       text=Můj Profil
     Take Screenshot
Logout
    [Arguments]
    Click          data-test=logout_button
    Get Text       text=Kurzy
    Take Screenshot


