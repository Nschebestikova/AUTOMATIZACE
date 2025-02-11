#DU na procvičování proměnných, keywords a operací + vytvoření list and dictionary browser
*** Settings ***
Library   Browser

#zkouška browser - funkčnost prohlížece
*** Test Cases ***
#Zkouška prohlížece
Starting a browser with a page
    New Browser    chromium    headless=true
    New Page       https://account.heureka.cz
    Get Title      ==   Přihlášení

#hrátky s opakováním na login a password proměnnou
*** Variables ***
&{dict}      login=n.schebestikova@seznam.cz      password=Test1993
*** Test Cases ***
Open page - otevření stránky test
  [Setup]    Open browser  browser=chromium
   Go To     https://account.heureka.cz

Test na login a přihlášení do browser - na tvorbu dictionary

    &{dict}           Create Dictionary      login=n.schebestikova@seznam.cz      password=Test1993
    Log To Console    ${dict.login}                                 #zalogovani jen části slovníku - konkrétní hodnoty
    Should Contain    ${dict.login}     n.schebestikova@seznam.cz   #ověření obsahu
    Log To Console    ${dict.password}  Test1993
    Log Many          ${dict.login}                                 #zalogování celeho slovníku (Dictionary)



#Cvičeni 24 - dokonceni - seznam
*** Settings ***
Documentation    Cvičení: práce s promennými
Library     OperatingSystem

*** Variables ***
@{opsystems}      Microsoft_Windows  macOS  Linux  Android  iOS

*** Test Cases ***
Vypsání všech položek do logu
   Log many     ${opsystems}     #vypíše všechny položky seznamu (listu)

Vypsání dvou položek seznamu na pozici 0 a 1
   Log To Console    ${opsystems}[1]       #Vypsání položek seznamu do console z pozice 0 a 1

Test pro ověření, že na pozici 1 je obsažen macOS
   Should Contain    ${opsystems}[1]    macOS



#Testy na matematické operace - Cvičení 28
*** Test Cases ***
Sčítání
        ${result}=          Calculate  20  20  +     #zadání hodnot pro výpočet plus
        Should Be Equal     ${result}  ${40}         #Výsledek propočtu - Assertace

Odečítání
        ${result}=          Calculate  20  15  -     # zadání hodnot pro výpočet mínus
        Should Be Equal     ${result}  ${5}
Násobení
        ${result}=          Calculate  30  10  *      #zadání hodnot pro výpočet násobení
        Should Be Equal     ${result}  ${300}
Dělení
        ${result}=          Calculate  45  10  /      #zadání hodnot pro výpočet dělení
        Should Be Equal As Numbers    2   2

#Kličová slova, argumenty pro výpočet a operace z Pythonu - Evaluate
*** Keywords ***
Calculate
    [Arguments]    ${x}  ${y}  ${operator}
    ${result}      Evaluate    ${x} ${operator} ${y}
    RETURN       ${result}










#zkouška keywords a proměnné Pozdravu - bonusové moje cvičení
*** Variables ***
${jmeno}     Jana

*** Keywords ***
Pozdravuj1
    Log To Console    Zdravím vás

Pozdravuj2
    [Arguments]       ${jmeno}
    Log To Console    Zdravím vás ${jmeno}

*** Test Cases ***
Zkouška pozdravu
    Pozdravuj2    ${jmeno}