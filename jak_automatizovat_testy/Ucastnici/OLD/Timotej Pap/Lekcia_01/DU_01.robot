*** Settings ***
Library  OperatingSystem
Library  String

*** Test Cases ***
# Pozitivne test case-y

Pozitivny test 1
    ${res}  run  help rename
    Should Contain    ${res}    Renames a file or files.

Pozitivny test 2
    ${str}  Convert To Lower Case    TOTO BUDE MALYM PISMOM
    Should Be Lower Case    ${str}   Text je malym pismom
    Log To Console    ${str}

Pozitivny test 3
    Should Be Equal As Integers      ${365 * 365}  133225

# Negativne test case-y

Negativny test 1
    ${res}  run  help times
    Should Contain  ${res}           Searches for strings in files.

Negativny test 2
    Should Be Equal As Integers      ${25 + 65}  100

Negativny test 3
    ${str}  Convert To Upper Case    Text na otestovanie
    Should Be Lower Case    ${str}   Text je veľkým písmom
