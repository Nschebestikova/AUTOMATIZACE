# http://testovani.kitner.cz/login
# příklady spuštění
#   robot --variable prohlizec:webkit .\CV92_NewRegistrace.robot
#   robot --variable prohlizec:chromium .\CV92_NewRegistrace.robot
#   robot --variable prohlizec:mozilla .\CV92_NewRegistrace.robot


*** Settings ***
Documentation    Tento test file obsahuje test casy na otestování registrace nového klienta

Suite Setup      Setup
Test Setup       Pred testem

# Zkusit to udělat i bez vypnutýho Strict Mode.
Library          Browser

*** Variables ***
${TYPING_DELAY}  5 ms
${prohlizec}     chromium                          #default prohlížeč
${rozliseni}     {'width': 1920, 'height': 1080}   #default rozlišení
${url1}          http://testovani.kitner.cz
${url2}          /login

#uživatel
${USER1_NAME}               Darth Vader
${USER1_EMAIL}              darth.vader@starwars.com
${USER1_PASSWORD}           temnasila
${USER1_SHORT}              DV

*** Test Cases ***
Úspěšná registrace fyzické osoby
    [Documentation]     přihlášení uživatele novak, správné jméno i heslo
    [Tags]              pozitivní
    Registration        ${USER1_NAME}  ${USER1_EMAIL}  ${USER1_PASSWORD}  ano

NEúspěšná registrace fyzické osoby
    [Documentation]     přihlášení uživatele novak, správné jméno i heslo
    [Tags]              negativní
    Registration        ${USER1_NAME}  chybnymail  ${USER1_PASSWORD}  ne



*** Keywords ***

Registration
    [Arguments]  ${jmeno}  ${email}  ${heslo}  ${zaregistrovan}

    Type Text   data-test=name_input            ${jmeno}   delay=${TYPING_DELAY}
    Type Text   data-test=email_input           ${email}   delay=${TYPING_DELAY}
    Type Text   data-test=password_input        ${heslo}   delay=${TYPING_DELAY}
    Type Text   data-test=password_again_input  ${heslo}   delay=${TYPING_DELAY}
    Take Screenshot
    Click       data-test=register_button

    Take Screenshot
    # vyhodnocení úspěšnosti registrace
    IF    '${zaregistrovan}' == 'ano'
       Get Url    ==               ${url1}/home                     # AssertPoz1
       Get Text   data-test=home_section        ==  Vítej uživateli ${USER1_NAME}!
       Get Text   data-test=logout_button       ==  Odhlásit se     # AssertPoz2
    ELSE
       Get Url    !=               ${url1}/home                     # AssertNeg1
       Get Text   data-test=register_text  *=  Registrace           # AssertNeg2
    END




Setup
#    Set Strict Mode    False
    New Browser        browser=${prohlizec}  headless=False
    New Page           ${url1}${url2}

    Click   data-test=register_link
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

TeardownPoz
    Click           data-test=logout_button
    Sleep           5ms                       # Workaround na bug, aplkace nestíhá okamžité přihlášení po odhlášení, email se nevyplní
#    Close Page

TeardownNeg
#    Close Page
    Log   konec testu
    
    
Pred Testem
    Go To    ${url1}${url2}
    Click   data-test=register_link