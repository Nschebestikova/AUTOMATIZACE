*** Settings ***
Library  OperatingSystem

*** Variables ***
${MSWindows} =     Microsoft Windows [Version 10.0.19045.2728]
${py_ver} =     Python 3.11.3
${label_neg} =      VOLl' is not recognized as an internal or external command
${notebook} =        HOST_NAME' is not recognized as an internal or external command

*** Test Cases ***

Prvni test pozitivni
    ${MSversion}=     Run    ver
    Log To Console      ${MSversion}
    Should Contain      ${MSversion}  ${MSWindows}
    Log    Test na ver: ${MSWindows}

Druhy test pozitivni
    Aktualni verze pythonu
    Log    Test na python --version: ${py_ver}

Treti test negativni
    ${label}=   Run    VOLl
    Log To Console    ${label}
    Should Contain    ${label}  ${label_neg}
    Log    Negat test na VOL: ${label_neg}

Ctvrty test negativni
    ${ntbname}=     Run    HOST_NAME
    Log To Console    ${ntbname}
    Should Contain    ${ntbname}  ${notebook}
    Log    Negat test na HOST_NAME: ${notebook}

*** Keywords ***
Aktualni verze pythonu
    ${aktualni_python}=   Run    python --version
    Log To Console    ${aktualni_python}
    Should Contain    ${aktualni_python}  ${py_ver}