*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Muj prvni test
  log  Ahoj

pozitivni test
    ${res} =  run  help dir

    Should Contain    ${res}    Displays a list of files and subdirectories in a directory.

druhý pozitivní test
    ${res} =  run  help type

    Should Contain    ${res}    Displays the contents of a text file or files.

negativni test
    ${res} =  run  help chacha

    Should Contain    ${res}    This command is not supported by the help utility.

druhý negativni test
    ${res} =  run  help ls

    Should Contain    ${res}    This command is not supported by the help utility.
