#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a browser with a page
#   New Browser    chromium    headless=false
#   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#   Get Title      ==    Browser


#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a browser with a page
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#    Get Title      ==    Browser

#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a browser with a page
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://www.rohlik.cz/vitejte
#    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě


*** Settings ***
Library  Browser


*** Test Cases ***
#Starting a browser with a page
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       http://testovani.kitner.cz/courses
#    Get Title      ==    Testování - Přehled kurzů
#    Sleep          1
##   Click          "Přihlásit se"
##   Click          xpath=//*[@id="root"]/div/nav/div/div[1]/li[2]/a
##    Click         id=dadasdsa
##   Click         css=.mojetrida
#    Click         data-test=navigation_login_item
#    Click         css=[data-testid=navigation_login_item]
#
#    Type Text       data-test=email_input    neco@neco.cz
#
#   Sleep          5

Spusteni browseru
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    Sleep    3
    New Page       http://testovani.kitner.cz/courses
    Sleep    3
    Get Title      ==    Testování - Přehled kurzů
    Sleep    3
    Click          text="Přihlásit se"
    Sleep    3
    Type Text       data-test=email_input    giyipem264@v1zw.com
    Sleep    3
    Type Text           data-test=password_input    tajnenovak
    Sleep    3
    Click           data-test=login_button
    Sleep    3