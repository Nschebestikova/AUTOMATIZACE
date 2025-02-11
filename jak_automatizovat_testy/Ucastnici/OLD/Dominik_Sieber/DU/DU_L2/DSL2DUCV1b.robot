*** Settings ***
Library  OperatingSystem
Library  String

*** Variables ***
${path}         C:\Dominik
${dir}          dir
${res1}         Volume in drive C has no label.
${res2}         File Not Found

*** Test Cases ***
Cvic4.1
    ${cmd1} =          Run         command=${dir} ${path}
    Log               ${cmd1}
    Log               ${dir}
    Log               ${path}
    Log               ${res1}
    Log To Console    ${cmd1}

    Should Contain    ${cmd1}      ${res1}

Cvic4.2
    ${cmd2} =          Run         command=${dir} ${path}
    Log               ${cmd2}
    Log               ${path}
    Log               ${res2}
    Log To Console    ${cmd2}

    Should Contain    ${cmd2}      ${res2}