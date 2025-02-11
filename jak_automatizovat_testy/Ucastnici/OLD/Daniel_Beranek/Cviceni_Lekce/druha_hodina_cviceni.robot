#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
# promenna - seznam prohlížečů - chrome, firefox, edge, opera
@{promenna} =   chrome  firefox edge opera

*** Keywords ***


*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    Log Many            @{promenna}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
     Log To Console     ${promenna}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Log To Console      ${promenna}[0]
    Should Contain      ${promenna}[0]        chrome



