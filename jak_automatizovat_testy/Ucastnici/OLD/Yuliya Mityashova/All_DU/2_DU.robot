*** Settings ***
Library         OperatingSystem

*** Variables ***
${output.text_1}    python --version
${output.text_2}    dir c:\prvni.robot
${output.text_3}    dir c:\neznamy_adresar
@{seznam_prohlizecu}   Chrome  Edge  Opera  Mozilla  Safari
${python_ver} =     Python 3.10.9

*** Test Cases ***
1 poztivni test
    ${res}=    Run   ${output.text_1}
    Should Contain    ${res}     Python
    Log  ${output.text_1}

2 poztivni test
    ${res}=    Run    ${output.text_2}
    Should Contain    ${res}    prvni.robot
    Log   ${output.text_2}

1 negativni test
    ${res}=    Run   ls123
    Should Contain    ${res}    is not recognized

2 negativni test
    ${res}=    Run   ${output.text_3}
    Should Not Contain    ${res}   neznamy_adresar
    Log  ${output.text_3}

Test cv_24_1
    Log Many   ${seznam_prohlizecu}

Test cv_24_2
    Log To Console    ${seznam_prohlizecu}[3]

Test cv_24_3
     Log To Console    ${seznam_prohlizecu}[0]
     ${0.polozka}=  Set Variable  Chrome
     Should Contain   ${seznam_prohlizecu}[0]   ${0.polozka}

*** Keywords ***
Verze Pythonu
    ${akt_python}=   Run    python --version
    Log To Console    ${akt_python}
    Should Contain    ${akt_python}  ${python_ver}