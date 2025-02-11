*** Test Cases ***
Plus
    ${vysl} =          Scitanie    30    25
    Should Be Equal    ${vysl}     ${55}

Minus
    ${vysl} =          Odpocitanie  75    25
    Should Be Equal    ${vysl}      ${50}

Krat
    ${vysl} =          Krat         312    52
    Should Be Equal    ${vysl}      ${16224}
    
Deleno
    ${vysl} =          Deleno       24    6
    Should Be Equal    ${vysl}      ${4}


*** Keywords ***
Scitanie
    [Arguments]     ${a}    ${b}
    ${scit}         Evaluate    ${a} + ${b}
    [Return]        ${scit}

Odpocitanie
    [Arguments]     ${a}    ${b}
    ${odp}         Evaluate    ${a} - ${b}
    [Return]        ${odp}

Krat
    [Arguments]     ${a}    ${b}
    ${krat}         Evaluate    ${a} * ${b}
    [Return]        ${krat}

Deleno
    [Arguments]     ${a}    ${b}
    ${del}         Evaluate    ${a} / ${b}
    [Return]        ${del}