*** Settings ***
Library    OperatingSystem
*** Test Cases ***

Muj prvni test
    Log To Console  Ahoj

Druhy test (p)
    ${res} =          Run       help dir
    Log               ${res}
    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.

Treti test (n)
    ${res} =          Run       help ahoj
    Log               ${res}
    Should Contain    ${res}    This command is not supported by the help utility.

Ctvrty test (p)
    ${res} =          Run       echo test
    Log               ${res}
    Should Contain    ${res}    test

Paty test (n)
    ${res} =          Run       dir B:
    Log               ${res}
    Should Contain    ${res}    Syst‚m nem…§e nal‚zt uvedenou cestu.

Sesty test (p)
    ${res} =          Run       dir K:
    Log               ${res}
    Should Contain    ${res}    Volume Serial Number

