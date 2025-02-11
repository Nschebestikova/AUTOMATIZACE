*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Prvni test pozitivni
    ${MSWindows}=     Run    ver
    Log To Console      ${MSWindows}
    Should Contain      ${MSWindows}      Microsoft Windows [Version 10.0.19045.2728]

Druhy test pozitivni
    ${pythonversion}=   Run    python --version
    Log To Console    ${pythonversion}
    Should Contain    ${pythonversion}      Python 3.11.3

Treti test negativni
    ${label}=   Run    VOL
    Log To Console    ${label}
    Should Contain    ${label}      JustSomeRandomName

Ctvrty test negativni
    ${ntbname}=     Run    HOSTNAME
    Log To Console    ${ntbname}
    Should Contain    ${ntbname}    DenisaNTB