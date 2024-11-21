*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Context    viewport={'width': 1920, 'height': 1080}
   New Page       http://testovani.kitner.cz/courses
   Get Title      contains    Testování
   Get Title      !=  Ahoj

   Take Screenshot
   Click          text=Přihlásit se
   Click          id=email_input
   
   Type Text      id=email_input   Ahoj
   Type Text      xpath=//*[@id="email_input"]   Ahoj
   Type Text      data-test=email_input     user@email.cz    
 #  Type Text      css=[moje_id=email_input]     aaaaaa

   Take Screenshot

   Sleep          4

