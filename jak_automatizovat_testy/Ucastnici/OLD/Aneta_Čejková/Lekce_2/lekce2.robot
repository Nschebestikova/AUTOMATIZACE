#vysvětlení negativního testu
#Trénink proměnných

*** Variables ***
${greet}    Ahoj
${name}=    Aneta

*** Test Cases ***
První test s proměnnou
    ${x}=    Set Variable     10
    Log To Console    Hi
    Log To Console    ${greet}
    Log To Console    ${name}
    Log To Console    ${x}
    Pozdrav    Karle

#když zadávám proměnou, tak je potřeba zadat "Set Variable"
#když tu proměnou chci zadat jen pro daný test, tak zadávám přes Set Variable
#když tu proměnou chci globálně pro všechny, tak to zadám do ***Variables***

Cvičný test1
    ${y}=    Set Variable    20
    #Should Be Equal    ${y}    20
    ${x}=    Set Variable    10
    ${vysledek} =  Evaluate  ${x} + ${y}
    Log To Console    ${vysledek}
    
# Cvičný test2
#     ${x}=    Set Variable    10
#     ${y}=    Set Variable    5
#     ${v} =  Evaluate  ${x} * ${y}
#     Should Be Equal As Numbers    ${v}    50
#evaluate dělá vyčíslování a všechny operace z pythonu


#Práce se seznamy

# Prace se seznamy
#     @{list}=    Create List    prvni    druhy    treti
#     Log To Console    @{list}
#     Log To Console    ${list}[0]
#     Log Many    @{list}
# #Log Many vypíše celý seznam, který definuju přes @
# #přes $ definuju konkrétní položku ze seznamu

# Prace se slovniky
#     &{list1} =  Create Dictionary  jablko=10  banan=20  chleba=80
#     Log To Console  ${list1}[banan]
#     Log Many        &{list1}

#seznamy jsou závislé na pořadí, slovníky ne, to je hlavní rozdíl

#Klíčová slova
*** Keywords ***
Výpis
    Log To Console    masaryk
Pozdrav
    [Arguments]    ${name}
    Log To Console    Dobrý den, ${name}
#arguments dovolí přepsat jméno?

Sečti
    [Arguments]    ${x}=5    ${y}=7    #nepovinný argument
    ${vysledek} =  Evaluate  ${x} + ${y}
    [Return]    ${vysledek}  