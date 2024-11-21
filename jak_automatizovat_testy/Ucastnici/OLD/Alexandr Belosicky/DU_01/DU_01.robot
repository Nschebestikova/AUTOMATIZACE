*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Pozitivni test 1
    ${res} =    Run    help

    Should Contain    ${res}    For more information on a specific command, type HELP command-name

Pozitivni test 2
    ${res} =    Run    ping

    Should Contain    ${res}    Usage: ping [-t]

Negativni test 1
    ${res} =    Run    asdfg

    Should Contain    ${res}    'asdfg' is not recognized as an internal or external command

Negativni test 2
    ${res} =    Run    ?

    Should Contain    ${res}    '?' is not recognized as an internal or external command


