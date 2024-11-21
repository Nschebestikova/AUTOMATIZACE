#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#Vytvoreni seznamu
@{list1}    chrome    mozila    safari


*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu

    Log to console  ${list1}[0]
    Log to console  ${list1}[1]
    Log to console  ${list1}[2]
    Log Many        ${list1}
#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log to console  ${list1}[2]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Log to console    ${list1}[0]
    Should Contain    ${list1}[0]    chrome



