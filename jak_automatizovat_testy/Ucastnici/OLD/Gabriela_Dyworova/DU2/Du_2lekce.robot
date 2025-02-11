*** Settings ***
Library  OperatingSystem

*** Variables ***
${output_text1}     Displays a list of files and subdirectories in a directory.
${output_text2}     This command is not supported by the help utility.
    #ze cvičení 24: vytvořte seznam obsahující názvy prohlížečů
@{seznam_prohlizecu}     Chrome   Mozilla   Opera   Safari    Google

*** Keywords ***
Zachrana
    Log To Console    Zachranim te

*** Test Cases ***
Muj prvni pozitivni test
    ${res} =  run  help
    Should contain   ${res}   ${output_text1}
    Log  ${output_text1}
    # funkční

Muj druhy pozitivni test
    ${res} =  run  help dir
    Should contain   ${res}   ${output_text1}
    ${rescue} =  Set Variable  ok
    Log to Console  ${rescue}
    # funkční

Muj prvni negativni test
    ${res} =  run  help XXX
    Should contain   ${res}   ${output_text2}
    Log  ${output_text2}
    # funkční

Muj druhy negativni test
    ${res} =  run  help dirrr
    Should contain   ${res}   ${output_text2}
    # funkční

# Testy ze cvičení 24
Test pro vypsani vsech polozek seznamu do logu
    Log Many   @{seznam_prohlizecu}
    # funkční

Test pro vypsani jedne polozky ze seznamu
    Log To Console  ${seznam_prohlizecu}[2]
    # funkční

Test pro overení že 0 položka seznamu obsahuje Chrome
    Log To Console  ${seznam_prohlizecu}[0]
    Should Be Equal  ${seznam_prohlizecu}[0]   Chrome
    # nefunkční