*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Muj treti test
    ${res} =  run  help cd

    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.


