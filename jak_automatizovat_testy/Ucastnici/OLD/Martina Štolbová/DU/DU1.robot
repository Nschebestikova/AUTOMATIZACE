*** Settings ***
Library     OperatingSystem
Library    Process

*** Test Cases ***

Prvni pozitivni test
    ${output} =          Run         ver
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}    Microsoft Windows [Version 10.0.22621.2715]

Druhy pozitivni test
    ${output} =          Run         dir
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}   Setup

Prvni negativni test
    ${output} =          Run         bla
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}    'bla' is not recognized as an internal or external command,

Druhy negativni test
   ${output} =          Run           cd 'cd neexistuji_adresar'
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}     Syst‚m nem…§e nal‚zt uvedenou cestu