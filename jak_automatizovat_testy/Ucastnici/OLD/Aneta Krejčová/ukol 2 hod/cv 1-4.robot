*** Settings ***
Library  OperatingSystem

*** Variables ***
${NEGATIVNI_VYSLEDEK}  This command is not supported by the help utility.
${VYSLEDEK_DIR}        Displays a list of files and subdirectories in a directory.
${VYSLEDEK_TYPE}       Displays the contents of a text file or files.

*** Keywords ***
 Login
   [Arguments]     ${jmeno}        ${prijmeni}
    Log  ${jmeno}
    Log  ${prijmeni}

*** Test Cases ***
Muj prvni test
  log  Ahoj

pozitivni test
    ${res} =  run  help dir

    Should Contain    ${res}    ${VYSLEDEK_DIR}
    Log               Hlaska je: ${VYSLEDEK_DIR}

druhý pozitivní test
    ${res} =  run  help type

    Should Contain    ${res}    ${VYSLEDEK_TYPE}
    Log               Hlaska je: ${VYSLEDEK_TYPE}
negativni test
    ${res} =  run  help chacha

    Should Contain    ${res}    ${NEGATIVNI_VYSLEDEK}
    Log               Hlaska je: ${NEGATIVNI_VYSLEDEK}
druhý negativni test
    ${res} =  run  help ls

    Should Contain    ${res}    ${NEGATIVNI_VYSLEDEK}
    Log               Hlaska je: ${NEGATIVNI_VYSLEDEK}
kličové slovo
    ${result}=  Login  Aneta  Krejčová