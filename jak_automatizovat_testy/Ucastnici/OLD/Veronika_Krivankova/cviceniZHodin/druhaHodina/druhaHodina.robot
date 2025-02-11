*** Settings ***
Library     OperatingSystem


*** Variables ***
${POZDRAV}      Dobrý den       #globální proměné
${CISLO}        10.55
@{SEZNAM}       ahoj  ahoj  ahoj

*** Test Cases ***

Práce s proměnnými
    ${x} =         Set Variable            10     #lokální proměnné
    Should Be Equal    ${x}                10

    @{LIST}           Create List            20  12  32  2323  444  4422
    Log Many          @{SEZNAM}
    Log To Console    ${LIST}[1]

    &{DICT}                Create Dictionary    login=karel  heslo=dsadfasf333 #tady nesmí být mezery
    Log Many               &{DICT} 
    Log To Console         ${DICT}
    Log To Console         >>>${DICT.heslo}<<<<<<<<<<<<<
    Log                    ${DICT.heslo}

Testování pozdravů
    #Pozdrav2    Tomáši
    #Pozdrav2    Milane
    ${vysledek}         Vypocet     22  22
    Log To Console      WWWWW: ${vysledek}

*** Keywords ***
Pozdrav 
    Log To Console    Dobrý den

Pozdrav2
    [Arguments]       ${jmeno}
    Log To Console    Dobrý den, ${jmeno}

Vypocet
    [Arguments]       ${x}  ${y}
    Log               x=${x} y=${y}
    ${v}              Evaluate    ${x} * ${y}
    [Return]          ${v}
