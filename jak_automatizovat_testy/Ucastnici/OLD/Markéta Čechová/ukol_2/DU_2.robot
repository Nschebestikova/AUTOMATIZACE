** Settings ***
Library         OperatingSystem

*** Variables ***
${ODPOVED}      Removes (deletes) a directory.
${USPECH}       ok
${PRIKAZ}       help rmdir

*** Test Cases ***
# Pozitivni testy


Test pozitiv 1

    ${res} =  run  ${PRIKAZ}

    Should Contain  ${res}  ${ODPOVED}
    Log    Při zadání ${PRIKAZ} se má vypsat hláška ${ODPOVED}

Test pozitiv 2

    ${res} =  run   cd .. && echo ${USPECH}
    Should Contain  ${res}  ${USPECH}

# Negativni testy

Test negativ 1
    ${hlaska}=  Set Variable    Syst‚m nem…§e nal‚zt uvedenou cestu.
    ${res} =  run   cd neexistujici_slozka
    Should Contain  ${res}  ${hlaska}
    Log    Hláška při přepnutí se do neexistující složky je ${hlaska}

Test negativ 2

    ${prikaz}=      Set Variable    bflmpsvz
    ${res} =  run  ${prikaz}

    Should Contain  ${res}  not recognized as an internal or external command
    Log    Byl spuštěn příkaz ${prikaz} a výsledek obsahuje text ${res}

Test keywords
    Negativ2    bflmpsvz

*** Keywords ***

Negativ2
    [Arguments]       ${prikaz}
    ${res} =  run  ${prikaz}
    Should Contain  ${res}  not recognized as an internal or external command
    Log    Byl spuštěn příkaz ${prikaz}


