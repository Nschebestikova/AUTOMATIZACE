## Dominik Sieber Lekce 2
#
#*** Settings ***
#Library             OperatingSystem
#
#*** Variables ***
## RF nedělá rozdíl mezi číslem a textem, výpočty se dělají jinak.
#${nevim}            Ahoj
#${cislo}            1987
## U listu se dává "@"
#@{sezn1}            Mon       Tue     Wen     Thu     Fri     Sat     Sun
#
#*** Test Cases ***
#Pouzivame promenne
#    Log To Console      ${nevim}
## variable "druha" je lokální proměnná, která je aplikovatelná jenom v tomto TC
#    ${druha} =          Set Variable        Hello
#    ${cislo} =          Set Variable        2222
#    Log To Console      ${druha}
#    Log To Console      ${cislo}
#
## Seznamy, hodnoty jsou opět počítány od "0" jako Python
#    @{sezn1} =          Create List        Mon       Tue     Wen     Thu     Fri     Sat     Sun
#    # dotaz na seznam je s "$" a ve hranatých závorkách, kteroou hodnotu ze seznamu
#    Log To Console     ${sezn1}[1]     ${sezn1}[2]
#
## Slovníky
#    &{slov1} =          Create Dictionary       jmeno=user01    heslo=SD34aaa
#    Log Many            ${slov1}
#    Log To Console      ${slov1}[heslo]
#
# #    ${v} =              Evaluate        ${cislo} * 10
#
# # v3e je ve Cviceni23


# 22222222222222222222222222222222222222222222222222222222222222

*** Variables ***
# RF nedělá rozdíl mezi číslem a textem, výpočty se dělají jinak.
${nevim}            Ahoj
${cislo}            1987
# U listu se dává "@"
@{sezn1}            Mon       Tue     Wen     Thu     Fri     Sat     Sun

*** Test Cases ***
KlicSlova
    Log To Console      \#\#\#\#
    Pozdrav
    
    Pozdrav2            Dominiku

    ${vysledek} =       Secti      10      15
    Log To Console      ${vysledek}

*** Keywords ***
Pozdrav
    Log To Console    Dobry den

Pozdrav2
    [Arguments]       ${jmeno}
    Log To Console    Dobry den, ${jmeno}

Secti
    [Arguments]       ${x}        ${y}
    ${v} =            Evaluate    ${x} + ${y}
    [Return]          ${v}