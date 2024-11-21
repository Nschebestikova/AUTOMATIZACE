*** Settings ***
Library         OperatingSystem

*** Test Cases ***
Kontrola verze Pythonu
    ${output}=    Run   python --version
    Should Contain    ${output}    Python

*** Test Cases ***
Muj prvni test
  log  Ahoj
  Log To Console    nazdar

Pozitivny test
    ${res} =  run  help cd
    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.

Negativny test
    ${res} =  run  help aaa
    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.
