*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Possitive Test
   ${output} =          Run          man
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    What manual page do you want?

Negative Test
   ${output} =          Run          man pokus
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    No manual entry for pokus
