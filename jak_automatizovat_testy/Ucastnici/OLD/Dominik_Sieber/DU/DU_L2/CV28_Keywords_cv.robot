*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku

*** Test Cases ***
Sčítání
    ${result} =          Calculate   20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal      ${result}   ${35}

Odečítání
    ${result} =          Calculate   20  15  -      # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal      ${result}   ${5}

Násobení
    ${result} =          Calculate   20  5  *      # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal      ${result}   ${100}

Dělení
    ${result} =          Calculate   20  5  /      # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal      ${result}   ${4}
#    Should Be Equal As Numbers

*** Keywords ***
Calculate
    [Arguments]                 ${x}  ${y}  ${operator}
    ${res}=       Evaluate      ${x}${operator}${y}
    [return]      ${res}

#
#Sčítání
#    [Arguments]                 ${x}   ${y}
#    ${res} =      Evaluate      ${x} + ${y}
#    [return]       ${res}
#
#Odečítání
#    [Arguments]                 ${x}   ${y}
#    ${res} =      Evaluate      ${x} - ${y}
#    [return]       ${res}
#
#Násobení
#    [Arguments]                 ${x}   ${y}
#    ${res} =      Evaluate      ${x} * ${y}
#    [return]       ${res}
#
#Dělení
#    [Arguments]                 ${x}   ${y}
#    ${res} =      Evaluate      ${x} / ${y}
#    [return]       ${res}
