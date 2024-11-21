*** Settings ***
Library  OperatingSystem
Library  Browser

*** Variables ***
#promenna pro vsechny test cases
${nevim}    Ahoj
${cislo}    1
@{seznam}   pondeli  utery  streda  ctvrtek  patek

*** Test Cases ***

Muj Prvni Test
    ${output} =       Run          help dirs
    Log               ${output}

    Should Contain    ${output}    [+N]

Druhy Test
    ${output} =       Run          help abcs
    Log               ${output}

    Should Contain    ${output}    no help topics match

Treti test s promennou
#promennna pouze pro tenhle test
    ${druha} =  Set Variable    Hello
    Log To Console  ${druha}

    #seznamy
    @{seznam1} =   Create List     pondeli utery   streda  ctvrtek patek
    Log Many    @{seznam1}
    Log To Console    ${seznam}[1]  #vypise utery
    Log To Console    promenna ${seznam}[${cislo}]

    #slovniky (dictionaries)
    &{slovnik} =  Create Dictionary  jmeno=user01  heslo=8763kjdg
    Log Many    &{slovnik}
    Log To Console    ${slovnik}[heslo] #vypise heslo ze slovniku
    Log To Console    ${slovnik.heslo} #jiny zapis pro stejne vypsani hesla ze slovniku

    #vypocet
    ${vypocet} =  Evaluate    ${cislo} * 10     #vypocet s promennymi jako je mozny v pythonu

Starting a browser with a page
    New Browser    chromium    headless=false
    New Page         https://marketsquare.github.io/robotframework-browser/Browser.html
    Get Title      ==    Browser