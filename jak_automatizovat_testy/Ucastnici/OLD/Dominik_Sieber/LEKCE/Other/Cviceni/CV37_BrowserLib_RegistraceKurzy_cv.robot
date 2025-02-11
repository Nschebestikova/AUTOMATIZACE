
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


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


    #otevřít novou stránku http://testovani.kitner.cz/courses


    #ověřit, že se stránka otevřela (např, že obsahuje titulek "Testování")


    #kliknout na tlačítko "Přihlásit se"


    #zadat email ${pemail} do místa pro zadání emailu


    #zadat heslo ${pheslo} do místa pro zadání hesla


    #klinout na tlačítko "Přihlasit"




Uzivatel je prihlasen
       Get Text   data-test=logout_button    ==    Odhlásit se       # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Get Url                               ==    ${URL}            # AssertPoz2
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==    Přihlásit se       # AssertNeg1
       Get Url                               !=    ${URL}             # AssertNeg2
       Take Screenshot

