*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser  chromium  headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page  https://marketsquare.github.io/robotframework-browser/Browser.html

    ${titulek} =  Get Title
    Should Be Equal    ${titulek} Bro

    Get Title  contains  Bro
