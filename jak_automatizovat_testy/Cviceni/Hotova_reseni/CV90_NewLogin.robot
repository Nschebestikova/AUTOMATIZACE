# http://testovani.kitner.cz/login
# příklady spuštění
#   robot --variable prohlizec:webkit .\CV90_NewLogin.robot
#   robot --variable prohlizec:chromium .\CV90_NewLogin.robot
#   robot --variable prohlizec:firefox .\CV90_NewLogin.robot

# Test simulující mobil, rozlišení 360x740 (aktuálně tam není vidět odhlášení)
# Testy simulující tablet, rozlišení 820x1180
*** Settings ***
Documentation    Tento test file obsahuje 2 pozitivní a 2 negativní test casy na otestování
...              přihlašování do aplikace 'Testovací login' na webu testovani.kitner.cz

Suite Setup      Setup
#Test Setup       Setup

Library          Browser

*** Variables ***
${TYPING_DELAY}  5 ms
${prohlizec}     chromium                          #default prohlížeč
${rozliseni}     {'width': 1920, 'height': 1080}   #default rozlišení
${url1}          http://testovani.kitner.cz
${url2}          /login

#uživatel
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak
${USER1_SHORT}              MS


*** Test Cases ***
Úspěšné přihlášení novak
    [Documentation]  přihlášení uživatele novak, správné jméno i heslo
    [Tags]           pozitivní
    Login            ${USER1_EMAIL}             ${USER1_PASSWORD}
    Uzivatel je prihlasen
    [Teardown]       TeardownPoz

Neúspěšné přihlášení chybné jméno
    [Documentation]  přihlášení s chybným jménem a správným heslem.
    [Tags]           negativní
    Login            novakova@neco.cz                     ${USER1_PASSWORD}
    Uzivatel neni prihlasen
    Chybova hlaska neplatne udaje
    [Teardown]       TeardownNeg

Neúspěšné přihlášení dlouhé chybné jméno
    [Documentation]  přihlášení s chybným jménem a správným heslem.
    [Tags]           negativní
#    Login            strasne@dlooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooouhéjméno_s_diakritikou.cz                     ${USER1_PASSWORD}
    Login            strasne@dlooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooouhejmeno.cz                     ${USER1_PASSWORD}
    Uzivatel neni prihlasen
    Chybova hlaska neplatne udaje
    [Teardown]       TeardownNeg

Neúspěšné přihlášení chybné heslo
    [Documentation]  přihlášení se špatným heslom
    [Tags]           negativní
    Login            ${USER1_EMAIL}             tajnyadmin
    Uzivatel neni prihlasen
    Chybova hlaska neplatne udaje
    [Teardown]       TeardownNeg

Neúspěšné přihlášení prázdné jméno i heslo
    [Documentation]  přihlášení se špatným heslem
    [Tags]           negativní
    Login            ${EMPTY}                    ${EMPTY}
    Uzivatel neni prihlasen
    Chybova hlaska prazdny email
    Chybova hlaska prazdne heslo
    [Teardown]       TeardownNeg

*** Keywords ***

Login
    [Arguments]        ${jmeno}     ${heslo}

    Go To              ${url1}${url2}
    Type Text          data-test=email_input     ${jmeno}   delay=${TYPING_DELAY}  # Input 'Jméno'.
    Take Screenshot

    Type Text          data-test=password_input  ${heslo}   delay=${TYPING_DELAY}  # Input 'Heslo'.
    Click              data-test=login_button                                      # Tlačítko s textem 'Login'.
    Take Screenshot
    sleep              10ms


Uzivatel je prihlasen
       Get Text   data-test=logout_button       ==  Odhlásit se    # AssertPoz1
       # je nutné aby kontrola url byla až po objevení tlačítka "Odhlásit se", teprve potom je url správně
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   data-test=login_link       ==  Přihlásit se      # AssertNeg1
       Take Screenshot

Chybova hlaska neplatne udaje
       Get Text   data-test=email_input_errors  *=  These credentials do not match our records.   # AssertNeg1

Chybova hlaska prazdny email
       Get Text   data-test=email_input_errors  *=  The email field is required.

Chybova hlaska prazdne heslo
       Get Text   data-test=password_input_errors  *=  The password field is required.


Setup
#    Set Strict Mode    False
    New Browser        browser=${prohlizec}  headless=False
    New Page           ${url1}${url2}
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

TeardownPoz
    Click           data-test=logout_button
    #    Sleep           5ms                       # Workaround na bug, aplkace nestíhá okamžité přihlášení po odhlášení, email se nevyplní
    #    lepší variantou je počkat až se objevý tlačítko "Přihlásit se", tím máte jistou, že se užovatel odhlásil
    Uzivatel neni prihlasen

#    Close Page

TeardownNeg
#    Close Page
    Log   konec testu