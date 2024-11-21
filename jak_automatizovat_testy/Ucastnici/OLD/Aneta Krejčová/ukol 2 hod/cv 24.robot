#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
@{list1} =      Chrome    Opera    Firefox

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    Log  ${list1}


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log  ${list1}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Should Contain  ${list1}[0]  Chrome







