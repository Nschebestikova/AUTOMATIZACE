*** Keywords ***
Pozdrav1
   Log to Console  Dobrý den,

*** Test Cases ***
Test1
    Pozdrav1
    ${jmeno} =  Set Variable  Dane
    Log to Console  ${jmeno}



*** Keywords ***
Pozdrav2
   [Arguments]  ${jmeno}
   Log to Console  Dobrý den    ${jmeno}

*** Test Cases ***
Test2
    Pozdrav2    Ahoj    Dane




*** Keywords ***
Pozdrav3
   [Arguments]  ${typ_p}  ${jmeno}
   Log to Console  ${typ_p}  ${jmeno}

*** Test Cases ***
Test3
    Pozdrav3    Ahoj    Dane



*** Keywords ***
Secti
   [Arguments]  ${a}  ${b}
   ${v}  Evaluate    ${a}+${b}
   [Return]

*** Test Cases ***
Test4
    ${vysledek} =  Secti    10    20
    Log to Console  ${vysledek}


*** Keywords ***
Vynasob
   [Arguments]  ${a}  ${b}
   ${v}  Evaluate    ${a}*${b}
   [Return]

*** Test Cases ***
Test5
    ${vysledek} =  Vynasob    10    20
    Log to Console  ${vysledek}