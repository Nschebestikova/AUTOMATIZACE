*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Possitive Test list first
   ${output} =          Run          ls ~
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    Desktop

Possitive Test list second
   ${output} =          Run          ls -l ~
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}   drwxrwxr-x 5 michaela michaela 4096 srp 26 14:18 git

Negative Test list first
   ${output} =          Run          ls l ~
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    ls: cannot access 'l': No such file or directory

Negative Test list second
   ${output} =          Run          ls long ~
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}    ls: cannot access 'long': No such file or directory
