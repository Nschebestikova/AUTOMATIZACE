** Settings ***
Library     OperatingSystem
Library     String


*** Test Cases ***
1.3.1 ukol
    ${command1} =       Run             help cd
    Log To Console      ${command1}
    Log                 ${command1}
    Should Contain      ${command1}     Type CD drive: to display the current directory in the specified drive.

1.3.2 ukol
    ${command2} =       Run             help mkdir
    Log To Console      ${command2}
    Log                 ${command2}
    Should Contain      ${command2}     If Command Extensions are enabled MKDIR changes as follows:

1.4.1 ukol
    ${command3}         Run             cd C:\no_name
    Log To Console      ${command3}
    Log                 ${command3}
    Should Contain      ${command3}    File Not Found

1.4.2 ukol
    ${command4}         Run             dir C:\no_name
    Log To Console      ${command4}
    Log                 ${command4}
    Should Contain      ${command4}    File Not Found