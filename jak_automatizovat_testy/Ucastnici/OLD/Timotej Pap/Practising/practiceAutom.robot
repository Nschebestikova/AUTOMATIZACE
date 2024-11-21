*** Settings ***
Library     Browser
Library     SeleniumLibrary

*** Variables ***
${URL}              https://practicetestautomation.com/practice-test-login/
${USER}             student
${BAD_USER}         ucitel
${PASSWORD}         Password123
${BAD_PASS}         Password1234



*** Test Cases ***
#  practiseautomatisation.com - Positive test
Positive test
    Server
    Type Text    id=username    ${USER}
    Type Text    id=password    ${PASSWORD}
    Click        id=submit
    Get Url      ==             https://practicetestautomation.com/logged-in-successfully/
    Sleep        2
    Browser.Get Title           contains       Logged
    Sleep        2
    Browser.Get Text            xpath=//strong[contains(text(),'Congratulations student. You successfully logged i')]        contains    Congratulations
    Browser.Get Text            text="Log out"

#  practiseautomatisation.com - Negative username test
Negative test-user
    Server
    Type Text    id=username    ${BAD_USER}
    Type Text    id=password    ${PASSWORD}
    Click        id=submit
    Sleep        2
    Browser.Get Text        id=error
    Page Should Contain     Your username is invalid!

#  practiseautomatisation.com - Negative password test
Negative test-password
    Server
    Type Text    id=username    ${USER}
    Type Text    id=password    ${BAD_PASS}
    Click        id=submit
    Sleep        2
    Browser.Get Text            id=error
    Page Should Contain         Your password is invalid!

*** Keywords ***
Server
    New Browser             chromium       headless=false  # zobrazi GUI
    New Page                ${URL}
    Browser.Get Title       contains       Test Login