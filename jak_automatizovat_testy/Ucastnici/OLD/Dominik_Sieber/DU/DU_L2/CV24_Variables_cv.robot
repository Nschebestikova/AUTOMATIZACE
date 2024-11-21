#
# Cvičení na použití proměných a výstupu do console
#
*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{Browsers} =   Chrome      Edge      Mozilla      Opera      FireFox

*** Test Cases ***
Test pro vypsani všech položek seznamu do logu
    # Vypište všechny položky seznamu do logu & sem je třeba doplnit příkazy
    Log To Console          ${Browsers}[0]
    Log To Console          ${Browsers}[1]
    Log To Console          ${Browsers}[2]
    Log To Console          ${Browsers}[3]
    Log To Console          ${Browsers}[4]
    Should Contain          ${Browsers}[0]       Chrome
#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console          ${Browsers}[1]
    Should Contain          ${Browsers}[1]      Edge
#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome

Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Log To Console          ${Browsers}[0]
    Should Contain          ${Browsers}[0]      Chrome






