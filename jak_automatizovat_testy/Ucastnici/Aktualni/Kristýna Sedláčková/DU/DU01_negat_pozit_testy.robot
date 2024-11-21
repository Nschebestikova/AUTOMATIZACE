*** Settings ***
Library     OperatingSystem
*** Test Cases ***

Prvni test pozitivni
    ${res} =        run     help color
    log             ${res}
    Should Contain  ${res}    Sets the default console foreground and background colors.
    
Druhy test pozitivni 
    ${res} =          Run    help
    log               ${res}
    Should Contain    ${res}    For more information on tools see the command-line reference in the online help.
    
    
Prvni test negativni 
    ${res} =          Run    ahoj
    log               ${res}
    Should Contain    ${res}    'ahoj' is not recognized as an internal or external command,\noperable program or batch file.
#tady jsem musela přidat do textu newline \n, aby to odpovídalo stejnému vypsání jako je v cmd

Druhy test negativni 
    ${res} =          Run    dir aaaa
    log               ${res}
    Should Contain    ${res}    File Not Found