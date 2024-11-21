*** Settings ***
Library  Browser
Resource       Project_Lia/config_Lia.robot
Resource       Project_Lia/Test_data_Lia.robot

Suite Setup      Setup

*** Variables ***
${ZPOZDENI_PSANI}   5 ms
${prohlizec}        chromium
${rozliseni}        {'width': 1920, 'height': 1080}
${url1}             https://www.allegro.cz
${url2}             /prihlaseni?origin_url=%2F

#uživatel
${USER1_JMENO}              Lia Moravcová Egemová
${USER1_MAIL}               kasslovalia@gmail.com
${USER1_HESLO}              Mb4jadj2$
${USER1_SHORT}              MS


*** Test Cases ***
Úspěšné přihlášení novak
    [Documentation]  přihlášení uživatele novak, správné jméno i heslo
    [Tags]           pozitivní
    Login            ${USER1_MAIL}             ${USER1_HESLO}
    Uzivatel je prihlasen
    [Teardown]       TeardownPoz

Neúspěšné přihlášení chybné jméno
    [Documentation]  přihlášení s chybným jménem a správným heslem.
    [Tags]           negativní
    Login            kasslovalia@gmail.cz                     ${USER1_HESLO}
    Uzivatel neni prihlasen
    Chybova hlaska neplatne udaje
    [Teardown]       TeardownNeg

Neúspěšné přihlášení dlouhé chybné jméno
    [Documentation]  přihlášení s chybným jménem a správným heslem.
    [Tags]           negativní
    Login            neplatné@chyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyýýýýýýýýýýýýýýýýýýýýýýýbné.com            ${USER1_HESLO}
    Uzivatel neni prihlasen
    Chybova hlaska neplatne udaje
    [Teardown]       TeardownNeg

Neúspěšné přihlášení chybné heslo
    [Documentation]  přihlášení se špatným heslom
    [Tags]           negativní
    Login            ${USER1_MAIL}             lovelove
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
    [Arguments]        ${jmeno}         ${heslo}

    Go To              ${url1}${url2}
    Type Text          css=[for="login"]     ${jmeno}   delay=${ZPOZDENI_PSANI}
    Take Screenshot

    Type Text          css=[name="password"]  ${heslo}   delay=${ZPOZDENI_PSANI}
    Click              css=[type="submit"]
    Take Screenshot
    sleep              10ms


Uzivatel je prihlasen
       Get Text   css=[data-role="auth-button"¨]     ==  Odhlásit se
       Take Screenshot


Uzivatel neni prihlasen
       Get Text   css=[data-role="header-username"]       ==  Přihlásit se
       Take Screenshot

Chybova hlaska neplatne udaje
       Get Text   css=[id="login-form-submit-error"]  *=  Přihlašovací jméno, e-mailová adresa nebo heslo jsou neplatné   # AssertNeg1

Chybova hlaska prazdny email
       Get Text   css=[id="login-form-submit-error"]  *=  Přihlašovací jméno, e-mailová adresa nebo heslo jsou neplatné

Chybova hlaska prazdne heslo
       Get Text   css=[id="login-form-submit-error"]  *=  Zadejte heslo


Setup
    Set Strict Mode    False
    New Browser        browser=${prohlizec}  headless=False
    New Page           ${url1}${url2}

TeardownPoz
    Click           css=[data-role="auth-button"¨]
    Sleep           5ms
    Uzivatel neni prihlasen
    Close Page

TeardownNeg
    Close Page
    Log   konec testu

