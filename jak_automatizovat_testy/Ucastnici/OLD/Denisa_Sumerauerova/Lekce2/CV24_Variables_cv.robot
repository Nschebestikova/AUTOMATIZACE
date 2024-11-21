#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
@{seznam}=  Create List    Chrome  Edge  Explorer  Safari  Firefox  Mozzila

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    Log Many    @{seznam}


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${seznam}[2]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Log To Console    ${seznam}[0]
    Should Contain    ${seznam}[0]  Chrome






