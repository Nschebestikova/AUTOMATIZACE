*** Settings ***
Library           Process
Library    OperatingSystem

*** Test Cases ***
#Pozitivní testy
Test 1
    ${res} =        Run     help dir
    log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.


Test 2
    [Documentation]    Example of testing another command
    ${result}    Run Process    echo Hello, Robot Framework    shell=True
    Should Contain    ${result.stdout}    Hello, Robot Framework

#Negativní testy
Test 3
    ${res} =        Run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.

Test 4
    [Documentation]    Test if 'is not recognized' message is in the output of a nonexistent command
    ${result}    Run Process    unknown_command    shell=True
    Should Contain    ${result.stderr}    is not recognized
