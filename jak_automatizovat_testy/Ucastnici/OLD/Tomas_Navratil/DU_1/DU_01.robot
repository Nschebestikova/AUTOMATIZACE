DU1:
*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Pozitivni test 1
    ${res} =    Run   help mkdir

    Should Contain    ${res}    Creates a directory.    #kontrola zda se vytiskne zadanym prikazem dany text

Pozitivni test 2
    ${res} =    Run   help path

    Should Contain    ${res}    Displays or sets a search path for executable files.

Negativni test 1
    ${res} =    Run   help jkl

    Should Contain    ${res}    This command is not supported by the help utility.

Negativni test 2
    ${res} =    Run   !

    Should Contain    ${res}    '!' is not recognized as an internal or external command


