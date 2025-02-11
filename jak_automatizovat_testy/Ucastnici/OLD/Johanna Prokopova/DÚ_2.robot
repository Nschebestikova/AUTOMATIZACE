#Cvičení č.1 - zde jsem vytvořila dvě lokální a dvě globální proměnné
*** Settings ***
Library  OperatingSystem

*** Variables ***
${PRIKAZ_1}       aaa
${PRIKAZ_2}      cd X

*** Test Cases ***
Pozitivni test 1
    ${prikaz} =      Set Variable  tasklist
    ${res} =         run           ${prikaz}

    Should Contain   ${res}  chrome.exe
    Log  ${prikaz}

Pozitivni test 2
    ${prikaz} =      Set Variable  systeminfo
    ${res} =         run           ${prikaz}

    Should Contain  ${res}  Host Name:
    Log  ${prikaz}

Negativni test 1
    ${prikaz} =      Set Variable  aaa
    ${res} =         run           ${PRIKAZ_1}

    Should Contain    ${res}  is not recognized as an internal or external command
    Log   ${PRIKAZ_1}

Negativni test 2
    ${prikaz} =      Set Variable  cd X
    ${res} =         run           ${PRIKAZ_2}

    Should Contain    ${res}  Syst‚m nem…§e nal‚zt uvedenou cestu.
    Log  ${PRIKAZ_2}


#Cvičení č.3 dokončení CV28
*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Secti  20  15
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Odecti  20  15
        Should Be Equal     ${result}  ${5}

Násobení
        ${result}=          Vynasob  20  15
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Vydel  20  15
        Should Be Equal     ${result}  ${1.3333333333333333}


*** Keywords ***

Secti
    [Arguments]    ${a}  ${b}
    ${res}=        Evaluate    ${a} + ${b}
    [return]       ${res}

Odecti
    [Arguments]    ${a}  ${b}
    ${res}=        Evaluate    ${a} - ${b}
    [return]       ${res}

Vynasob
    [Arguments]    ${a}  ${b}
    ${res}=        Evaluate    ${a} * ${b}
    [return]       ${res}

Vydel
    [Arguments]    ${a}  ${b}
    ${res}=        Evaluate    ${a} / ${b}
    [return]       ${res}