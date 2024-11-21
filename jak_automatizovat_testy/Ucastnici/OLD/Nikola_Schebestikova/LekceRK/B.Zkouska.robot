#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a LekceRK with a page
#    New Browser    chromium    headless=false  #pri tom, aby nam jely testy =
#    New Context    viewport={'width': 1920, 'height': 1080}  #rozliseni - pri testingu responzivity
#    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html      #ciste karta, zobrazení page
# #   ${titulek}=    Get Title
# #   Should Be Equal    ${titulek}  Browser  #složitější zápisek ověření titulku záložky/webu
#    Get Title      *=  Bro   #kontrola, jestli v titulku ma napsáno LekceRK - název v záložce, titulke stranky
#    Get Title      !=  Ahoj
    
    
*** Settings ***
Library  Browser

*** Test Cases ***
Starting page testovani
    New Browser    chromium    headless=false
    New Page       http://testovani.kitner.cz/courses
    Get Title      *=    Testování

#<a data-testid="login_link" data-test="login_link" class="_link_beyef_13" href="/login">Přihlásit se</a>
   Click       text=Přihlásit se

   Type Text    id=email_input    Ahoj
#  Type Text    xpath=//*[@id="root"]/div/nav/div/div[1]/li[2]/a    Tondo   #xpath = nedoporučuje, je to horší cesta,složitá ale využívá se
   Type Text    css=.input_box    css                                       #další metoda
   Type Text    data-test=email_input   user@emil.cz                        # další způsob ověření atributu
   Take Screenshot   # v logu uvidíme hezky screenshoty cesty testu


   Sleep       4