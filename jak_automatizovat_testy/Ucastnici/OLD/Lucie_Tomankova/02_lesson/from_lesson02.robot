#Trénování proměnných z 02_sesson
*** Settings ***
Library    Collections
Library    OperatingSystem


*** Variables ***
${greet}    Ahoj
${name}     Lucie
${y}        20


*** Test Cases ***
Prvni test s promennou - funguje ok
    ${greet} =  Set Variable     Hi
    Log To Console    ${greet}
    Log To Console    ${name}
    Log To Console    ${y}
    Should Be Equal   ${y}      20
    End
    Beginning
    Regards     Karle
     ${finalPlus}=   Sum     40   40
        Log To Console    ${finalPlus}


Prace se seznamy
    @{list} =     Create List         prvni  druhy  treti  donekonecna
    Log To Console    ${list}[2]
    Log To Console    ${list}[0]
    Log Many        ${list}
    Regards    Jano


Example Test - funguje ok, se zavinacem, i bez, coz je zarazejici..?
    # Create a list of strings
    [Documentation]        Zde jsem záměrně použila dollar symbol namísto zavináče (i když vím, že pro seznam se používá zavináč). To nechápu, vždyt $ symbol bere argumenty jako single value, tak jak to, že je pak dokáže odseparovat?
    ${my_list}=    Create List    apples    bananas    oranges

    # Create a list of integers
    ${my_numbers}=    Create List    1    2    3    4    5

    # Create an empty list
    ${empty_list}=    Create List

    # Append values to the empty list
    Append To List     ${empty_list}    42
    Append To List     ${empty_list}    99

    # Print the lists
    Log To Console    ${my_list}[0]
    Log To Console    ${my_numbers}[4]
    Log To Console    ${empty_list}[1]


Práce se slovníky
    &{slovnik} =     Create Dictionary      čokoláda, ale jenom hořká=40  2=banánů, to je dost  šlehačka=raději ne
    Log To Console      ${slovnik}[čokoláda, ale jenom hořká]
    Log To Console      ${slovnik}[2]
    Log Many    &{slovnik}


*** Keywords ***
End
    Log To Console    This is the end of the beginning.


Beginning
    Log To Console    This is the beginning of the end.


Regards
    [Arguments]    ${name}
    Log To Console    Dobrý den ${name}


Sum
    [Arguments]     ${x}     ${y}
    ${plus} =  Evaluate    ${x} + ${y}
    ${oneString}=    Set Variable    Výsledek sečtení je ${plus}.
    [Return]    ${oneString}



