*** Settings ***
Library    OperatingSystem
Library    String

*** Variables ***
${pozdrav}      ahoj


*** Test Cases ***
#Napřiklad příkaz nebo kontrolní text nastavte jako proměnou v sekci Variables
#Příklad pro RFW:
#${output_text}     For more information on a specific command
#kličové slovo na spuštění, nebo vyhodnocení

1 -pozitivní kontrola1
    #${results} =                    Run             echo ${pozdrav}
    #Log To Console                  ${results}
    # Should Be String               ${results}      ahoj
    Spusteni+                        echo ${pozdrav}    ${pozdrav}


2 -pozitivni kontrola2
    #${results} =                    Run             help
    #Log To Console                  ${results}
    #Should Contain                  ${results}      For more information
    Spusteni+                        help            For more information

3 -negatinvi kontrola1
    #${results} =                    Run             echo ${pozdrav}
    #Log To Console                  ${results}
    #Should Not Be Equal             ${results}      bleble
    Spusteni-                        echo ${pozdrav}    bleble

4 -negativni kontrola2
   #${results} =                     Run             help
   #Log To Console                   ${results}
   #Should Not Be Equal              ${results}      Roman a Scifi
   Spusteni-                         help           Roman a Scifii

*** Keywords ***
Spusteni+
    [Arguments]                     ${prikaz}  ${vysledek}
    ${res}                          Run        ${prikaz}
    Log To Console                  ${res}
    Should Be String                ${res}     ${vysledek}

Spusteni-
    [Arguments]                     ${prikaz}  ${vysledek}
    ${res}                          Run        ${prikaz}
    Log To Console                  ${res}
    Should Not Be Equal             ${res}     ${vysledek}