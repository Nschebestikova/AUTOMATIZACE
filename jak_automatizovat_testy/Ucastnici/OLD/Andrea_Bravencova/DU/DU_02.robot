*** Settings ***
Library  OperatingSystem
Library    Collections
Documentation     Cvičení: práce s promennými

*** Variables ***
${FILE}           CV11_PrvniAT.robot
${FILE_CONTAINS}  Cypress  Funkce v Pythonu  Logy  Playwright  Selenium
${ERROR}          No such file or directory
@{list}           Mozilla  Firefox  Chrome  Brave  Edge

*** Test Cases ***
#Cviceni 1 + 2
Exercise 1 - Positive Test
    ${res} =           Run       ls Cviceni
    Should Contain     ${res}    ${FILE}
    Log Entry          ${res}

Exercise 2 - Positive Test
    ${res}=            Run       ls Ukazky
    Should Contain     ${res}    ${FILE_CONTAINS}[0]
    Log Entry          ${res}

Exercise 3 - Negative Test
    ${res} =           Run       ls NonExistentFile.robot
    Should Contain     ${res}    ${ERROR}
    Log Entry          ${res}

Exercise 4 - Negative Test
    ${res} =           Run       ls nada
    Should End With    ${res}    ${ERROR}
    Log Entry          ${res}


#CVICENI 3 >>> Dokončit CV24

Test pro vypsani všech položek seznamu do logu
    Log Many           ${list}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console      The second item in the list. ${list}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    ${res} =   Get From List      ${list}             0
    Log Entry          ${res}
    Should Be Equal As Strings              ${res}    Chrome

#CVICENI 3 >>> Dokončit CV28
Sčítání
    ${res}=        Calculate    20      15

Odečítání
    ${res}=        Deduct       20      10

Násobení
    ${res}=        Multiply     2.4     3.6

Dělení
    ${res}=        Divide       6       2
    Should Be Equal As Numbers    ${res}    3
#    Should Be Equal As Numbers >>> Proc? Asi to mam spatne.

*** Keywords ***

Calculate
    [Arguments]              ${a}  ${b}
    ${res}=                  Evaluate       ${a}+${b}
    [return]                 ${res}
    Log Entry                ${res}

Deduct
    [Arguments]              ${a}  ${b}
    ${res}=                  Evaluate        ${a}-${b}
    [Return]                 ${res}
    Log Entry                ${res}

Multiply
    [Arguments]              ${a}  ${b}
    ${res}=                  Evaluate        ${a}*${b}
    [Return]                 ${res}
    Log Entry                ${res}

Divide
    [Arguments]              ${a}  ${b}
    ${res}=                  Evaluate        ${a}/${b}
    [Return]                 ${res}
    Log Entry                ${res}

Log Entry
    [Arguments]     ${res}
    Log To Console  Your result is: ${res}   #  vyhoda, text muzu zmenit na jednom miste
