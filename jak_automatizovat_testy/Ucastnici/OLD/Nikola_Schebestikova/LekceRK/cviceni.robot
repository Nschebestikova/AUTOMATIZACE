# požadavky
#   pip install robotframework-LekceRK
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
    #Uzivatel neni prihlasen
Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas
    #Uzivatel neni prihlasen
Prihlaseni success
    Login               giyipem264@v1zw.com                 tajnenovak
    #Uzivatel je prihlasen

*** Keywords ***
# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${email}      ${heslo}

    log             ${email}
    log             ${heslo}


 #otevřít prohlížeč, můžete použít parametr headless=False aby jste viděli co se děje při způštění
*** Test cases ****
Starting page
    New Browser    chromium    headless=false
    #otevřít novou stránku http://testovani.kitner.cz/courses
    New Page       ${URL}
    #ověřit, že se stránka otevřela (např, že obsahuje titulek "Testování")
    Get Title      *=   Test

    #kliknout na tlačítko "Přihlásit se"
    Click  text=Přihlásit se
    Sleep  4
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text    id=email_input  ${email}

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text    id=password_input  ${heslo}
    Sleep  2
    #klinout na tlačítko "Přihlasit"
    Click  data-test=login_button
    Take Screenshot


Uzivatel je prihlasen
       Get Text   data-test=logout_button    ==    Odhlásit se       # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Get Url                               ==    ${URL}            # AssertPoz2
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==    Přihlásit se       # AssertNeg1
       Get Url                               !=    ${URL}             # AssertNeg2
       Take Screenshot

