*** Settings ***
Library           OperatingSystem


*** Test Cases ***

Sčítání
    ${res_plus}     Calculate_Plus      20    15    # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal As Integers     ${res_plus}   35

Odečítání
    ${res_minus}          Calculate_Minus     20    15    # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal As Numbers     ${res_minus}   5

Násobení
    ${res_multi}          Calculate_Multi     20    15    # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal As Numbers     ${res_multi}   5

Dělení
    ${res_div}          Calculate_Div     20    15    # pozor je nutné pro oddělení parametrů používat min 2 mezery
    Should Be Equal As Numbers     ${res_div}   5

*** Keywords ***

Calculate_Plus
    [Arguments]     ${a}  ${b}
    Log             a=${a} x=${b}
    ${res_plus}     Evaluate    ${a} + ${b}
    RETURN        ${res_plus}

Calculate_Minus
    [Arguments]     ${c}  ${d}
    Log             c=${c} x=${d}
    ${res_minus}       Evaluate    ${c} - ${d}
    RETURN        ${res_minus}

Calculate_Multi
    [Arguments]     ${c}  ${d}
    Log             c=${c} x=${d}
    ${res_multi}       Evaluate    ${c} * ${d}
    RETURN        ${res_multi}

Calculate_Div
    [Arguments]     ${c}  ${d}
    Log             c=${c} x=${d}
    ${res_div}       Evaluate    ${c} / ${d}
    RETURN        ${res_div}
