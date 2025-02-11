# Moje testy na pomenne
*** Settings ***
Library     String

*** Variables ***
${greet}        Ahoj
#${name}         Daniel
@{list2}  =     prvni druhy treti

*** Test Cases ***
Prvni test s promennou
    #Log To Console    ${greet}
    #Log To Console    ${name}
    #Log To Console      Hi          #konstanta

    #${x} =  Set Variable    10
    #${y} =  Set Variable    20
    #${z} =  Evaluate        ${x} * ${y}
    #${greet} =  Set Variable    Hi

    #Log To Console    ${x}
    #Log To Console    ${y}
    #Should Be Equal As Numbers   ${y}  20

    ${v} =  Secti  10   20
    Log To Console   Výsledek: ${v}

    Vypis
    Pozdrav     Karle

Práce se seznamy
    @{list1} =  Create List    prvni  druhy  treti
    Log To Console      ${list1}[0]
    Log Many            @{list1}
    Pozdrav    Jano
#Práce se slovníkem
   # &{list2} =  Create Dictionary    prvni=10  druhy=20  jablko=80
   # Log To Console      ${list2}[jablko]
   # Log Many            &{list2}


*** Keywords ***
Vypis
    Log To Console    Masaryk

Pozdrav
    [Arguments]   ${name}
    Log To Console    Dobrý den, ${name}
    

Secti
     [Arguments]   ${x}  ${y}
     ${vysledek} =  Evaluate   ${x} + ${y}
     [Return]      ${vysledek}