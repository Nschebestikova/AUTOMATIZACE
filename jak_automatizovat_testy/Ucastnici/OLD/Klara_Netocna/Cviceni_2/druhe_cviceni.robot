#proměnné dolary
*** Variables ***
${nevim}    Ahoj
@{seznam1}  pondělí   úterý   středa  čtvrtek pátek
${cislo}    10

*** Test Cases ***
Pouzivame promenne
    Log To Console  ${nevim}
    Log To Console  Dobrý den
    
    ${druha}=  Set Variable   Hello
    Log To Console    ${druha}
    
#seznamy - zavináče
    @{seznam2}=   Create List   pondělí   úterý   středa  čtvrtek  pátek
    Log Many            @{seznam2}
    Log To Console      >>> ${seznam2}[1] ${seznam2}[2]<<<

#slovníky
    &{slovnik1}=  Create Dictionary  jmeno=user01    heslo=SDFS55
    Log Many            &{slovnik1}
    Log To Console      ${slovnik1}[heslo]

    ${list}=    Evaluate    ${cislo} * 10
    #je to ve cviceni 23
    
Pouzivame klicova slova
    Log To Console    */*
    Pozdrav
    Pozdrav2  Karle
    ${vysledek}=  Secti    10    15
    Log To Console  ${vysledek}
#klicova slova
*** Keywords ***
Pozdrav
    Log To Console  Dobry den
Pozdrav2
    [Arguments]     ${jmeno}
    Log To Console  Dobry den
    Log To Console  Dobry den, ${jmeno}

Secti
    [Arguments]     ${x}  ${y}
    ${v}=  Evaluate  ${x} + ${y}
    [Return]        ${v}