#Cviceni 1

*** Variables ***
${greet}        Hello
${name} =       Anna

#Prvni test
*** Test Cases ***
Prvni test
    ${x} =  Set Variable    10
    ${y} =  Set Variable    20
    Log To Console    Hi
    Log To Console    ${greet}
    Log To Console    ${x}
    Pozdrav  Karle

#Cvicebni Test
#*** Test Cases ***
#Druhy test
#{y} =  Set Variable    20
#  Log To Console    ${y}
# Should Be Equal    ${y}     20
#${x} =  Set Variable    10
#${v} =  Evaluate  ${x} * ${y}


#Prace se seznamy
#   @{List1} =  Create List    prvni  druhy  treti
#  Log To Console    @{List1}
# Log To Console    ${List1}[0]
# Log Many    @{List1}

#Prace se slovnikem
#   &{List1} =  Create Dictionary        prvni=10  druhy=20  treti=30
#  Log To Console    ${List1}[druhy]
# Log Many    &{List1}


*** Keywords ***
Vypis
    Log To Console    Masaryk

Pozdrav
    [Arguments]      ${name}
    Log To Console    Dobry den, ${name}

Secti
    [Arguments]    ${x}  ${y}
    ${vysledek} =  Evaluate    ${x} * ${y}
    [Return]    ${vysledek}

