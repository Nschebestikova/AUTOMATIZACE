
*** Test Cases ***
# POZOR: při používání zpětných lomítek je nutné v ROBOTU vždy použít 2 aby se zrušil speciální význam zpětného lomítka, viz návod
Email Format Verification bad 1
    ${user_email}=    Set Variable    user@exampleaaaa
    Should Match Regexp    ${user_email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$    Email format is incorrect

Email Format Verification bad 2
    ${user_email}=    Set Variable    ahoj@test
    Should Match Regexp    ${user_email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$    Email format is incorrect

Email Format Verification correct
    ${user_email}=    Set Variable    ahoj@aba.aaaaa
    Should Match Regexp    ${user_email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$    Email format is incorrect



