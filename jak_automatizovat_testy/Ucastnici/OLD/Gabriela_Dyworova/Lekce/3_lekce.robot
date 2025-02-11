*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       http://testovani.kitner.cz/login
   #Get Title      ==    Přihlášení
   # Click          "Login"

   Get title      contains    Testování
   Click            data-test=email_input
   Type Text    data-test=email_input     giyipem264@v1zw.com

   Click            data-test=password_input
   Type Text    data-test=password_input     tajnenovak

   Click       data-test=login_button
   Click       data-testid="courses_profile"



#     ${USER1_NAME}         Michal Novák
#     ${USER1_EMAIL}         giyipem264@v1zw.com
#     ${USER1_password}        tajnenovak