*** Settings ***
Library    OperatingSystem
*** Test Cases ***

Positive_command_test_echo
    Run    echo Try to do some reasonable test > ${CURDIR}\adri_file_1.txt
    ${output}=  run     type ${CURDIR}desktop\adri_file_1.txt
    log     ${output}
    Should Contain    ${output}    Try to do some reasonable test


Negative_command_test_echo
    Run    echo Try to do some reasonable test > ${CURDIR}\adri_file_1.txt
    ${output}=  run     type ${CURDIR}desktop\adri_file_1.txt
    log     ${output}
    Should Contain    ${output}    Nothing to see here

Positive_command_test_ping
    ${output}=  run     ping 1.1.1.1
    log             ${output}
    Should Contain     ${output}    Pinging 1.1.1.1 with 32 bytes of data:

Negative_command_test_ping
    ${output}=  run     ping 1.1.1.1
    log             ${output}
    Should Contain     ${output}    Running command