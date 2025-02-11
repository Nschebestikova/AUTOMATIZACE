*** Settings ***
Library         OperatingSystem

*** Test Cases ***
1 poztivni tests
    ${res}=    Run   python --version
    Should Contain    ${res}    Python

2 poztivni tests
    ${res}=    Run    dir c:\prvni.robot
    Should Contain    ${res}    prvni.robot

1 negativni test
    ${res}=    Run   ls123
    Should Contain    ${res}    is not recognized

2 negativni test
    ${res}=    Run   dir c:\neznamy_adresar
    Should Not Contain    ${res}    neznamy_adresar