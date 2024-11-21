*** Settings ***
Library  Browser
#     odted vse spoustet takhle andrejka@Andrea-MBP ~ % open -na "PyCharm CE.app"
*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page         https://marketsquare.github.io/robotframework-browser/Browser.html
    Get Title      ==    Browser


#*** Variables ***
#
#${POZDRAV}  Ahoj
#${CISLO}    10
#${DES_CISLO}    3,14
#@{SEZNAM_PRAC_DNU}  pondeli  utery  streda  ctvrtek  patek
#&{SLOV}     jablka=10  hrusky=20
#
#*** Test Cases ***
#
#Promenne
#    Log to Console  Ahoj # constant
#    Log to Console  lslslsl ${POZDRAV} kkwkw
#    ${jmeno} =  Set Variable    Helen
#    Log to Console  ${POZDRAV}, ${jmeno}
#
#Seznam
#    Log Many    ${SLOV}
#    Log To Console      @{SEZNAM_PRAC_DNU}[1]
#    Log To Console    ${SLOV}[jablka]
#    &{L}=   Create Dictionary  klic=10
#
##'&' slovnik
#Cviceni 1
#    ${x} =  Set Variable    10
#    Should Be Equal As Integers      ${x}    10
#
#Test 1
#    Pozdrav      Ahoj        Dane
##    ${jmeno} =  Set Variable    Helen
##    Log To Console    ${jmeno}
#
#Test 2
#    ${vysledek}=        Secti       10      20
#    Log To Console      ${vysledek}
#
#Test3
#    ${vysledek}=        Vynasob       2      2
#    Log To Console      ${vysledek}
#
#*** Keywords ***
#Pozdrav
#    [Arguments]     ${typ_p}  ${jmeno}
#    Log To Console  ${typ_p},  ${jmeno}
#
#Secti
#    [Arguments]     ${a}  ${b}
#    ${v}=       Evaluate        ${a}+${b}
#    [Return]  ${v}
#
#Vynasob
#    [Arguments]     ${a}  ${b}
#    ${v}=       Evaluate        ${a}*${b}
#    [Return]  ${v}
#
#
