# Cvičení č.1: Zvolte si doménu (weby, webové aplikace, mobilní aplikace, sítě, databáze...)
# youtube.com

# Cvičení č.2: Zvolte si nástroj (RobotFW, Cypress.io, Selenium...)
# RobotFW

# Cvičení č.3: vytvořit 2 pozitivní automatické testy na příkazovou řádku
#

#** Settings ***
#Library  OperatingSystem
#Library  String
#
#*** Test Cases ***
#Cvic3.1
#    ${cmd1} =          Run         command=cd C:/Users/Užívatel/PycharmProjects/pythonProject1
#    ${cmd1} =          Run         command=dir
#    Log               ${cmd1}
#    Log To Console    ${cmd1}
#
#    Should Contain    ${cmd1}      prvni.robot
#
#Cvic3.2
#    ${cmd2} =          Run         command=dir /?
#    Log               ${cmd2}
#    Log To Console    ${cmd2}
#
#    Should Contain    ${cmd2}      /B          Uses bare format (no heading information or summary).

# Cvičení č.4: vytvořit 2 negativní automatické testy  na příkazovou řádku
#

#** Settings ***
#Library  OperatingSystem
#Library  String
#
#*** Test Cases ***
#Cvic4.1
#    ${cmd1} =          Run         command=dir C:\Dominik
#    Log               ${cmd1}
#    Log To Console    ${cmd1}
#
#    Should Contain    ${cmd1}      Volume in drive C has no label.
#
#Cvic4.2
#    ${cmd2} =          Run         command=dir C:\Dominik
#    Log               ${cmd2}
#    Log To Console    ${cmd2}
#
#    Should Contain    ${cmd2}      File Not Found

