*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Muj prvni pozitivni test
    ${res} =  run  help

Muj druhy pozitivni test
    ${res} =  run  help dir
    Should contain   ${res}   Displays a list of files and subdirectories in a directory.

Muj prvni negativni test
    ${res} =  run  help XXX
    Should contain   ${res}   This command is not supported by the help utility.

Muj druhy negativni test
    ${res} =  run  help dirrr
    Should contain   ${res}   This command is not supported by the help utility.