*** Settings ***
Library     Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       http://testovani.kitner.cz/courses
    Get Title      *=       Testování

    Take Screenshot
    Click              text=Přihlásit se
    Type Text          xpath=//*[@id="email_input"]     Ahoj
    Type Text          css=.input_box                   css
    Type Text          id=email_input                   Ahoj
    #Type Text          css=[moje_id=email_input]       aaa

    Type Text          data-test=email_input            user@email.cz

    Sleep           4

















