*** Settings ***
Library     OperatingSystem
Library     Process

*** Test Cases ***

Muj Prvni Test
    Log To Console  Ahoj

Druhy Test
    Log To Console  Ahoj


Treti Test
   ${output} =          Run         help
   Log To Console       ${output}
   Log                  ${output}



Ctvrty Test
   ${output} =          Run         help
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    For more information on a specific command, type HELP command-name

Paty Test
    ${output} =       Run          help dir
    Log To Console    ${output}
    Log               ${output}

    Should Contain    ${output}    [/N]

Sesty Test
    ${output} =       Run          help abcs
    Log To Console    ${output}
    Log               ${output}

    Should Contain    ${output}    This command is not supported by the help utility