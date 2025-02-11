*** Settings ***
Library Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.saucedemo.com/
    #titulek stránka kde hledáme
    Get Title      ==    Swag Labs
#    lze napsat i jiným způsobem
#    ${titulek}  =
#    Should Be Equal  ${title}  Swag Labs
#print screen
    Take Screenshot
