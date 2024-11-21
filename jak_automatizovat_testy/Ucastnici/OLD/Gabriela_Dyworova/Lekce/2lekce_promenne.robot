*** Variables ***
${POZDRAV}      Ahoj
${CISLO}        18
${DES_CISLO}    3.14
${UKOL}         10

@{SEZNAM_PRAC_DNU}  pondeli  utery  streda  ctvrtek  patek
&{SLOVNIK}          jablka=10  hrusky=20  banan=1

*** Test Cases ***
Promenne
    Log To Console  ${\n}Ahoj
    Log To Console  ${POZDRAV} ${CISLO} ${DES_CISLO}
    ${jmeno} =      Set Variable    Dan
    Log To Console  ${POZDRAV}, ${jmeno}

*** Test Cases ***
Seznam
   Log Many  @{SEZNAM_PRAC_DNU}
   Log To Console  ${SEZNAM_PRAC_DNU}[1]
   @{L} =  Create List  1  2  3 4

*** Test Cases ***
Slovník
    Log Many  @{SLOVNIK}
    Log To Console  ${SLOVNIK}[jablka]
    Log To Console  ${SLOVNIK.jablka}
    ${L} =  Create Dictionary  klic=10

*** Test Cases ***
Promenna ukol
    Log To Console  ${UKOL}
    Should Be Equal  ${UKOL}   10

    Hodnota X se rovná 10
    # Definice proměnné x s počáteční hodnotou
    ${x}    Set Variable    10

    # Ověření, že hodnota x je správná
    Should Be Equal As Integers    ${x}    10