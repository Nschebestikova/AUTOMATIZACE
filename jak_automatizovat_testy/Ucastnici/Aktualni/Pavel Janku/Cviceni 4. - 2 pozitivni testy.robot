

*** Settings ***
Library     OperatingSystem


*** Test Cases ***

4a. Test rychlosti odezvy pozitivni - (4x opakování)
    ${response} =    Run    ping -n 4 8.8.8.8
    Log             ${response}
    Should Contain  ${response}  Reply




4b. Kontrola DNS rozlišení - pozitivní
    ${response} =    Run    nslookup www.ihned.cz
    Log             ${response}
    Should Contain  ${response}  Address:


