# Dominik Sieber Lekce 1
*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Prvni Test
   ${output} =          Run         help
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}   For more information on a specific command, type HELP command-name

# Test na overeni, ze funkce DIR obsahuje Specifies drive, directory, and/or files to list.
Druhy Test
   ${output} =          Run         help dir
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}   Specifies drive, directory, and/or files to list.

# Test na overeni, ze funkce |tohlejespatne| neexistuje a obsahuje This command is not supported by the help utility.
Treti Test
   ${output} =          Run         help tohlejespatne
   Log To Console       ${output}
   Log                  ${output}

   Should Contain       ${output}   This command is not supported by the help utility.