*** Settings ***
Library    OperatingSystem
#Toto bude
#viacriadkovy
#komentar

"""
Je aj druha moznost
viacriadkoveho
komentara
"""

# Toto je jednoriadkovy komentar


*** Variables ***   # Zoznam premennych
${POZDRAV}    Ahoj
${CISLO}      10
${DES_CISLO}  3.14

@{ZOZNAM_PRAC.DNI}  pondelok   utorok  streda  štvrtok  piatok
&{SLOVNIK}          jablka=10  hrusky=20  banan=1

# $ - premenna skalar
# @ - zoznam
# & - slovnik


*** Test Cases ***
Premenne
    Log To Console    Ahoj
    Log To Console    text text ${POZDRAV} dalsi text
    ${meno} =         Set Variable  Timo  # lokalna premenna
    ${priezvisko} =   Set Variable  Pap   # lokalna premenna
    
    Log To Console    ${POZDRAV} ${meno}
    Log To Console    ${POZDRAV} ${priezvisko}
    Log To Console    ${CISLO} ${DES_CISLO}
#   ${meno2}          Evaluate    4 * 8

Skuska lok. premennej
    Log To Console    ${POZDRAV} ${meno}  # premenna ${meno} je lokalna a v predoslom teste

Zoznam
#    Log To Console    @{ZOZNAM_PRAC.DNI}
     Log To Console    >>>${ZOZNAM_PRAC.DNI}[1]  # vyberie hodnotu zo zoznamu
     Log Many          &{SLOVNIK}  # slovnik
     @{List}           Create List  1  2  3  4  # zoznam

Slovnik
     Log Many          @{ZOZNAM_PRAC.DNI}     # zoznam
     Log To Console    <<<${SLOVNIK}[jablka]  # slovnik
     Log To Console    ___${SLOVNIK.jablka}   # slovnik
     &{dict}=          Create Dictionary  kluc=10  kluc2=ahoj

Cvicenie
     ${x}              Set Variable  10
     Should Be Equal As Integers     ${x}    10

Test keywords
    Privitanie         Nazdar    Timo
    ${meno}            Set Variable     Timo
    Log To Console     ${meno}

Test spocitaj
    ${vysledok} =      Spocitaj    10    20
    Log To Console     ${vysledok}

Test vynasob
    ${vys_nas} =       Vynasob    5    5
    Log To Console     ${vys_nas}

Python verzia
    ${verzia}          Run          python --version
    Should Contain     ${verzia}    Python 3.11.4
    Log To Console     ${verzia}


*** Keywords ***
Privitanie
    [Arguments]       ${typ_p}    ${meno}
    Log To Console    ${typ_p},   ${meno}

Spocitaj
    [Arguments]       ${a}  ${b}
    ${v} =            Evaluate    ${a}+${b}
    [Return]          ${v}

Vynasob
    [Arguments]       ${a}  ${b}
    ${nasob} =        Evaluate    ${a}*${b}
    [Return]          ${nasob}