#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{prohlizece}   Chrome  Firefox  Safari  Brave

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    Log Many    @{prohlizece}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${prohlizece}[2]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Log Many    @{prohlizece}
    Should Contain    ${prohlizece}[0]    Chrome


