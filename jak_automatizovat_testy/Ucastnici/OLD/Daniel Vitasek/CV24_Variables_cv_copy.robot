#
# Cvičení na použití proměných a výstupu do console
#
*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
@{sezn1}    Chrome  Edge  Firefox  Safari

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***

#Vypište všechny položky seznamu do logu

Prvni ukol
    Log Many        @{sezn1}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Druhy ukol
    Log To Console    ${sezn1}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Treti ukol
    Should Be Equal As Strings    ${sezn1}[0]    Chrome

    #použijte například  Should Contain








