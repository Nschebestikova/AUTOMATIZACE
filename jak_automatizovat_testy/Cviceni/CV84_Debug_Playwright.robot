# BROWSER LOG LEVEL DEBUG
# Zapnutí podrobnějších logů z playwrightu

# Allowed Values
#     disabled
#     library
#     playwright
#     false
#     true

*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
#Library         Browser
Library         Browser  enable_playwright_debug=playwright


#Logy najde v   log/playwright-log.txt
Library         OperatingSystem

*** Test Cases ***
Test Example
    New Browser    chromium    headless=False
    New Page       https://alza.cz
    Get Title
    Close Browser