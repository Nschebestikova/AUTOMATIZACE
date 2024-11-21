*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***
Sčítání
        ${result} =       Calculate    20  +  15
        Should Be Equal     ${result}   Výsledek matematické operace je 35.


Odečítání
        ${result} =       Calculate    20  -  15
        Should Be Equal     ${result}   Výsledek matematické operace je 5.


Násobení
        ${result} =       Calculate    20  *  15
        Should Be Equal     ${result}   Výsledek matematické operace je 300.


Dělení_01
        #Vzhledem k tomu, že porovnávám s řetězcem, tak jsem zvolila assertion Should Be Equal As Strings.
        ${result} =    Calculate    20  /  15
        ${expected} =    Set Variable    Výsledek matematické operace je 1.3333333333333333.
        Should Be Equal As Strings  ${result}  ${expected}

Dělení_02
        #Toto také funguje
        ${result} =       Calculate    20  /  15
        Should Be Equal     ${result}   Výsledek matematické operace je 1.3333333333333333.


Dělení_03
        #Pokud chci porovnat s hodnotou čísla, musela jsme z kalkulačky odebrat porovnání s řetězcem. (Už jsem nevěděla co by se dalo dopsat do Calculate aby tato funkce dokázala univerzálně porovnávat čísla i řetězce. To by asi musela být vnořená funkce ve funkci Calculate? Můžeme vnořovat funkce do funkcí v Keywords v Robotframworku? Nebo možná řešení je jednodušší?
        ${result} =       CalculateNum    20  /  15
        Should Be Equal As Numbers      ${result}   1.333333333333333


*** Keywords ***
Calculate
    [Arguments]     ${a}    ${o}    ${b}
    ${expression} =   Catenate  ${a}    ${o}    ${b}
    ${res} =    Evaluate    ${expression}
    ${oneString}=    Set Variable    Výsledek matematické operace je ${res}.
    Log    ${oneString}
    [Return]    ${oneString}


CalculateNum
    [Arguments]     ${a}    ${o}    ${b}
    ${expressionNum} =   Catenate  ${a}    ${o}    ${b}
    ${resNum} =    Evaluate    ${expressionNum}
    Log    ${resNum}
    [Return]    ${resNum}


