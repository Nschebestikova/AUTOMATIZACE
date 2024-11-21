*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +
        Should Be Equal     ${result}  ${35}
        Log    Výsledek sčítání je ${result}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}
        Log    Výsledek odečítání je ${result}
Násobení
        ${result}=          Calculate  5  5  *
        Should Be Equal     ${result}  ${25}
        Log    Výsledek násobení je ${result}

Dělení
    ${result}=          Calculate  30  5  /
    Should Be Equal     ${result}  ${6}
    Log    Výsledek dělení je ${result}

*** Keywords ***

Calculate
    [Arguments]    ${a}     ${b}        ${operace}
    ${res}=        Evaluate    ${a} ${operace} ${b}
    [return]       ${res}

