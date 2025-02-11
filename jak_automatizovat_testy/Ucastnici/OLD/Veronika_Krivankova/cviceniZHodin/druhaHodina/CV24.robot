#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
@{sezn1}          Chrome  Edge  Firefox

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***
Pokus
#vypište všechny položky seznamu do logu
    Log Many    @{sezn1}

    # sem je třeba doplnit příkazy


#Vypište druhou položku seznamu na obrazovku (do konzole)
    Log to Console      ${sezn1}[1]


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome (použijte například  Should Contain)
    Should Contain     ${sezn1}[0]     Chrome







