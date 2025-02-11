*** Settings ***
Library  OperatingSystem
Library  String

#  Cvicenie 1, 2 - pridanie premennych do testov a vypisanie do Log-u

*** Variables ***
${TEXT1}      help rename
${ODPOVED1}   Renames a file or files.
${TEXT2}      TOTO BUDE MALYM PISMOM
${ODPOVED2}   Text je malym pismom

*** Test Cases ***
Pozitivny test 1
    ${res}            run         ${TEXT1}
    Should Contain    ${res}      ${ODPOVED1}
    Log To Console    ${TEXT1}
    Log               Bol spustený prikaz ${TEXT1} s odpovedou ${ODPOVED1}

Pozitivny test 2
    ${str}                  Convert To Lower Case    ${TEXT2}
    Should Be Lower Case    ${str}   ${ODPOVED2}
    Log To Console          ${TEXT2}
    Log                     Text ${TEXT2} bol zmeneny na ${str}

Pozitivny test 3
    ${vysl} =               Nasobenie_PT3    365    365
    Log To Console          ${vysl}
    Log                     Klucove slovo Nasobenie_PT3 vypocita 2 cisla a vysledok bude ${vysl}

# Negativne test case-y

Negativny test 1
    ${prikaz} =     Set Variable    help times
    ${res} =        run             ${prikaz}
    Should Contain  ${res}          This command is not supported by the help utility.  Try "times /?".
    Log To Console  ${prikaz}
    Log             Prikaz ${prikaz} je nespravny, preto sa vypise ${res}

Negativny test 2
    ${plus} =         Spocitaj_NT2    25    65
    Log To Console    ${plus}
    Log               Klucove slovo Spocitaj_NT2 vypocita 2 cisla a vysledok bude ${plus}


*** Keywords ***
Nasobenie_PT3
    [Arguments]     ${a}  ${b}
    ${nasobtest1}   Evaluate    ${a}*${b}
    [Return]        ${nasobtest1}

Spocitaj_NT2
     [Arguments]    ${a}  ${b}
     ${spocitaj2}   Evaluate    ${a}+${b}
     [Return]       ${spocitaj2}