*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Muj Prvni Test
    Log To Console    ahoj

Druhy Test
    ${output} =      Run       help
    Log               ${output}
    Log To Console    ${output}
    Should Contain    ${output}       Creates a directory.
Treti Test

    ${output} =            Run        dir
    Log               ${output}
    Log To Console    ${output}
    Should Contain    ${output}       Creates a directory.
Ctvrty Test
    ${output} =          Run        help ř
    Log               ${output}
    Should Contain    ${output}     This command is not supported by the help utility.