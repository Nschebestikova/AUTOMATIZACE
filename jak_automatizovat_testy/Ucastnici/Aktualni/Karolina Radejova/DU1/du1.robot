*** Settings ***
Library    OperatingSystem
***Test Cases ***

Positive - folder contains file after ls command in terminal
  ${output} =       Run          ls ~/jak_automatizovat_testy
  Log               ${output}
  Should Contain    ${output}    prvni.robot

Positive - pwd command writes the path in terminal
  ${output} =       Run           pwd
  Log               ${output}
  Should Contain    ${output}    /jak_automatizovat_testy

Negative - ls command does not found the directory
  ${output} =        Run    ls ~/jak_automatizovat_testy_abc
  Log                ${output}
  Should Contain     ${output}    No such file or directory

Negative - typo in command pwd
  ${output} =        Run    pwad
  Log To Console     ${output}
  Should Contain     ${output}    command not found