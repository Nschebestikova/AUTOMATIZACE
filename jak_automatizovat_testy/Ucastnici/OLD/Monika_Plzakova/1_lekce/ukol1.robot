*** Settings ***
Library     OperatingSystem

*** Test Cases ***
Pozitivni_1
    ${output} =     Run    ping -n 5 www.seznam.cz
    Log To Console         ${output}
    Log                    ${output}

    Should Contain  ${output}    Pinging www.seznam.cz [77.75.77.222]

Pozitivni_2
    ${output} =     Run    tracert 127.0.0.1
    Log To Console         ${output}
    Log                    ${output}

    Should Contain  ${output}    Trace complete.

Negativni_1
    ${output} =     Run    ping -n5 www.seznam.cz
    Log To Console         ${output}
    Log                    ${output}

    Should Contain  ${output}    Bad value for option

Negativni_2
    ${output} =     Run    tracrt 127.0.0.1
    Log To Console         ${output}
    Log                    ${output}

    Should Contain  ${output}    is not recognized as an internal