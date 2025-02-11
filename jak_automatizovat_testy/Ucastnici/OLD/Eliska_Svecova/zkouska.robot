#*** Settings ***
#Library  Browser

#*** Test Cases ***
#Starting a browser with a page
#   New Browser    chromium    headless=false
#   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#   Get Title      ==    Browser

*** Settings ***
Documentation     An example about for loops.

*** Variables ***
@{ROBOTS}=        Bender    Johnny5    Terminator    Robocop

*** Tasks ***
Loop Over A List Of Items And Log Each Of Them
    FOR    ${robot}    IN    @{ROBOTS}
    Log    ${robot}
    END
