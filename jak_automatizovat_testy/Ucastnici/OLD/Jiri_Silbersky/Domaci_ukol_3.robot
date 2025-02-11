*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page 2
   New Browser    chromium    headless=false
   New Page       http://testovani.kitner.cz/login
   Type Text      data-test=email_input         jsilbersky@gmail.com
   Type Text      data-test=password_input      HesloKitnerWeb
   Click          id=login_button
   Get Text       text=Jak ovládat Git 2
   Take Screenshot
   Click          data-testid=logout_button