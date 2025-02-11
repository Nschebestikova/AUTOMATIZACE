*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***

@{Browsers} =   Mozzila     Chrome   Safari

*** Test Cases ***

Vypsani vsech polozek
    Log Many   @{Browsers}

Vypsani druhe polozky seznamu
    Log To Console  ${Browsers}[1]

Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain    ${Browsers}[0]    Chrome