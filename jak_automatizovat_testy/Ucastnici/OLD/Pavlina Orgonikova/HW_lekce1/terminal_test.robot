*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     echo Hello World
    log             ${res}
    Should Contain  ${res}  Hello World

Druhy test pozitivni
    ${res} =     run        echo "Current environment variables: $(env)"
    log               ${res}
    Should Contain    ${res}     USER

Treti test pozitivni
    ${res} =     run        echo $HOME
    log               ${res}
    Should Contain    ${res}     Users

Prvni test negativni
    ${res} =        run     echo $nevim
    log             ${res}
    Should Be Empty    ${res}

Druhý test negativni
    ${res} =        run     echo("ahoj")
    log             ${res}
    Should Not Be Equal       ${res}     ahoj



























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

