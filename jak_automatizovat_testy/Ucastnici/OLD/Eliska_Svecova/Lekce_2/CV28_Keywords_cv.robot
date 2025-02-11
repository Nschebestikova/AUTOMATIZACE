*** Settings ***
Documentation     Cvičení na klíčová slova
...           #Připravte klíčové slovo pro kalkulačku



*** Test Cases ***

Sčítání
        ${result} =         Calculate   20  15   +
        Should Be Equal     ${result}   ${35}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}


Násobení
        ${result}=          Calculate  20  15  *
        Should Be Equal     ${result}  ${300}

Dělení
#    Should Be Equal As Numbers
        ${result}=                         Calculate  30  15  /
        Should Be Equal As Numbers         ${result}  2


*** Keywords ***

Calculate
    [Arguments]     ${a}    ${b}    ${o}
    ${res}=         Evaluate    ${a}${o}${b}
    [Return]        ${res}
