# promenne

*** Variables ***
${POZDRAV}      Ahoj
${CISLO}        10
${DES_CISLO}    3.14

@{SEZNAM_PRAC_DNU}  pondělí  úterý  středa  čtvrtek  pátek
${SLOV}             jabla=10  hrusky=20  banan=1

*** Keywords ***
Pozdrav
    [Arguments]     ${typ_p}  ${jmeno}
    Log To Console  ${typ_p}  ${jmeno}

Secti
    [Arguments]     ${a}  ${b}
    ${v}            Evaluate  ${a}+${b}
    [Return]        ${v}

Vynasob
    [Arguments]     ${a}  ${b}
    ${v}            Evaluate  ${a}*${b}
    [Return]        ${v}
*** Test Cases ***
#Promenne
#    Log To Console  ${\n}Ahoj
#    Log To Console  ${POZDRAV} ${CISLO} ${DES_CISLO}
#    ${jmeno} =      Set Variable Dane
#    Log To Console  ${POZDRAV}, ${jmeno}
##    ${jmeno2} =     Evalue 4 * 8
Test1
    Pozdrav  Ahoj  Dane
#    ${jmeno} =      Set Variable  Dane
#    Log To Console  ${jmeno}
Test2
    ${vysledek} =   Secti   10  20
    Log To Console  ${vysledek}
Test3
    ${vysledek2} =   Vynasob   10  20
    Log To Console  ${vysledek2}
Nevím co
    Log To Console ${POZDRAV}, ${jmeno}

Seznam
    Log To Console  ${SEZNAM_PRAC_DNU}[1]
    Log Man         @{SEZNAM_PRAC_DNU}
    @{L} =          Create List 1  2  3  4