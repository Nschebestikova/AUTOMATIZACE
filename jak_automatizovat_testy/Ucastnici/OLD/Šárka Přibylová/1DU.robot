*** Settings ***
Library    OperatingSystem
Resource    ../Ucastnici/OLD/JiriTuma/ukoly/old/ukol02.robot
*** Test Cases ***

Prvni Test Pozitivni
    ${output} =         Run     replace
    Log to console      ${output}
    Log                 ${output}
    Should contain      ${output}       Source path

Druhy Test Pozitivni
    ${output} =         Run     vol
    Log to console      ${output}
    Log                 ${output}
    Should contain      ${output}       Volume

Prvni test negativni
    ${output} =         Run     sarka
    Log to console      ${output}
    Log                 ${output}
    Should contain      ${output}       is not recognized

Druhy test negativni
    ${output} =         Run     negativ
    Log to console      ${output}
    Log                 ${output}
    Should contain      ${output}       is not recognized













#*** Settings ***
#Library    String
#Library    Browser
#
#*** Variables ***
#${x}    10
#
#*** Test Cases ***
#
#Prvni test
#
#    #ověření build-in KS
#    Log               Ahoj
#    Should Contain    Ahoj    ho
#    Should Be True    10 > 1
#
#    #ověření KS z jiné knihovny, která je ale součástí RBFW
#    ${str2} =	Convert To Lower Case	1A2c3D
#
#
##ověření KS z jiné knihovny, která je dodatečně instalovaná
#Starting a browser with a page
#   New Browser    chromium    headless=false
#   New Page       https://www.rohlik.cz
#   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#
#   Type Text    id=searchGlobal     Ahoj

















#*** Test Cases ***
#
#Prvni test
#    Log  Ahoj






























#    Should Be Equal   ahoj              ahoj
#    Should Contain    ahoj dobrý den    ahoj
#    Should Be True    ${x}  < 100































#*** Settings ***
#Library           OperatingSystem
#
#
#*** Test Cases ***
#
#Prvni test
#    ${result} =      run            help
#    Log             ${result}
#    Should Contain  ${result}       For more information on a specific command, type HELP command-name
#
#Druhy test
#    ${result} =      run            TASKLIST
#    Should Contain   ${result}      Calculator.exe

