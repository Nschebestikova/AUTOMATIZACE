
*** Settings ***
Library  OperatingSystem


*** Test Cases ***
Muj treti test
    ${res} =  run  help aaa

    Should Contain    ${res} This command is not supported by the help utility.