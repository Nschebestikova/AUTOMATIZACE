*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání
     ${result}=          Calculate  20  15  -      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${5}

Násobení
     ${result}=          Calculate  20  5  *      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${100}

Dělení
#    Should Be Equal As Numbers
     ${result}=          Calculate  20  5  /      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${4}

*** Keywords ***

Calculate
    [Arguments]    ${x}      ${y}    ${action}
    ${res}        Evaluate    ${x} ${action} ${y}    
    [return]       ${res}
