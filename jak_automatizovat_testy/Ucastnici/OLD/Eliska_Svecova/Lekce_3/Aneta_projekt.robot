*** Settings ***
Library  Browser

*** Keywords ***

Browser Settings
    New Browser        chromium    headless=false
    New Page           http://testovani.kitner.cz/login
    Get Title  ==  Testování

Login
    [Arguments]     ${email}      ${heslo}
    log             ${email}
    log             ${heslo}
    Type Text       data-test=email_input  ${email}
    Type Text       data-test=password_input  ${heslo}
    Click           data-test=login_button

Logout
    Click           data-test=logout_button
    Get Text        data-test=login_text  ==  Přihlášení

Ověření přihlášení
    Get Text        data-test=home_section  contains  Vítej uživateli 

Ověření Nepřihlášení
    Get Text        data-test=login_text  ==  Přihlášení

*** Test Cases ***

Prihlaseni success
    Browser Settings
    Get Text           data-test=login_text  ==  Přihlášení
    #data test bez uvozovek
    Login              andy.dvorakova@seznam.cz              1234abc+-
    Ověření přihlášení
    Logout

Negativní přihlášení
    Browser Settings
    Login              andy.dvorakova@seznam.cz              123456789
    Ověření Nepřihlášení
