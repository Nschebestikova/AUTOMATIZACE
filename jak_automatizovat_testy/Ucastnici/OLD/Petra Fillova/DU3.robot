
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}      http://testovani.kitner.cz/courses
${email}    giyipem264@v1zw.com
${heslo}    tajnenovak

*** Test Cases ***

Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas
    Uzivatel neni prihlasen
Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas
    Uzivatel neni prihlasen
Prihlaseni success
    Login               giyipem264@v1zw.com                 tajnenovak
    Uzivatel je prihlasen


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${email}      ${heslo}
    log             ${email}
    log             ${heslo}


    #otevřít prohlížeč, můžete použít parametr headless=False aby jste viděli co se děje při způštění
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    Sleep    3


    #otevřít novou stránku http://testovani.kitner.cz/courses
    New Page       http://testovani.kitner.cz/courses
    Sleep    3

    #ověřit, že se stránka otevřela (např, že obsahuje titulek "Testování")
    Get Title      ==    Testování - Přehled kurzů
    Sleep    3
    #kliknout na tlačítko "Přihlásit se"
    Click          text="Přihlásit se"
    Sleep    3
    #zadat email ${pemail} do místa pro zadání emailu

    Type Text   data-test=email_input    ${email}
    Sleep    3
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text       data-test=password_input    ${heslo}
    Sleep    3

    #klinout na tlačítko "Přihlasit"
    Click    data-test=login_button
    Sleep    3


Uzivatel je prihlasen
       Get Text   data-test=logout_button    ==    Odhlásit se       # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Get Url                               ==    ${URL}            # AssertPoz2
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==    Přihlásit se       # AssertNeg1
       Get Url                               !=    ${URL}             # AssertNeg2
       Take Screenshot

