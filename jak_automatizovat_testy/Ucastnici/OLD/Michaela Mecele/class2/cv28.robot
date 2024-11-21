*** Settings ***

Documentation     Cvičení na klíčová slova

*** Test Cases ***

Sčítání
    ${result} =     Calculate  20  15  +
    Should Be Equal As Numbers  ${result}  ${35}

Odečítání
    ${result} =     Calculate  20  15  -
    Should Be Equal As Numbers  ${result}  ${5}

Násobení
    ${result}=      Calculate  20  15  *
    Should Be Equal As Numbers     ${result}  ${300}

Dělení
    ${result}=      Calculate  20  5  /
    Should Be Equal As Numbers     ${result}  ${4}

*** Keywords ***

Calculate
    [Arguments]    ${x}   ${y}   ${op}
    ${result}=     Evaluate    ${x} ${op} ${y}
    [return]       ${result}
