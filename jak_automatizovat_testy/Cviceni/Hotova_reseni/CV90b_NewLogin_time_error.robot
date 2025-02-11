# BUG: k chybě dochází pokud jsou za sebou 2 testy, pozitivní přihlášení
#  a negativní přihlášení
#  je vidět, že psaní emailu se ani nezačne
#  možná příčina: zdá se, že pokud následuje rychlé psaní ukamžitě po odhlášení, tak dochází k chybě
#  stačí počkat po odhlášení i jen 3ms a k chybě nedojde
# http://testovani.kitner.cz/login
# příklady spuštění
#   robot --variable prohlizec:webkit .\CV90_NewLogin.robot
#   robot --variable prohlizec:chromium .\CV90_NewLogin.robot
#   robot --variable prohlizec:mozilla .\CV90_NewLogin.robot

# Test simulující mobil, rozlišení 360x740 (aktuálně tam není vidět odhlášení)
# Testy simulující tablet, rozlišení 820x1180
*** Settings ***
Documentation    Tento test file obsahuje 2 pozitivní a 2 negativní test casy na otestování
...              přihlašování do aplikace 'Testovací login' na webu testovani.kitner.cz

Suite Setup       Setup
#Test Setup       Setup
# Zkusit to udělat i bez vypnutýho Strict Mode.
Library          Browser

*** Variables ***
${TYPING_DELAY}  0 ms  # k chybě někdy dochází i když je timeout 5ms
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
    Login            ${USER1_EMAIL}             ${USER1_PASSWORD}           ano
    [Teardown]       TeardownPoz

Neúspěšné přihlášení chybné jméno
    [Documentation]  přihlášení s chybným jménem a správným heslem.
    [Tags]           negativní
    Login            novakova@neco.cz                     ${USER1_PASSWORD}           ne
    [Teardown]       TeardownNeg


*** Keywords ***

Login
    [Arguments]        ${jmeno}     ${heslo}     ${prihlasen}

    Type Text          data-test=email_input     ${jmeno}   delay=${TYPING_DELAY}  # Input 'Jméno'.
#    sleep              30ms   #nestačí 25ms je třeba přidat 30ms  (26ms někdy projde někdy ne)
#    Get Text           data-test=email_input     ==             ${jmeno}
    Take Screenshot

    Type Text          data-test=password_input  ${heslo}   delay=${TYPING_DELAY}  # Input 'Heslo'.
    Click              data-test=login_button                                      # Tlačítko s textem 'Login'.
    Take Screenshot
    sleep              10ms

    IF    '${prihlasen}' == 'ano'
       Get Url    ==               ${url1}/home                    # AssertPoz1
       Get Text   data-test=home_section        ==  Vítej uživateli ${USER1_NAME}!
       Get Text   data-test=logout_button       ==  Odhlásit        # AssertPoz2
    ELSE
       Get Url    !=               ${url1}/home          # AssertNeg2
       Get Text   data-test=email_input_errors  *=  These credentials do not match our records.   # AssertNeg1
    END


Setup
    Set Strict Mode    False
    New Browser        browser=${prohlizec}  headless=False
    New Page           ${url1}${url2}
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

TeardownPoz
    Click           data-test=logout_button
#    sleep           3ms    # WORKAROUND na BUG
#    Close Page

TeardownNeg
#    Close Page
    Log   konec testu