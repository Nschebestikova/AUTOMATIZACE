*** Settings ***
Library    OperatingSystem

*** Variables ***
${part_of_path}         jak_automatizovat_testy
${wrong_part_of_path}   jak_automatizovat_testy_abc
${cd_command}           cd ~/${part_of_path}
${control_file}         prvni.robot
${ls_command}           ls ~/${part_of_path}

*** Keywords ***
SetDirectory
    ${command} =    Run    ${cd_command}
    Log             the directory is set

***Test Cases ***
Positive - folder contains file after ls command in terminal
  SetDirectory
  ${ls} =           Run       ${ls_command}
  Log               ${ls_command} was done, content of file is displayed
  Should Contain    ${ls}     ${control_file}
  Log               File contains ${control_file}

Positive - pwd command writes the path in terminal
  SetDirectory
  ${pwd_command} =       Run           pwd
  Log               Pwd command was done, ${pwd_command} is displayed
  Should Contain    ${pwd_command}    /${part_of_path}
  Log               The displayed path contains /${part_of_path}

Negative - ls command does not found the directory
  SetDirectory
  ${output} =        Run          ls ~/${wrong_part_of_path}
  Log                ${output}
  Should Contain     ${output}    No such file or directory
  Log                File or directory does not exists

Negative - typo in command pwd
  SetDirectory
  ${pwd_command_typo} =        Run          pwad
  Log                ${pwd_command_typo} was done
  Should Contain     ${pwd_command_typo}    command not found
  Log                command pwad was not found