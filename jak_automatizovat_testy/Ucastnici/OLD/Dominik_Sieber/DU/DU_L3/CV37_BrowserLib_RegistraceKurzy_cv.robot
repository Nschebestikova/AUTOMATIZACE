*** Settings ***
Library  Browser

*** Variables ***
# definování variabilních položek
${URL}                   http://testovani.kitner.cz/courses
${email1}                dsadsad@sdas.cz
${heslo1}                dasdas
${email2}                radek.tester@seznam.cz
${heslo2}                dasdas
${email3}                giyipem264@v1zw.com
${heslo3}                tajnenovak

*** Test Cases ***
Prihlaseni bad login
    Login              ${email1}      ${heslo1}
    Uzivatel neni prihlasen

Prihlaseni bad heslo
    Login              ${email2}      ${heslo2}
    Uzivatel neni prihlasen

Prihlaseni success
    Login              ${email3}      ${heslo3}
    Uzivatel je prihlasen
    Logout

*** Keywords ***
# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]            ${email}      ${heslo}
    log                    ${email}
    log                    ${heslo}
#   otevření prohlížeče (=true, i.e. neotevře se fyzické)
    New Browser            chromium    headless=false
#   otevřít na stránku viz variable
    New Page               ${URL}
#   mini asertace na prověření titulu
    Get Title              ==      Testování - Přehled kurzů
#   kliknutí na tl. "Přihlásit se"
    Click                  data-test=login_link
#    čekat 2 sec (pro případ, že změnime param headless=false!!)
    Sleep                  2
# vklad uživatelských dat (napsat = type text) a kliknutí na login
    Type Text              data-test=email_input               ${email}
    Type Text              data-test=password_input            ${heslo}
    Click                  data-test=login_button
#    čekat 2 sec (pro případ, že změnime param headless=false!!)
    Sleep                  2

Uzivatel je prihlasen
# ověří existenci tl. Odhlasit se
    Get Text               data-test=logout_button           ==    Odhlásit se       # AssertPoz1
# je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
# ověří existenci tl. Muj Profil (viditelný jen po přihlašení)
    Get Text               data-testid=courses_profile       ==    Můj Profil
# prověření URL
    Get Url                ==    ${URL}                                       # AssertPoz2
    Take Screenshot

Uzivatel neni prihlasen
    Get Text               data-test=login_link              ==    Přihlásit se       # AssertNeg1
    Get Element            data-test=email_input_errors
    Get Text               "These credentials do not match our records."
# prověření URL
    Get Url                !=    ${URL}             # AssertNeg2
    Take Screenshot

Logout
    Click                  data-test=logout_button
    Sleep                  2
    Get Text               data-test=login_link              ==  Přihlásit se
# prověření URL
    Get Url                ==    ${URL}             # AssertNeg2
    Take Screenshot