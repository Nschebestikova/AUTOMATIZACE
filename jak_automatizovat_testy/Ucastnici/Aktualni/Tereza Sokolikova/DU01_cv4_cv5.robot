*** Settings ***
Library     OperatingSystem


*** Test Cases ***
Prvni test pozitivni ping 1.1.1.1 se provede 10x
   ${res}=           run         ping 1.1.1.1 -n 10
   log               ${res}
   Should Contain    ${res}      Packets: Sent = 10
   Should Contain    ${res}      Received = 10
   Should Contain    ${res}      Lost = 0 (0% loss)

Druhy test pozitivni overeni spusteni a prace v Pycharmu
   ${res}           run         tasklist
   log              ${res}
   Should Contain   ${res}     pycharm64.exe
   Should Contain   ${res}     python.exe

Prvni negativni test ping 999.999.999.999 neexistuje
   ${res}              log         ping 999.999.999.999
   log                 ${res}
   Should Be Equal     ${res}      ${None}

Druhy negativni test dir
   ${res}            log           dir c:\neznamy_adresar
   log               ${res}
   Should Be Equal   ${res}        ${None}