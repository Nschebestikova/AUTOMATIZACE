#
# Ukázka práce s lokátory na aplikace Demo login: registrace na kurz
#
*** Settings ***
Library  Browser

*** Test Cases ***

Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       http://testovani.kitner.cz/login
   Get Title      ==    Testování - přihlášení

#element: Chceme identifikovat element z testovani.kitner.cz Demo Registrace na kurz
# Zde je uveden:
#<input data-testid="email_input" data-test="email_input" id="email_input" type="email"
#    placeholder="Email" class="input_box email border-[#E9EDF4] focus:border-[#bec0c2]
#    w-full rounded-md border bg-white py-3 px-5 text-base text-body-color
#    placeholder-[#ACB6BE] outline-none focus:border-primary focus-visible:shadow-none" value="">

    Set Strict Mode    off
### CSS selektory ###
#identifikace pole pro zadání uživatelského jména

    Type Text     css=#email_input                     user1@email.cz
    Type Text     css=\#email_input                    user2@email.cz
    Type Text     css=input#email_input                user3@email.cz   # výběr pomocí typu elementu (span) a id (headerLogin)
    Type Text     css=[type="email"]                   user4@email.cz   # výběr pomocí CSS atributu
    Type Text     css=[data-test="email_input"]        user5@email.cz   # výběr pomocí CSS atributu

    # Níže popsané 3 způsoby jednou jen pokud je vyplý strict mode a vybere 1. ze dvou variant
    Type Text     css=.input_box                         user6@email.cz   # výběr pomocí 1 class
    Type Text     css=.input_box.email                   user7@email.cz   # výběr pomocí 2 class, nesmí mezi něma být mezera

    # vyběr pomocí více elemntů (zanoření)
    # využívá narřazený element: <div data-testid="login_form_second_input_divider" data-test="login_form_second_input_divider" class="mb-4">
    Type Text     css=.mb-4 >> [data-test="email_input"]      user9@email.cz

    Take Screenshot



### XPATH selektory ###
#heslo

   Type Text     xpath=//*[@id="root"]/div/section/div/div/div/form/div[2]/input       tohle_neni_platne_heslo

   Take Screenshot



### ID selektory ###

   Click              data-test=login_button

   Take Screenshot


## TEXT selektory ###
   ${text} =    Get Text   data-test=email_input_errors  *=  These credentials do not match our records.
   Log          ${text}

   Take Screenshot

### "data-test" selektory ###
#uspěšné přihlášení

#   Type Text   data-test=username   standard_user
#   Type Text   data-test=password   secret_sauce
#   Click       data-test=login-button
#   Get Text    text="Products"  ==  Products
#
#   Take Screenshot










