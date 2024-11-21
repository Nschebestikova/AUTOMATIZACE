#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
#Vytvořte seznam obsahující názvy prohlížečů
@{sezn1} =          Chrome       Edge     Firefox       Safari      Opera

*** Test Cases ***
Vypište všechny položky seznamu do logu
        Log Many          @{sezn1}

Vypište druhou položku seznamu na obrazovku (do konzole)
        Log To Console    ${sezn1}[1]

Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
        Should Contain    ${sezn1}[0]      Chrome









