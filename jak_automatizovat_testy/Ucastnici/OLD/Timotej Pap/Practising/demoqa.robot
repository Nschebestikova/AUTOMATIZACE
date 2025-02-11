*** Settings ***
Library     Browser
Library     SeleniumLibrary

*** Variables ***
${URL}              https://demoqa.com/automation-practice-form
${first}            Timotej
${last}             Pap
${email}            paptimotej@gmail.com


*** Test Cases ***

Text Box
    Set Strict Mode    off

    Server Text Box
#    Element Should Be Visible    id=firstName
    Input box               ${first}    ${last}    ${email}

Select
    Server Select
    Click    css=#oldSelectMenu
    Click    css=

*** Keywords ***
Server Text Box
    New Browser             chromium       headless=false  # zobrazi GUI
    New Page                ${URL}
    Browser.Get Title       contains       DEMOQA


Input box
    [Arguments]             ${first}       ${last}      ${email}
#    Type Text               id=firstName    ${first}
    Type Text               css=#firstName        ${first}
    Type Text               css=input#lastName    ${last}
    Type Text               id=userEmail          ${email}

Server Select
    New Browser             chromium       headless=false  # zobrazi GUI
    New Page                https://demoqa.com/select-menu
    Browser.Get Title       contains       DEMOQA