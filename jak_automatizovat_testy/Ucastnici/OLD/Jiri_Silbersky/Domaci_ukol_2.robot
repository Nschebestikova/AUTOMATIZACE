*** Settings ***
Library    Process
Library    OperatingSystem

*** Variables ***
${valid_email}    jsilbersky@gmail.com
${invalid_email}  invalid_email
${email_command}  echo ${valid_email}

*** Test Cases ***
# Pozitivní testy
Test Valid Email 1
    Log    Test case: Valid Email Test
    ${result}    Run Process    ${email_command}    shell=True
    Log    Command output: ${result.stdout}
    Should Contain    ${result.stdout}    ${valid_email}

Test Another Valid Email 2
    Log    Test case: Another Valid Email Test
    ${result}    Run Process    ${email_command}    shell=True
    Log    Command output: ${result.stdout}
    Should Contain    ${result.stdout}    ${valid_email}

# Negativní testy
Test Invalid Email 1
    Log    Test case: Invalid Email Test
    ${result}    Run Process    ${email_command}    shell=True
    Log    Command output: ${result.stdout}
    Should Contain    ${result.stdout}    ${invalid_email}

Test Another Invalid Email 2
    Log    Test case: Another Invalid Email Test
    ${result}    Run Process    ${email_command}    shell=True
    Log    Command output: ${result.stdout}
    Should Contain    ${result.stdout}    ${invalid_email}

*** Keywords ***
Verify Email Command Output
    [Arguments]    ${email_command}    ${expected_output}
    ${result}    Run Process    ${email_command}    shell=True
    Should Contain    ${result.stdout}    ${expected_output}