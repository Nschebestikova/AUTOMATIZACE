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

    ${first_name} =   FakerLibrary.First Name
    Log To Console    DATA: ${first_name}

    ${last_name} =    FakerLibrary.Last Name
    Log To Console    DATA: ${last_name}

    ${email}=    FakerLibrary.Email
    Log To Console    DATA: ${email}

    ${address} =    FakerLibrary.Address
    Log To Console    DATA: ${address}

    ${count} =      FakerLibrary.Random Digit
    Log To Console    DATA: ${count}

    ${comment} =    FakerLibrary.Sentence
    Log To Console    DATA: ${comment}
    
    ${json} =   FakerLibrary.Json
    Log To Console    DATA: ${json}




