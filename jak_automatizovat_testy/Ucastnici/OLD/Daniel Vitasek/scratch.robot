*** Settings ***
Library     OperatingSystem
Library     Browser
Library     RequestsLibrary
Resource    ../../OLD/David Karpiel/DÚ-03/projekt.robot
Resource    ../../OLD/Vojtech Vaculik/API.robot

*** Variables ***
${POZDRAV}  Dobry den
${CISLO}    28


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    Log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.


Druhy test negativni
    ${res} =        run     help ahoj
    Log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.

Treti test
    Log To Console    Cau
    ${POZDRAV} =    Set Variable    Ahoj
    Log To Console    ${POZDRAV}
    ${X} =          Set Variable    10
    Should Be Equal    ${X}    10
    Should Be Equal As Integers    ${X}    10
    Should Be Equal As Strings    ${POZDRAV}    Ahoj
    
Ctvrty test
    @{LIST}         Create List     28  22  7  13  8
    Log Many        @{LIST}
    Log To Console    ${LIST}[0]

Paty test
    &{DICT}         Create Dictionary       login=dvitasek    heslo=123456
    Log Many        &{DICT}
    Log To Console  ${DICT}
    Log To Console  ${DICT.login}

Sesty test
    &{DICT}         Create Dictionary       login=dvitasek    heslo=123456
    Log Many        &{DICT}
    Log To Console  ${DICT}
    Log To Console  ${DICT.login}

Sedmy test
    New Browser     chromium    headless=false
    New Context     viewport={'width': 1920, 'height': 1080}
    New Page        https://escapefromtarkov.fandom.com/wiki/Escape_from_Tarkov_Wiki
    Get Title       ==  The Official Escape from Tarkov Wiki

Osmy test
    New Browser     chromium    headless=false
    New Page        http://testovani.kitner.cz/courses

    Get Title       *=      Testování
    Get Title       !=      Ahoj

#<a data-testid="login_link" data-test="login_link" class="_link_beyef_13" href="/login">Přihlásit se</a>
    Click           text=Přihlásit se
    Type Text       xpath=//*[@id="email_input"]    Tondo
    Type Text       css=.input_box                  css
    Type Text       id=email_input                  Ahoj
    Type Text       css=[moje_id=email_input]       aaaa
    Take Screenshot
    Type Text       data-test=email_input           user@email.cz


Testovani pozdravu
    Pozdrav
    Pozdrav2        kocko

Testovani vypoctu
    ${output}         Vypocet    2    14
    Log To Console    ${output}

Quick Get Request Test
    ${response}=    GET    https://www.google.com

Quick Get Request With Parameters Test
    ${response}=    GET    https://www.google.com/search    params=query=ciao   expected_status=200

Quick Get A JSON Body Test
    ${response}=    GET    https://www.jsonplaceholder.typicode.com/posts/1
    Should Be Equal As Strings    1  ${response.json()}[id]
    Log To Console    >>>>>${response}<<<<<
    Log To Console    >>>>>${response.ok}<<<<<
    Log To Console    >>>>>${response.headers}<<<<<
    Log To Console    >>>>>${response.reason}<<<<<
    Log To Console    >>>>>${response.status_code}<<<<<
    Log To Console    >>>>>${response.json()}[title]<<<<<


*** Keywords ***
Pozdrav
    Log To Console  Dobry den

Pozdrav2
    [Arguments]     ${name}
    Log To Console  Cau ${name}

    # spusteni z prikazove radky:
    #   robot --variable name:Daniel .\Ucastnici\Aktualni\scratch.robot

Vypocet
    [Arguments]     ${x}  ${y}
    Log             x=${x} y=${y}
    ${output}       Evaluate       ${x} * ${y}
    RETURN        ${output}


