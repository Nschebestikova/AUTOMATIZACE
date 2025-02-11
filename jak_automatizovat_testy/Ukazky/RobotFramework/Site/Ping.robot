robotframework
Copy code
*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Ping Test
    ${result}=    Run And Return Rc And Output    ping 1.1.1.1
    Log    ${result}
    Should Be Equal As Integers    ${result[0]}    0    msg=Ping failed