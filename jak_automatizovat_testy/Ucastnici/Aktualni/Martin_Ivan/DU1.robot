*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Nastavenie adaptéru pozitivní
    ${res} =                 run                   ipconfig
    log                      ${res}
    Should Contain Any       ${res}                192.168.0.1      255.255.255.0      192.168.0.1

Steam jede na pozadí pozitivní
    ${res} =                 run                   tasklist
    log                      ${res}
    Should Contain           ${res}                steam.exe

Steam vypnutí pozitivní
    ${res} =                 run                   TASKKILL /IM steam.exe
    log                      ${res}
    Should Contain           ${res}                SUCCESS: Sent termination signal to the process "steam.exe" with PID

Pip list bez Pascalu Negativní
    ${res} =                 run                   pip list
    log                      ${res}
    Should Contain           ${res}                Pascal

IPv6 protokol Negativní
    ${res} =                 run                   ipconfig
    log                      ${res}
    Should Contain           ${res}                IPv6 Address. . . . . . . . . . . : 192.168.0.113