*** Settings ***
Library     OperatingSystem
Library    Process
Library    Browser



*** Variables ***
${Home}                 https://www.zajezdy.cz/
${Alllast}              https://last-minute.zajezdy.cz/
${Turecko}              https://last-minute.zajezdy.cz/turecko/
${nonExistentLocator}   css=nonexistent-element-selector



*** Test Cases ***
První test - pozitivní
    Log                 Začínám pozitivní test na domovskou stránku
    Open Browser        ${Home}    browser=chromium
    ${title}    Get Title
    Should Contain      ${title}   Zájezdy
    Log                 Domovská stránka byla úspěšně načtena
    Close Browser




Druhy test - pozitivni

    Log                 Začínám test na nalezený element na stránce pro Turecko
    Open Browser        ${Alllast}     browser=chromium
    Click               id=sb-listing
    Sleep               5
    Log                 Test úspěšně ověřil, že element byl nalezen na stránce




Treti test - negativni
    Log                 Začínám negativní test na neexistující stránku
    Open Browser       ${Home} https://www.zájezd.cz/    browser=chromium
    Sleep               3
    ${title}    Get Title
    Should Contain  ${title}    Stránka nenalezena
    Log                 Test úspěšně ověřil chybu při načítání neexistující stránky



Ctvrty test - negativni
    Log                 Začínám negativní test na stránku s last-minute nabídkami pro Turecko
    Open Browser        ${Turecko}    browser=chromium
    Element Should Not Exist    ${nonExistentLocator}
    Log                 Test úspěšně ověřil chybu při pokusu o kliknutí na neexistující element
    Close Browser


*** Keywords ***

 Element Should Not Exist
    [Arguments]    ${locator}
    ${elementCount}=    Get Element Count    ${locator}
    Should Be Equal As Numbers    ${elementCount}    0