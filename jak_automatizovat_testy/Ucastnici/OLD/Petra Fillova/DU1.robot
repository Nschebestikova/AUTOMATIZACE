*** Settings ***
Library  OperatingSystem

*** Test Cases ***

test na prikaz dir - 1.pozitivni
    ${output} =  Run    help
    Log               ${output}
    Should Contain    ${output}    For more information on a specific command, type HELP command-name

test na prikaz dir - 2.pozitivni
    ${output} =  Run    vol
    Log               ${output}
    Should Contain    ${output}    Volume Serial Number is

test na prikaz dir - 1.negativni
    ${output} =  Run    neexist
    Log               ${output}
    Should Contain    ${output}     is not recognized

test na prikaz dir - 2.negativni
    ${output} =  Run    dirs
    Log               ${output}
    Should Contain    ${output}    is not recognized