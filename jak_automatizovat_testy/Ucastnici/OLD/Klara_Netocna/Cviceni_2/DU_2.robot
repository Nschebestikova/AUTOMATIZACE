*** Settings ***
Library  OperatingSystem
Library  Browser

*** Variables ***
${promenna_text1}      Displays or modifies file extension associations.
${promenna_text2}      Volume in drive C is Windows
${promenna_text3}      Try "123abc /?".
${promenna_text4}      File Not Found


*** Test Cases ***

Prvni pozitivni test
    ${output} =          Run         help
    Log                  ${output}

    Should Contain       ${output}    ${promenna_text1}
    Log                  ${promenna_text1}

Druhy pozitivni test
    ${output} =          Run         dir
    Log                  ${output}

    Should Contain       ${output}   ${promenna_text2}
    Log                  ${promenna_text2}

Prvni negativni test
    ${output} =          Run          help 123abc
    Log To Console       ${output}
    Log                  ${output}

    Should Contain       ${output}    ${promenna_text3}
    Log                  ${promenna_text3}

Druhy negativni test
   ${output} =          Run           dir 333
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}     ${promenna_text4}
   Log                  ${promenna_text4}

*** Keywords ***

Open Login Page
    Open Browser         http://testovani.kitner.cz/login_app/