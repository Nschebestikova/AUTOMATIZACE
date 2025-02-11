
*** Settings ***
Library           String

*** Test Cases ***
Email Format Verification
    ${user_email}=    Set Variable    user@example.comd
    Should Match Regexp    ${user_email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{1,3}$    Email format is incorrect

