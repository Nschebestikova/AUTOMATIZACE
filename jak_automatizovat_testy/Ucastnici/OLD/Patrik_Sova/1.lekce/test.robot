*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Muj Prvni Test
    Log To Console    ahoj

Druhy Test
    ${promena} =      Run       help
    Log               ${y}
    Log To Console    ${y}
    Should Contain    ${y}       Creates a directory.
Treti Test

    ${x} =            Run        dir
    Log               ${x}
    Log To Console    ${x}
    Should Contain    ${x}       Creates a directory.
Ctvrty Test
    ${ppp} =          Run        help gag
    Log               ${ppp}
    Should Contain    ${ppp}     This command is not supported by the help utility.