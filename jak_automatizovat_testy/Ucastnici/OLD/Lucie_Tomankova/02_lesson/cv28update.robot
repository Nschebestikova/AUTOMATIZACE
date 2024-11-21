*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku



*** Test Cases ***
Sčítání
        ${resPlus} =       Calculate    20  +  15
        ${resStrPlus} =    Compare ValuesCorrect    35    ${resPlus}


Odečítání
        ${resMinus} =       Calculate    20  -  15
        ${resStrMinus} =    Compare ValuesCorrect    5    ${resMinus}


Násobení
        ${resMultiplication} =       Calculate    20  *  15
        ${resStrMultiplication} =    Compare ValuesCorrect    300    ${resMultiplication}


Dělení_positive
        ${resDivision} =    Calculate    20  /  15
        ${resStrDivision} =    Compare ValuesCorrect    1.333333333333333    ${resDivision}


Dělení_negative
        ${resDivision} =       Calculate    20  /  15
        ${resStrDivision} =    Compare ValuesCorrect    40    ${resDivision}



*** Keywords ***
Calculate
        [Arguments]     ${a}    ${o}    ${b}
        ${expressionNum} =   Catenate  ${a}    ${o}    ${b}
        ${resNum} =    Evaluate    ${expressionNum}
        Log    ${resNum}
        [Return]    ${resNum}


Compare ValuesCorrect
        [Arguments]    ${expected}    ${actual}
        ${resultValues} =    Run Keyword And Return Status    Should Be Equal As Numbers    ${expected}    ${actual}
        ${result_string} =    Run Keyword If    ${resultValues}    Set Variable    Výsledek matematické operace je ${actual}.    ELSE    Set Variable    Očekáváte výsledek ${expected}, ale správný výsledek je ${actual}. Tento test prověřil, že kalkulačka umí správně počítat.
        Log    ${result_string}
        [Return]    ${result_string}