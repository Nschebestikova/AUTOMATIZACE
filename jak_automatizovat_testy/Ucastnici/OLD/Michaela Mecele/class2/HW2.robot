*** Settings ***

Library  OperatingSystem

*** Test Cases ***

Possitive Test list first
   ${output} =          command    ls ~    git

Possitive Test list second
   ${output} =          command    ls -l ~    git

Negative Test list first
   ${output} =          command    ls l ~    ls: cannot access

Negative Test list second
   ${output} =          command    ls long ~    ls: cannot access

*** Keywords ***

command
    [Documentation]     Keyword for possitive tests for list
    [Arguments]             ${input}    ${outputxt}
    ${output} =     Run     ${input}
    Log To Console          ${output}
    Log                     ${output}
    Should Contain          ${output}   ${outputxt}
    [Return]                ${output}
