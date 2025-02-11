*** Settings ***
Library           OperatingSystem
Library           Process

*** Variables ***
${INTERFACE}      eth0  # Nastavte na název rozhraní, které chcete sledovat
${CAPTURE_FILE}   capture.pcap
${DURATION}       10  # Doba trvání zachytávání v sekundách

*** Test Cases ***
Zachytit Pakety
    [Setup]    Spustit Zachytávání
    Sleep    ${DURATION} s
    [Teardown]    Zastavit Zachytávání

*** Keywords ***
Spustit Zachytávání
    Start Process    tshark -i ${INTERFACE} -w ${CAPTURE_FILE}    alias=tshark

Zastavit Zachytávání
    Terminate Process    tshark    kill=True
    ${output}=    Get File    ${CAPTURE_FILE}
    [Return]    ${output}