

*** Settings ***
Library     OperatingSystem


*** Test Cases ***



5a.Test rychlosti odezvy - negativni
    ${res} =        run     ping 321
    log             ${res}
    Should Contain  ${res}  failure



5b.Kontrola DNS rozlišení - negativní
    ${response} =    Run    nslookup www.nesmysl.aa
    Log             ${response}
    Should Contain  ${response}  UnKnown