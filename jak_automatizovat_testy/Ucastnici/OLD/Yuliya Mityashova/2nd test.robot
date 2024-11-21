*** Variables ***

${POZDRAV}     Ahoj
${CISLO}       10
${DES_CISLO}   3.14

@{SEZNAM_PRAC_DNU}   pondeli  utery  streda  ctvrtek  patek
&{SLOV}              jablko=10  hrusky=20  banan=1
${ukol_promenna}    10

*** Test Cases ***
Promenne
  Log To Console   ${\n}Ahoj
  Log To Console    ${POZDRAV} ${CISLO} ${DES_CISLO}
  ${jmeno} =   Set Variable  Dane
  Log To Console    ${POZDRAV}, ${jmeno}
#  ${jmeno2} =    Evaluate    Dane

Seznam
    Log Many          @{SEZNAM_PRAC_DNU}
    Log To Console    @{SEZNAM_PRAC_DNU}[1]
   # ${L} =            Create List  1  2  3  4
   
  
Slovnik
     Log Many    &{SLOV}
     Log To Console    >>${SLOV}[jablko]
     &{L}=  Create Dictionary  klic=10   klic=ahoj

Ukol_promenna
    ${ukol_promenna}=  Set variable   10
    Log To Console    ${ukol_promenna}

*** Test Cases ***
Test 1
  Pozdrav
  ${jmeno}=   Set Variable  Dane
  Log To Console  ${jmeno}

*** Keywords ***
Pozdrav
     log To Console    Dobry den


pip install robotframework-requests