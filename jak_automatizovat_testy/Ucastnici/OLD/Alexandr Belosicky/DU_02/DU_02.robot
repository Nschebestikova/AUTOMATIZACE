*** Settings ***
Library  OperatingSystem
Library  Browser

*** Variables ***
${POZ_PRIKAZ_01}        help /?
${POZ_ODPOVED_01}       Provides help information for Windows commands.
${POZ_PRIKAZ_02}        ping /?
${POZ_ODPOVED_02}       Usage: ping [-t]

${NEG_PRIKAZ_01}        help ?
${NEG_ODPOVED_01}       This command is not supported by the help utility.
${NEG_PRIKAZ_02}        ping ?
${NEG_ODPOVED_02}       Ping request could not find host ?



*** Test Cases ***
Pozitivni test 1
    ${res} =    Run   ${POZ_PRIKAZ_01}
    Should Contain    ${res}    ${POZ_ODPOVED_01}
    Log         Pozitivni prikaz 1 je: ${POZ_PRIKAZ_01}
    Log         Odpoved by mela obsahovat: ${POZ_ODPOVED_01}
    Log         Realna odpoved prikazu je: ${res}

Pozitivni test 2
    ${res} =    Run   ${POZ_PRIKAZ_02}
    Should Contain    ${res}    ${POZ_ODPOVED_02}
    Log         Pozitivni prikaz 2 je: ${POZ_PRIKAZ_02}
    Log         Odpoved by mela obsahovat: ${POZ_ODPOVED_02}
    Log         Realna odpoved prikazu je: ${res}

Negativni test 1
    ${res} =    Run   ${NEG_PRIKAZ_01}
    Should Contain    ${res}    ${NEG_ODPOVED_01}
    Log         Negativni prikaz 1 je: ${NEG_PRIKAZ_01}
    Log         Odpoved by mela obsahovat: ${NEG_ODPOVED_01}
    Log         Realna odpoved prikazu je: ${res}

Negativni test 2
    ${res} =    Run   ${NEG_PRIKAZ_02}
    Should Contain    ${res}    ${NEG_ODPOVED_02}
    Log         Negativni prikaz 2 je: ${NEG_PRIKAZ_02}
    Log         Odpoved by mela obsahovat: ${NEG_ODPOVED_02}
    Log         Realna odpoved prikazu je: ${res}


#Cviceni 3 -> Dokoncit CV28 - klíčové slovo pro kalkulačku
Sčítání
    ${result}=          Calculate  20  +  15
    Should Be Equal     ${result}  ${35}

Násobení
   ${result}=           Calculate  20  *  5
   Should Be Equal      ${result}  ${100}

Odečítání
    ${result}=          Calculate  20  -  15
    Should Be Equal     ${result}  ${5}

Dělení
    ${result}=          Calculate  20  /  5
    Should Be Equal     ${result}  ${4}


Cviceni 4 - Zkouska NODE.JS a BrowserLibrary -> Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
   Get Title      ==    Browser
#výsledek - PASS


*** Keywords ***
Calculate
    [Arguments]       ${a}  ${b}  ${c}
    ${v} =            Evaluate    ${a}${b}${c}
    [Return]          ${v}
