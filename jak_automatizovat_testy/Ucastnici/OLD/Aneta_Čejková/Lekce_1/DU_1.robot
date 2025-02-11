*** Settings ***
Library  OperatingSystem


*** Test Cases ***

#Cvičení č.3: vytvořit 2 pozitivní automatické testy na příkazovou řádku
První test
    ${mojepromenna}=     Run     ver
    Log To Console    ${mojepromenna}
    Should Contain    ${mojepromenna}    Microsoft Windows [Version 10.0.19045.2728]

Druhý test
    ${takymojepromenna}=    Run    dir
    Log To Console    ${takymojepromenna}
    Should Contain    ${takymojepromenna}    Projects

#Cvičení č.4: vytvořit 2 negativní automatické testy na příkazovou řádku

Třetí test
    ${prom}=    Run    cd 'cd neexistuji_adresar' 
    Log To Console    ${prom}
    Should Contain    ${prom}    Syst‚m nem…§e nal‚zt uvedenou cestu.

# Čtvrtý test - špatný negativní test
#     ${enna}=    Run    date
#     Log To Console    ${enna}
#     Should Contain    ${enna}    The current date is: 10.04.2022

Čtvrtý test
    ${enna}=    Run    hostnejm
    Log To Console    ${enna}
    Should Contain    ${enna}    'hostnejm' is not recognized as an internal or external command