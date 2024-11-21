*** Settings ***
Library  Browser


*** Test Cases ***

Starting a browser with a page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html

    Get Title      ==   Browser
  # Get Title      *=    Brow    tzn kdyby mel obsahovat tuto cast ale nemusi se zcela shodovat
  # Get Title      !=    Ahoj    tzn kdyby nemel obsahovat Ahoj


Starting a page - test z 3.lekce
    New Browser     chromium     headless=false
    New Page        http://testovani.kitner.cz/courses
    Get Title    *=   Testování

    Take Screenshot    
    Click           "Přihlásit se"
    #Click         text="Přihlásit se"   #další varianta zápisu
    #Click         text=Přihlásit se     #dalši varianta zápisu
    Take Screenshot
    Type Text       id=email_input                    Ahoj

   #varianta pomocí xpath:
    Type Text       xpath=//*[@id="email_input"]       Ahoj

    #varianta pomocí CSS:
    Type Text       css=.input_box                       css
    Take Screenshot
    #varianta s data-test, nejlepsi reseni
    Type Text       data-test=email_input               user@email.cz
    Take Screenshot
   # Type Text       css=[moje_id=email_input]           aaaa

    Sleep            4

   # <a data-testid="login_link" data-test="login_link" class="_link_beyef_13" href="/login">Přihlásit se</a>

# Element pole na vyplneni emailu pri prihlaseni
#  <input data-testid="email_input" data-test="email_input" id="email_input" type="email" placeholder="Email" class="input_box email border-[#E9EDF4] focus:border-[#bec0c2]
                                    #    w-full rounded-md border bg-white
                                     #   py-3 px-5 text-base text-body-color
                                      #  placeholder-[#ACB6BE] outline-none
                                       # focus:border-primary focus-visible:shadow-none" value="">