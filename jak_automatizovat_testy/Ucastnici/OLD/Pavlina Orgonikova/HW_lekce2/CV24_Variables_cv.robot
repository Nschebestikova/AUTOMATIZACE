# Cvičení na použití proměných a výstupu do console

*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
@{browsers}          Chrome  Edge  Opera  Safari  Mozilla     #seznam obsahující názvy prohlížečů
${OS}                MacOs
${ifconfig_cmd}      ifconfig

*** Test Cases ***

Vypis promennych
#Vypíše všechny položky seznamu do logu
    Log Many     @{browsers}

#Vypíše druhou položku seznamu na obrazovku (do konzole)
    Log To Console    ${\n} druha položka seznamu je: ${browsers}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
     Should Contain    ${browsers}[0]     Chrome


# další test
