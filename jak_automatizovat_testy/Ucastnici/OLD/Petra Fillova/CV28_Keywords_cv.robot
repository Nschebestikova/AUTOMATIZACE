*** Settings ***
Library  Math

*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +    # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}
Násobení
        ${result}=          Calculate  20  15  *
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Calculate  20  15  /
        Should Be Equal     ${result}  ${1.3333333333333333}


*** Keywords ***


Calculate
    [Arguments]    ${x}  ${y}  ${operator}
    ${res}=        Evaluate    ${x} ${operator} ${y}
    [return]       ${res}