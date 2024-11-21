*** Test Cases ***

Promenna test
    ${x} =   Set Variable  10
    ${y} =  Set Variable  5
    ${vysledek} =  Evaluate    ${x} * ${y}
    log to console  ${vysledek}
    Should Be Equal As Integers    ${vysledek}    50
