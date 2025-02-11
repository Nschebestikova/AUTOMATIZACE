*** Settings ***
Library    OperatingSystem

*** Variables ***
${pozdrav}      Ahoj


*** Test Cases ***
#Napřiklad příkaz nebo kontrolní text nastavte jako proměnou v sekci Variables
#Příklad pro RFW:
#${output_text}     For more information on a specific command
#kličové slovo na spuštění, nebo vyhodnocení

Prvni test - Ukol1 (pozitivní kontrola)
   ${results} =                   Run             ${pozdrav}
   Log To Console                 ${results}
   Should Be Equal As Strings     ${results}      Ahoj    collapse_spaces=true

Druhy test - pozitivni kontrola2
   ${results} =         Run             dir C:\Users\eliskasvecova
   Log To Console       ${results}
   Should Contain       ${results}      Number is 4098-77F9

Treti test - negatinvi kontrola1
   ${results} =             Run             echo Ahoj
    Log To Console          ${results}
    Should Not Be Equal     Be Equal     ${results}      Ahoj bleble

Ctvrty test - negativni kontrola2
   ${results} =             Run             dir C:\Users\eliskasvecova
   Log To Console           ${results}
   Should Not Contain       Contain       ${results}      Roman a Scifi

paty test
  Spusteni                  echo ahoj       ahoj

sesty test
  Spusteni                  help            Displays


*** Keywords ***

spusteni
   [Arguments]              ${prikaz}       ${vysledek}
   ${res} =                 Run             ${prikaz}
   Log To Console           ${res}
   Should Contain           ${res}      ${vysledek}