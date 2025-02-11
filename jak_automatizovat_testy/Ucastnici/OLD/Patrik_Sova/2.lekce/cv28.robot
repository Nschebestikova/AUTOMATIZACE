*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***
# pozor je nutné pro oddělení parametrů používat min 2 mezery
Sčítání
        ${result}=              Calculate  10  15  +
        Should Be Equal         ${result}  ${25}

Odečítání
        ${result}=              Calculate  20  19  -
        Should Be Equal         ${result}  ${1}

Násobení
        ${result}=              Calculate  2  15  *
        Should Be Equal         ${result}  ${30}

Dělení
        ${result}=                          Calculate  20  5  /
        Should Be Equal As Numbers          ${result}  ${4}

*** Keywords ***

Calculate
    [Arguments]    ${x}  ${y}  ${op}
    ${res}=        Evaluate    ${x} ${op} ${y}
    [return]       ${res}
