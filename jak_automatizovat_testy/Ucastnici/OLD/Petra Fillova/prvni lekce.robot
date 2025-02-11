*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Test na prikaz help - pozitivni
   ${results} =     Run             help cd
   Log To Console   '${results}'
   Should Contain   ${results}      Displays the name of or changes the current directory


Test na prikaz help - negativni
   ${results} =     Run             help fsdfasdfasd
   Log To Console   '${results}'
   Should Contain   ${results}      This command is not supported by the help utility
