*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Pozitivni test 1
    ${res} =    run  tasklist

    Should Contain   ${res}  chrome.exe

Pozitivni test 2
    ${res} =    run  systeminfo

    Should Contain  ${res}  Host Name:

Negativni test 1
    ${res} =    run  aaa

    Should Contain    ${res}  is not recognized as an internal or external command

Negativni test 2
    ${res} =    run  cd X

    Should Contain    ${res}  Syst‚m nem…§e nal‚zt uvedenou cestu.


*** Variables ***
${POZDRAV}  Ahoj
${CISLO}    10
${DES_CISLO}    3.14
#
#@{SEZNAM_PRAC_DNU}  pondělí  úterý  středa  čtvrtek  pátek
#&{SLOV}     jablka=10  hrusky=20  banan=1


*** Test Cases ***
Promene
    Log To Console    ${\n}Ahoj
    Log To Console    ${POZDRAV} ${CISLO} ${DES_CISLO}
#
#    ${jmeno} =        Set Variable  Honzo
#    Log To Console    ${POZDRAV}, ${jmeno}
#
#    ${jmeno} =        Evaluate  [1,2,3,4]

#Seznam.
#   Log To Console    @{SEZNAM_PRAC_DNU} nefunguje pro celý seznam
#    Log Many    @{SEZNAM_PRAC_DNU}
#    Log To Console    @{SEZNAM_PRAC_DNU}[1]
#    ${L} =          Create List  1  2  3  4

#Slovnik
#    Log Many       @{SEZNAM_PRAC_DNU}
#    Log To Console    <<<${SLOV}[jablka]
#    Log To Console    aaa${SLOV.jablka}
#    @{L} =       Create Dictionary  klic=10  klic2=ahoj

#Overeni
#    Should Contain    ${CISLO}    10
#    Should Be Equal    ${CISLO}   10

#Test1
#    Pozdrav  Ahoj  Dane
#    Pozdrav  Dobrý den  Honzo
#    ${jmeno} =   Set Variable  Dane
#    Log To Console    ${jmeno}

#Test2
#    ${vysledek} =    Secti    10    20
#    Log To Console    ${vysledek}
#    ${vysledek} =    Vynasob    10    20
#    Log To Console    ${vysledek}

*** Keywords ***
#Pozdrav
#    [Arguments]     ${typ pozdravu}  ${jmeno}
#    Log To Console  ${typ pozdravu}, ${jmeno}

#Secti
#    [Arguments]     ${a}  ${b}
#    ${v}            Evaluate    ${a}+${b}
#    [Return]        ${v}

#Vynasob
#    [Arguments]     ${a}  ${b}
#    ${v}            Evaluate    ${a}*${b}
#    [Return]        ${v}