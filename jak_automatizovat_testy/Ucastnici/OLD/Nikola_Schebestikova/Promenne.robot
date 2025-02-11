*** Settings ***
Library     OperatingSystem
Library	     Collections

*** Variables ***
${cislo}     10
@{LIST}      20  12  32  2323  444 4422
&{dict}      login=karel  heslo=daddy
*** Test Cases ***

Test na ověřeni čísla - proměnné + list
#     ${x} =                     Set Variable   10
#     Log To Console                 ${10}
#     Should Be Equal As Numbers    ${x}    10
#
#     @{LIST}           Create List       20  12  32  2323  444 4422
#     Log Many          @{LIST}
#     Log To Console    ${LIST} [1]


     &{dict}           Create Dictionary   login=karel  heslo=daddy
     Log Many          &{dict}
     Log To Console    ${dict}
     Log To Console    -----${dict.heslo}<<<<
     Log               ${dict.heslo}


Testování pozdravů
      Pozdrav
      Pozdrav2    Nikola

*** Keywords ***
Pozdrav
   Log To Console    Dobrý den

Pozdrav2
    [Arguments]    ${name}
    Log To Console    ${name}
