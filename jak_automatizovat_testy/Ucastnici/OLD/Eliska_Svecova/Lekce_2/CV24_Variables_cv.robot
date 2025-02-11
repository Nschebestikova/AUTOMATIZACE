#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***

#vytvořte seznam obsahující názvy prohlížečů
@{prohlizece}   Edge       Chrome       Opera           #seznam prohlížečů

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    Log Many           @{prohlizece}                    #vypisu vsechny prohlížeče

Test pro vypsani jedne polozky ze seznamu
    #Vypište druhou položku seznamu na obrazovku (do konzole)
    Log To Console     ${prohlizece}[1]

Test pro ověření že 1 položka seznamu obsahuje Chrome
    #Vytvořte ověření že položka na pozici 1 v seznamu obsahuje Chrome
    Should Be Equal     ${prohlizece}[1]     Chrome








