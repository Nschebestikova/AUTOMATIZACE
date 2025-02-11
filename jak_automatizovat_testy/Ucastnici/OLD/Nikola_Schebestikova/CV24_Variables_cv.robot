#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými
Library           OperatingSystem
Library           String


*** Variables ***
@{LIST}          Chrome      Edge    Firefox    Safari    Android    Samsung    ATD

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***
#Vypište všechny položky seznamu do logu
vypis seznamu do logu
     @{LIST}      Create List        Chrome      Edge    Firefox    Safari    Android    Samsung    ATD
    # sem je třeba doplnit příkazy
      Log Many          @{LIST}
      Log To Console    ${LIST}
#Vypište druhou položku seznamu na obrazovku (do konzole)
      @{LIST}           Create List        Chrome      Edge    Firefox    Safari    Android    Samsung    ATD

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
     Log To Console    ${LIST}[0]
    #použijte například  Should Contain
    Should Be Equal As Strings    ${LIST}[0]    Chrome








