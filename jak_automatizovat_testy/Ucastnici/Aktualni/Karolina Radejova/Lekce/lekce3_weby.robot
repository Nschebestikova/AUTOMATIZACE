*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
#new browser - chromium - muzu pouzit jiny prohlizec
#new browser - muzu pripsat dalsi parametry
    New Browser    chromium    headless=false
#New Context - funguje jako anonymni okno, nezavisly kontext, muzu nastavit rozliseni (tablet, mobil, desktop)
    New Context    viewport={'width': 1920, 'height': 1080}
#New page - novy tab
    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#get title - ziska title okna
    Get Title      ==    Browser
#Close Browser - zavira natvrdo browser
#Get ... - rovnou muzu s necim porovnat a vyhodnocovat
