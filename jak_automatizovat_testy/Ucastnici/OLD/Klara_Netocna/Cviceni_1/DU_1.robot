*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Prvni pozitivni test
    ${output} =          Run         help
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}    Displays or modifies file extension associations.
     
Druhy pozitivni test
    ${output} =          Run         dir
    Log To Console       ${output}
    Log                  ${output}
    
    Should Contain       ${output}   Volume in drive C is Windows
    
Prvni negativni test
    ${output} =          Run          help 123abc
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}    Try "123abc /?".

Druhy negativni test
   ${output} =          Run           dir 333
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}     File Not Found
