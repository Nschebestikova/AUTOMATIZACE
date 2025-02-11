*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page

   [Setup]          Open Browser   browser=chrome
   Go To            https://allegro.cz

User login on web application

    &{dict}             Create Dictionary       login=kasslovalia@gmail.com         password=test159
    Log To Console      ${dict.login}
    Should Contain      ${dict.login}           kasslova
    Log                 ${dict}
    Log Many            ${dict}


*** Settings ***
Documentation     Cvičení: práce s promennými


*** Variables ***
@{BROWSERS}     Chrome  Mozilla  Edge  Safari

*** Test Cases ***

Test pro vypsani všech položek seznamu do logu
   Log Many     ${BROWSERS}


Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${BROWSERS}[1]

Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain    ${BROWSERS}[0]    Chrome



*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}

Násobení
        ${result}=          Calculate  20  15  *
        Should Be Equal     ${result}  ${300}


Dělení
        ${result}=          Calculate  20  15  /
        Should Be Equal As Numbers    1    1



*** Keywords ***

Calculate
    [Arguments]    ${a}  ${b}  ${operator}
    ${res}=        Evaluate    ${a} ${operator} ${b}
    [return]       ${res}


