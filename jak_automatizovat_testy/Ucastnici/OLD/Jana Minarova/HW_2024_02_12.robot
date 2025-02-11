*** Settings ***
Library     OperatingSystem

*** Test Cases ***

# vytvořit 2 pozitivní automatické testy na příkazovou řádku
Prvni test pozitivní
    ${res} =        run     where python
    log             ${res}
    Should Contain  ${res}  Python311


Druhy test pozitivní
    ${res} =        run     echo ahoj ahoj
    log             ${res}
    Should Contain Any  ${res}  ahoj 

# vytvořit 2 negativní automatické testy na příkazovou řádku
Treti test negativni
    ${res} =        run     help
    log             ${res}
    Should Not Contain Any  ${res}  zdarec

Ctvrty test negativni 
    ${res} =        run     python --version 
    log             ${res}
    Should Not Start With  ${res}  robot




