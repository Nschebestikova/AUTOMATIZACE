*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${res}           Calculate  20  15  +     # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal As Integers        ${res}  35

Odečítání
        ${res}         Calculate    1432  12  -
        Should Be Equal    ${res}     ${1420}  #zápis výsledného čísla jako stringu do {}

Násobení
        ${res}        Calculate    5  10  *
        Should Be Equal As Integers        ${res}  50

Dělení
    ${res}     Calculate  5  2  /
    Should Be Equal As Numbers       ${res}  2.5


*** Keywords ***

Calculate
    [Arguments]    ${x}  ${y}  ${operator}
    ${res}         Evaluate  ${x} ${operator} ${y}
    [Return]       ${res}


# přidané klíčové slovo pro přihlášení
Login
    [Arguments]    ${username}   ${password}
    Input Text     pavlina@gmail.com   ${username}
    Input Text     inputPasswordID   ${password}
    Click Button   buttonID

# další test na spuštění webové stránky
*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
   Get Title      ==    Browser

