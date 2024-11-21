*** Settings ***
Library     OperatingSystem

*** Variables ***
${POZDRAV}     Dobrý den
${CISLO}       10
@{SEZNAM}      kolo  okno  strecha


*** Test Cases ***

Prace s promennymi
    # Log To Console    nazdarek
     ${POZDRAV}     Set Variable    Ahoj
     Log To Console    ${POZDRAV}
     
     ${CISLO}     Set Variable     10
     Should Be Equal As Integers    ${CISLO}     10

     @{LIST}     Create List    20  12  32  534
     Log Many     @{SEZNAM}
     Log To Console    ${LIST}[0]
     # Log To Console    ${LIST}[${CISLO}]

Prace se slovnikem
     &{DICT}     Create Dictionary    login=karel    heslo=nevim
     Log Many     &{DICT}
     Log To Console    ${DICT}
     Log To Console    >>>>>>${DICT.heslo}<<<<<<
     Log To Console    >>>>>${DICT}[login]
     Log                 ${DICT.heslo}

Testovani pozdravu
        Pozdrav2     Tomáši
        Pozdrav2     Milane

Vypocet
       ${vysledek}     Vypocet   22   22
       Log To Console    ${vysledek}


*** Keywords ***
Pozdrav
        Log To Console    Dobry den
        
Pozdrav2
        [Arguments]       ${jmeno} 
        Log To Console    Dobry den, ${jmeno}

Vypocet
    [Arguments]        ${x}     ${y}
     Log                   x=${x} y=${y}
     ${v}                 Evaluate    ${x} * ${y}   
     [Return]            ${v}     