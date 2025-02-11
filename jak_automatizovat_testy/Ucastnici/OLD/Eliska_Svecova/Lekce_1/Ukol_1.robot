*** Settings ***
Library    OperatingSystem
Library    String

*** Test Cases ***
1 -pozitivní kontrola1
    ${results} =                    Run             echo ahoj
    Log To Console                  ${results}
    Should Be String                ${results}      ahoj

2 -pozitivni kontrola2
    ${results} =                    Run             help
    Log To Console                  ${results}
    Should Contain                  ${results}      For more information

3 -negatinvi kontrola1
    ${results} =                    Run             echo Ahoj
    Log To Console                  ${results}
    Should Not Be Equal             ${results}      bleble

4 -negativni kontrola2
   ${results} =                     Run             help
   Log To Console                   ${results}
   Should Not Be Equal              ${results}      Roman a Scifi