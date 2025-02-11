*** Variables ***
${zvire}  slon
${cislo}  10

*** Test Cases ***
Podminky1

#    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
    IF  "${zvire}" == "slon"
        Log To Console    Je to slon
    ELSE
        Log To Console    Neni to slon
    END


Podminky2

#    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
    IF  "${cislo}" == 10
        Log To Console    Je to 10
    ELSE
        Log To Console    Neni
    END



Cykly1
    FOR    ${counter}    IN RANGE    1    10    2
        Log To Console    ${counter}
    END

Cykly2
    FOR    ${counter}    IN    1    10    2
        Log To Console    ${counter}
    END

Cykly3
    FOR    ${counter}    IN    1    10    1
        Log To Console    ${counter}
    END