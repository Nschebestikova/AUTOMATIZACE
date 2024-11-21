#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a browser with a page
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#
#    ${Titulek}=  Get Title
#    Log To Console    ${Titulek}
#
#
#    Get Title      ==    Browser
#
#Starting a browser with a page kosik - cviceni
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://kosik.cz
#
#    ${Titulek}=  Get Title
#    Log To Console    ${Titulek}
#
#
#    Get Title      ==    Košík.cz | Nákup až ke dveřím za ceny jako v supermarketu
#
#




*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Context    viewport={"width":1920, "height":1000}
   New Page       http://testovani.kitner.cz/courses
   Get Title      ==    Testování - Přehled kurzů
#   Click          text="Přihlásit se"
#   Click          xpath=//*[@id="root"]/div/nav/div/div[1]/li[2]/a
#   Click          id=
#   Click          css=.mojetrida
   Click          data-test=navigation_login_item
   Sleep          2

   Type Text      data-test=email_input  neco@neco.cz

















#   Click          "Přihlásit se"
#   Click          data-test=login_button

# Ukázat jak se dá nahrávat Lokátor/Selector a zmínit problémy s tím spojené
#  ${selector} =    Record Selector   Přihlásit se
#  Click  ${selector}

#   Type Text      data-test=email_input     muj@email.cz