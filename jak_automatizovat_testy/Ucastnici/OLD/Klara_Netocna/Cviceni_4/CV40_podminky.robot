*** Variables ***
${zvire}  slon

*** Test Cases ***
Podminky

#    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
    IF  "${zvire}" == "slon"  #texty musi byt v uvozovkach
        Log To Console    Je to slon
    ELSE
        Log To Console    Neni to slon
    END

Cykly
    FOR    ${counter}    IN RANGE    1    10    1
        Log to console   ${counter}
    END