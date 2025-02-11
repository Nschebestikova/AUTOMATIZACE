*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}
        Log  Toto je vysledok scitania: ${result}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}
        Log  Toto je vysledok odcitania: ${result}

Násobení
        ${result}=          Calculate  20  15  *
        Should Be Equal     ${result}  ${300}
        Log  Toto je vysledok nasobenia: ${result}

Dělení
        ${result}=          Calculate  20  15  /
        Should Be Equal As Numbers     ${result}  ${1.33333333}
        Log  Toto je vysledok delenia: ${result}

#    Should Be Equal As Numbers


*** Keywords ***

Calculate
    [Arguments]    ${arg1}  ${arg2}  ${Var}   #dve medzery medzi arguments
    ${res}=        Evaluate    ${arg1} ${Var} ${arg2}   #jedna medzera
    [return]       ${res}
