*** Settings ***
Library  OperatingSystem


*** Variables ***
${FOLDER_CHECK}         ls /Users/veronikamalikova/PycharmProjects
${CURRENT_PATH}         pwd
${CURRENT_FOLDER}       jak_automatizovat_testy
${NEGATIVE_OUTPUT}      No such file or directory


*** Test Cases ***
Vypsání proměnných do logu
    Log                 ${FOLDER_CHECK}
    Log                 ${CURRENT_PATH}
    Log                 ${CURRENT_FOLDER}
    Log                 ${NEGATIVE_OUTPUT}

Tester
    Vypis    Verča

#Pozitivní test cases
První pozitivní test
    ${output} =         Run             ${FOLDER_CHECK}
    Log To Console      ${output}
    Log                 ${output}
    Should Contain      ${output}       ${CURRENT_FOLDER}

Druhý pozitivní test
    ${output} =         Run             ${CURRENT_PATH}
    Log To Console      ${output}
    Log                 ${output}
    Should Contain      ${output}       ${CURRENT_FOLDER}

#Negativní test cases
První negativní test
    ${output} =         Run             ls /Users/veronikamalikova/Pycharm
    Log To Console      ${output}
    Log                 ${output}
    Should Contain      ${output}       ${NEGATIVE_OUTPUT}

Druhý negativní test
    ${output} =         Run             ls -l /Users/veronikamalikova/Pycharm
    Log To Console      ${output}
    Log                 ${output}
    Should Contain      ${output}       ${NEGATIVE_OUTPUT}


*** Keywords ***
Vypis
    [Arguments]         ${jmeno}
    Log to console      Tohle testuje: ${jmeno}
    Log                 ${jmeno}