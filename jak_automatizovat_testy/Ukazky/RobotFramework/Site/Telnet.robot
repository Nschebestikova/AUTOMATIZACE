*** Settings ***
Library           Telnet

*** Variables ***
${HOST}           192.168.1.100
${USERNAME}       user
${PASSWORD}       password

*** Test Cases ***
Basic Telnet Login Test
    Open Connection    ${HOST}
    Login              ${USERNAME}    ${PASSWORD}
    ${output}=         Execute Command    whoami
    Should Be Equal As Strings    ${output}    ${USERNAME}
    ${uptime}=         Execute Command    uptime
    Log                Uptime of the server is: ${uptime}
    Close Connection