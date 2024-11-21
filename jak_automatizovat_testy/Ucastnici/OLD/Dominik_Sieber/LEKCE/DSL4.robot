*** Variables ***
${zvire}        slon

*** Test Cases ***
Podminky
#hlásí chybu, že "==" keyoword not found
    IF    "${zvire}" == "slon"
         Log To Console    Je to slon
    ELSE
         Log To Console    není to slon
    END

Cykly
    FOR    ${counter}    IN RANGE    1    10    2
        Log    ${counter}

    END

