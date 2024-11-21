*** Settings ***
Library  String
Library  OperatingSystem


*** Variables ***
${numberA}   10
${numberB}   15

*** Test Cases ***
Pocitani
   ${res}=    Secti    ${numberA}  ${numberB}
   Log To Console       ${res}


*** Keywords ***
Secti
   [Arguments]    ${numberA}    ${numberB}
   [Documentation]  Klíčové slovo s parametry a návratovou hodnotou
   ${res}=        Evaluate    ${numberA}+${numberB}
   [return]       ${res}


