*** Settings ***   #DU_02_CV3
Library         OperatingSystem

*** Variables ***
${PRIKAZ1}          help mkdir
${PRIKAZ2}          help path
${OUTPUT TEXT}                                           Displays or sets a search path for executable files.

*** Test Cases ***
Pozitivni test 1
    ${res}          SpustMe                ${PRIKAZ1}
                    Should Contain         ${res}       Creates a directory.    #kontrola zda se vytiskne zadanym prikazem dany text
                    Log                                 globalni promenna PRIKAZ1 je ${PRIKAZ1}
                    Log                                 nactena hodnota pozitivniho testu 1 je ${res}

Pozitivni test 2
    ${res}          SpustMe                 ${PRIKAZ2}
                    Should Contain          ${res}      ${OUTPUT TEXT}
                    Log                                 globalni promenna PRIKAZ2 je ${PRIKAZ2}
                    Log                                 nactena hodnota pozitivniho testu 2 je ${res}


Negativni test 1
    ${prikaz3}      Set Variable            help jkl
    ${res}          SpustMe                 ${prikaz3}
                    Should Contain          ${res}      This command is not supported by the help utility.
                    Log                                 lokalni promenna prikaz3 je ${prikaz3}
                    Log                                 nactena hodnota negativniho testu 1 je ${res}


Negativni test 2
    ${prikaz4}      Set Variable            !
    ${res}          SpustMe                 ${prikaz4}
                    Should Contain          ${res}      '!' is not recognized as an internal or external command
                    Log                                 lokalni promenna prikaz4 je ${prikaz4}
                    Log                                 nactena hodnota negativniho testu 2 je ${res}

*** Keywords ***
SpustMe
                    [Arguments]             ${prikaz}
    ${res}          Run                     ${prikaz}
                    [Return]                ${res}

