#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými



*** Variables ***
@{sezn1}       Create List       Chrome       Edge     Wen     Thu     Fri     Sat     Sun

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***   

#Vypište všechny položky seznamu do logu
Prvni Test
    Log Many     @{sezn1}    
    #Vypište druhou položku seznamu na obrazovku (do konzole)
    Log To Console    ${sezn1}[1]    


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Druhy Test
    #použijte například  Should Contain
    @{sezn1}       Create List       Chrome       Edge     Wen     Thu     Fri     Sat     Sun
    Should Contain    ${sezn1}[0]     Chrome

Treti Test
    &{Dict}        Create Dictionary        login=karel        heslo=123456789
    Log Many        &{Dict}
    Log To Console    ${Dict}<<<<<<<<<<<<
    Log To Console    ${Dict.heslo}





