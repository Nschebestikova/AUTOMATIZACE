*** Settings ***
Library  FakerLibrary   # potřebuje: pip install robotframework-faker

*** Test Cases ***
FakerLibrary Words Generation
    ${email}=    FakerLibrary.Email
    Log To Console    DATA: ${email}
    ${name}=    FakerLibrary.Name
    Log To Console    DATA: ${name}
    ${pn}=    FakerLibrary.Phone Number
    Log To Console    DATA: ${pn}
    ${words}=    FakerLibrary.Words    nb=${10}
    Log To Console    DATA: ${words}