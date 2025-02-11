#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{prohlizece}   Chrome  Mozilla  Edge  Safari  Opera

*** Test Cases ***
#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    Log To Console    ${prohlizece}[0] ${prohlizece}[1] ${prohlizece}[2] ${prohlizece}[3] ${prohlizece}[4]


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${prohlizece}[1]


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Should Contain    ${prohlizece}[0]    Chrome