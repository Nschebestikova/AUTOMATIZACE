*** Settings ***
Library     OperatingSystem

#CVIČENÍ č.1 a č.2:

*** Variables ***
${help xcopy}       Copies files and directory trees.
${ping}             Reply from
${ipconfik}         'ipconfik' is not recognized as an internal or external command
${badcd}            The system cannot find the path specified.

*** Test Cases ***
První pozitivní test

    ${res}          Run         help xcopy
    log             ${res}
    Should Contain  ${res}      ${help xcopy}

Druhý pozitivní test

    ${res}          Run         ping www.google.com
    log             ${res}
    Should Contain  ${res}      ${ping}

První negativní test
    ${res}            Run       ipconfik
    log               ${res}
    Should Contain    ${res}    ${ipconfik}

Druhý negativní test
    ${res}            Run       cd ./soubor/
    log               ${res}
    Should Contain    ${res}    ${badcd}

#CVIČENÍ č.4:
*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
   Get Title      ==    Browser