# Proměnné

*** Variables ***   #vždy lepší přidat proměnné - tady jsou globální, tj. dá se použít ve všech testech níže, většinou globální proměnna se píše velkými písmeny
${POZDRAV}      Ahoj
${CISLO}        10
${DES_CISLO}    3.14
${X}            10

@{SEZNAM_PRAC_DNU}  pondělí  úterý  středa  čtvrtek  pátek  #pozor - vždy mezi položkami dvě mezery - nejčastější chyba
&{SLOV}             jablka=10  hrusky=20  pomerance=25


*** Test Cases ***
Promenne
    Log To Console    Ahoj         #bez odřádkování
    Log To Console    ${\n}Ahoj    #včetně odřádkování
    Log To Console    ${POZDRAV} ${CISLO} ${DES_CISLO}
    ${jmeno} =    Set Variable    Dane  #tady je vytvořena lokální proměnná, píše se většinou malými písmeny
    Log To Console    ${POZDRAV}, ${jmeno}
#   ${jmeno} =    Evaluate [1,2,3,4]  nebo  Evaluate 4 * 8 #tady je vytvořena lokální proměnná stejně jako v Pythonu, tj. jiný zápis

Seznam
#   Log To Console    @{SEZNAM_PRAC_DNU}   to nefunguje, protože Log To Console tomu nerozumí
    Log Many    @{SEZNAM_PRAC_DNU}  #toto funguje
    Log To Console    >>>${SEZNAM_PRAC_DNU}[1]   #vybere druhou položku ze seznamu - pozor čísluje se od nuly
    @{L} =  Create List  1  2  3  4    #takto se dá také vytvořit seznam do proměnné

#dobré je také např. vytvořit seznam na druhý prohlížečů

Slovnik
    Log To Console    <<<${SLOV}[jablka]   #nebo funguje i syntaxe ${SLOV.jablka}, ten text <<< je jen aby se to rychle našlo v textu
    &{L} =  Create Dictionary  klic=10  klic2=ahoj

Cvičení - Ověření, že globální proměnná X (definována nahoře) má hodnotu 10
    Should Be Equal As Integers    ${X}    10

Test1 s použítím klíčového slova
    Pozdrav  Ahoj  Dane   #vypíše pozdrav - definováno v klíčových slovech níže
    Pozdrav  Dobrý den  Jene   #vypíše pozdrav - definováno v klíčových slovech níže
    ${jmeno} =      Set Variable  Dane
    Log To Console    ${jmeno}

Test2  #zavolá klíčové slovo/funkci Sečti a vytáhne výsledek a vypíše ho
    ${vysledek} =   Secti  10  20
    Log To Console    ${vysledek}

Test3
    ${vysledek_nasobeni} =   Vynasob  2  3
    Log To Console  ${vysledek_nasobeni}

*** Keywords ***  #takto vytvářím klíčová slova - napíšu název a pod to, co to má dělat - něco jako funkce
Pozdrav
    [Arguments]       ${typ_pozdravu}  ${jmeno}    #pokud přidám řádek Arguments, tak přidám do mé fuknce parametry
    Log To Console    ${typ_pozdravu}, ${jmeno}

Secti  #klíčové slovo (funkce) na sčítání s použitím návratové hodnoty
    [Arguments]       ${a}  ${b}
    ${v} =            Evaluate    ${a}+${b}
    [Return]          ${v}

Vynasob  #klíčové slovo (funkce) na násobení s použitím návratové hodnoty
    [Arguments]       ${a}  ${b}
    ${v} =            Evaluate    ${a}*${b}
    [Return]          ${v}
#v DU_02 mám jednu funkci all-in-one na sčítání, odečítání, násobení i dělení







