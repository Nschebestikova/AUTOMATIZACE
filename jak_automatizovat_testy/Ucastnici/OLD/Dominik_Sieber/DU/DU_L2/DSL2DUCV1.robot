*** Settings ***
Library  OperatingSystem
Library  String

*** Variables ***
${path}         C:\\Users\\Užívatel\\PycharmProjects\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Dominik_Sieber\\DU\\DU_L1
${dir}          dir
${dirHelp}      dir /?
${file}         DSL1DU.robot
${text}         Uses bare format (no heading information or summary).
*** Test Cases ***
L1CV31
    ${cmd1} =               Run             command=cd ${path} && ${dir}
    # problém asi s tím, že čekuju jiný Folder, než ze kteroho se spouští tento test, ale ani S ChatGPT se nepodařilo vyřešit....
    Log                     ${cmd1}
    Log                     ${path}
    Log                     ${dir}
    Log                     ${file}

    Should Contain          ${cmd1}         ${file}

L1CV32
    ${cmd3} =          Run         command=${dirHelp}
    Log               ${cmd3}
    Log               ${dirHelp}
    Log               ${text}

    Should Contain    ${cmd3}      ${text}