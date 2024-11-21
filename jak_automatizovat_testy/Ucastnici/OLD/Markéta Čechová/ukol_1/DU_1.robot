** Settings ***
Library         OperatingSystem

*** Test Cases ***
# Pozitivni testy


Test pozitiv 1

    ${res} =  run  help rmdir

    Should Contain  ${res}  Removes (deletes) a directory.

Test pozitiv 2

    ${res} =  run   cd .. && echo ok
    Should Contain  ${res}  ok

# Negativni testy

Test negativ 1

    ${res} =  run   cd neexistujici_slozka
    Should Contain  ${res}  Syst‚m nem…§e nal‚zt uvedenou cestu.

Test negativ 2

    ${res} =  run  bflmpsvz

    Should Contain  ${res}  not recognized as an internal or external command