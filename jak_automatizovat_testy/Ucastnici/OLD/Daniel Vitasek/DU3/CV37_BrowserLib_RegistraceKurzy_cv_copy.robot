
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library     Browser
Resource    ../../OLD/David Karpiel/DÚ-03/projekt.robot

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

#Prihlaseni bad login1
#    Login1               dsadsad@sdas.cz                     dasdas
#    Uzivatel neni prihlasen
#Prihlaseni bad heslo1
#    Login1               radek.tester@seznam.cz              dasdas
#    Uzivatel neni prihlasen
#Prihlaseni success1
#    Login1               giyipem264@v1zw.com                 tajnenovak
#    Uzivatel je prihlasen

Prihlaseni bad login2
    Login2               dsadsad@sdas.cz                     dasdas
    Uzivatel neni prihlasen
Prihlaseni bad heslo2
    Login2               radek.tester@seznam.cz              dasdas
    Uzivatel neni prihlasen
Prihlaseni success2
    Login2               giyipem264@v1zw.com                 tajnenovak
    Uzivatel je prihlasen

*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login1
    [Arguments]     ${email}      ${heslo}

    log             ${email}
    log             ${heslo}


    #otevřít prohlížeč, můžete použít parametr headless=False aby jste viděli co se děje při způštění
    New Browser     chromium    headless=false

    #otevřít novou stránku http://testovani.kitner.cz/courses
    New Page        http://testovani.kitner.cz/courses

    #kliknout na tlačítko "Přihlásit se"
    Click           text="Přihlásit se"

    #ověřit, že se stránka otevřela (např, že obsahuje titulek "Testování")
    Get Title       ==          Testování - přihlášení

    #zadat email ${pemail} do místa pro zadání emailu
    Type Text       data-test=email_input       ${email}

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text       data-test=password_input    ${heslo}

    #klinout na tlačítko "Přihlasit"
    Click           text="Přihlásit"


Login2
    [Arguments]     ${email}      ${heslo}

    log             ${email}
    log             ${heslo}


    New Browser     chromium    headless=false

    New Page        http://testovani.kitner.cz/login

    Get Title       ==          Testování - přihlášení

    Type Text       data-test=email_input       ${email}

    Type Text       data-test=password_input    ${heslo}

    Click           text="Přihlásit"

Uzivatel je prihlasen
       Get Text   data-test=logout_button    ==    Odhlásit se       # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Get Url                               ==    ${URL}            # AssertPoz2
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==    Přihlásit se       # AssertNeg1
       Get Url                               !=    ${URL}             # AssertNeg2
       Take Screenshot

