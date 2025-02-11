
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
Prihlaseni a odhlaseni
    Login               giyipem264@v1zw.com                 tajnenovak
    Uzivatel je prihlasen


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${email}      ${heslo}

    log             ${email}
    log             ${heslo}
    New Browser    chromium    headless=false
    New Context    viewport={"width":1920, "height":1000}
    New Page       ${URL}
    Get Title      ==    Testování - Přehled kurzů

    Click          data-test=navigation_login_item
    Type Text      data-test=email_input  ${email}
    Type Text      data-test=password_input  ${heslo}
    Click          data-test=login_button
    Click          xpath=//*[@id="root"]/div/nav/div/div[1]/li[4]/a

Uzivatel je prihlasen
       Get Text   data-test=logout_button    ==    Odhlásit se       # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Get Url                               ==    ${URL}            # AssertPoz2
       Take Screenshot


#Uzivatel neni prihlasen
#       Get Text   data-test=login_link       ==    Přihlásit se       # AssertNeg1
#       Get Url                               !=    ${URL}             # AssertNeg2
#       Take Screenshot

