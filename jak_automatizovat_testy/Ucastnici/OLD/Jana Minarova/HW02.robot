*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test 
    ${cislo}        Set Variable     10
    log             ${cislo}
    Should Be Equal As Numbers  ${cislo}     10


Druhy test negativni
    @{LIST}           Create List            20  12  32  2323  444  4422
    Log Many          @{LIST}
    Log To Console    ${LIST}[1]

