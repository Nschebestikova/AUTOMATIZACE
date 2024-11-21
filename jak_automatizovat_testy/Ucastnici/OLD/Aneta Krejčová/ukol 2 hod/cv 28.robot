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
        ${result}=          Calculate  2  15  *      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${30}

Dělení
        ${result}=          Calculate  20  2  /      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${10.0}


*** Keywords ***

Calculate
    [Arguments]    ${numberA}  ${numberB}  ${znamenko}
    ${res}=        Evaluate    ${numberA} ${znamenko} ${numberB}
    [return]       ${res}
