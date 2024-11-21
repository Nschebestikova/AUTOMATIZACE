*** Settings ***
Library  OperatingSystem

*** Variables ***
@{verze}    Microsoft Windows [Version 10.0.19045.2846]    DU_2.robot
@{adresar_0}    neexistuji_adresar    random_adresar    homework_adresar
&{adresar}    folder=Lekce_2    file=DU_2.robot


*** Test Cases ***

První test - Kontrola verze Windows
    ${mojepromenna}=     Run     ver
    Log To Console    ${mojepromenna}
    Should Contain    ${mojepromenna}    ${verze}[0]
    Log    Moje verze Windows je ${verze}[0]

Druhý test - Výpis adresáře s úkolem pomocí seznamu
    ${takymojepromenna}=    Run    dir
    Log To Console    ${takymojepromenna}
    Should Contain    ${takymojepromenna}    ${verze}[1]
    Log Many    @{verze}


#u tohoto testu se mi nedaří nalézt správnou cestu
Třetí test a - kontrola obsahu úkolu v adresáři pomocí slovníku
    ${prom}    Run    cd ..
    Log To Console    ${prom}    #RK přidal jsem tyto řádky
    ${prom}    Run    cd         #RK přidal jsem tyto řádky
    Log To Console    ${prom}    #RK přidal jsem tyto řádky
    ${prom}    Run    cd ${adresar.folder}
    Log To Console    ${prom}
    Should Contain    ${prom}    ${adresar.file}
    Log Many    &{adresar}
#file should exist

Třetí test b - negativní test na falešný adresář
    ${prom_0}    Run    cd ${adresar_0}[2]
    Log To Console    ${prom_0}
    Should Contain    ${prom_0}    Syst‚m nem…§e nal‚zt uvedenou cestu.
    Log Many   Výpis falešných adresářů je v seznamu @{adresar_0}


Čtvrtý test a - negativní test na skalár/string za použití Keywords
    ${scalar}=    Spocitej    10  10
    Should Not Be Equal    ${scalar}    "20"        
    Log    ${scalar} není string

Čtvrý test b - negativní test na skalár/string
    ${scalar0}=    Set Variable    12
    Log To Console    ${scalar0}
    Should Not Be Equal    ${scalar0}    "12"        
    Log    ${scalar0} není string


*** Keywords ***

Spocitej
    [Arguments]    ${a}  ${b}
    ${scalar}    Evaluate    ${a} + ${b}
    [return]    ${scalar}  
    
    
    