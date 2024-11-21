*** Settings ***
Library     OperatingSystem

*** Variables ***
${domena}       www.seznam.cz
${localhost}    127.0.0.1

*** Test Cases ***
Pozitivni_1
    ${output} =     Run          ping -n 5 ${domena}
    Logy    ${output}

    Should Contain  ${output}    Pinging ${domena}

Pozitivni_2
    ${output} =     Run          tracert ${localhost}
    Logy                         ${output}

    Should Contain  ${output}    Trace complete.

Negativni_1
    ${output} =     Run          ping -n5 ${domena}
    Logy                         ${output}

    Should Contain  ${output}    Bad value for option

Negativni_2
    ${output} =     Run          tracrt ${localhost}
    Logy                         ${output}

    Should Contain  ${output}    is not recognized as an internal

*** Keywords ***

Logy
    [Arguments]         ${vystup}
    [Documentation]     Zaloguje vystup do terminalu a do logu

    Log To Console      ${vystup}
    Log                 ${vystup}