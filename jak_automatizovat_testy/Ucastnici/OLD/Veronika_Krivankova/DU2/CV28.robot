*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}          Calculate    20  15  +
        Should Be Equal    ${result}    ${35}

Odečítání
        ${result}           Calculate    20    15    -
        Should Be Equal     ${result}    ${5}

Násobení
        ${result}           Calculate    20    15    *
        Should Be Equal     ${result}    ${300}

Dělení
        ${result}                     Calculate            20    15    /
        ${number}                     Convert To Number    ${1.333333333333333}
        Should Be Equal As Numbers    ${number}            ${result}


*** Keywords ***

Calculate
    [Arguments]    ${numberA}  ${numberB}  ${operators}
    ${res}         Evaluate     ${numberA} ${operators} ${numberB}
    [return]       ${res}
