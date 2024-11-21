*** Settings ***
Library     OperatingSystem

*** Variables ***
${HELLO}     echo Hello World
${ENV}       echo "Current environment variables: $(env)"
${HOME}      echo $HOME
${UNKNOWN}   echo \$NEVIM
${AHOJ}      echo("ahoj")


*** Test Cases ***

Prvni test pozitivní
    ${res}          run     ${HELLO}
    Should Contain  ${res}  Hello World
    log             po zadání příkazu se zobrazí ${res}

Druhy test pozitivni
    ${res}            run        ${ENV}
    Should Contain    ${res}     USER
    log               po zadání příkazu se zobrazí ${res}

Treti test pozitivni
    ${res}            run        ${HOME}
    Should Contain    ${res}     Users
    log               po zadání příkazu se zobrazí ${res}

Prvni test negativni
    ${res}             run     ${UNKNOWN}
    Should Be Empty    ${res}
    log                po zadání příkazu se nic nezobrazí ${res}

Druhý test negativni
    ${res}             run     ${AHOJ}
    Should Not Be Equal       ${res}     ahoj
    log                po zadání příkazu se zobrazí ${res}

















#*** Settings ***
#Library           OperatingSystem
#
#
#*** Test Cases ***
#
#Prvni test
#    ${result} =      run            help
#    Log             ${result}
#    Should Contain  ${result}       For more information on a specific command, type HELP command-name
#
#Druhy test
#    ${result} =      run            TASKLIST
#    Should Contain   ${result}      Calculator.exe

