*** Settings ***
Library    OperatingSystem

*** Test Cases ***
Pozitivní test - dir
    ${output} =    Run    dir C:\\Windows
    Should Contain    ${output}    notepad.exe

Pozitivní test - ping
    ${output} =    Run    ping 1.1.1.1
    Should Contain    ${output}    Reply from 1.1.1.1

Negativní test - neexistující adresář
    ${output} =    Run    dir C:\\NeexistujiciAdresar
    Should Contain    ${output}  contains the text File not found.

Negativní test - neplatná adresa pro ping
    ${output} =    Run    ping neexistujici_adresa
    Should Not Contain    ${output}    Ping request could not find host neexistujici_adresa

