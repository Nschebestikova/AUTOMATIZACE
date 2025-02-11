*** Settings ***
Library  Browser

*** Variables ***
    #selektory k prihlaseni a odlaseni
${SEL_email}           data-test=email_input
${SEL_heslo}           data-test=password_input
${SEL_tl_prihlasit}    data-test=login_button
${SEL_tl_odhlasit}     data-test=logout_button

    #selektor prihlasovaci stranky
${SEL_prihlasovaci_stranky}    data-test=login_text

    #selektory kontroly
${SEL_kontroly_prihlaseni}     data-test=home_section

*** Test Cases ***

Prihlaseni -
    Otevreni stranky

    Login-             eliska.palenickova@seznam.cz     123Eliska123a      These credentials

Prihlaseni +
    Otevreni stranky

    Login+             eliska.palenickova@seznam.cz    123Eliska123    Vítej uživateli
    Logout

Odhlaseni
    Otevreni stranky

    Login+             eliska.palenickova@seznam.cz    123Eliska123    Vítej uživateli
    Sleep              1            #nutne pro vyfoceni
    Take Screenshot   fullPage=True    fileType=jpeg    quality=50    timeout=10s

    Logout
    Take Screenshot   fullPage=True    fileType=jpeg    quality=50    timeout=10s


*** Keywords ***

Otevreni stranky
    New Browser        chromium    headless=false
    New Page           http://testovani.kitner.cz/login
    Get Title          ==  Testování

Login+
    [Arguments]     ${email}      ${heslo}      ${vysledek}
    log             ${email}
    log             ${heslo}
    Log             ${vysledek}

    Type Text       ${SEL_email}  ${email}      #selektor k prihlaseni emailu a nazev email
    Type Text       ${SEL_heslo}  ${heslo}      #selektor k nalezeni hesla a heslo
    Click           ${SEL_tl_prihlasit}
    #kontrola přihlášení
   # Get Text        ${SEL_kontroly_prihlaseni}  contains    Vítej uživateli

Login-
    [Arguments]     ${email}      ${heslo}      ${vysledek}
    log             ${email}
    log             ${heslo}
    Type Text       ${SEL_email}  ${email}      #selektor k prihlaseni emailu a nazev email
    Type Text       ${SEL_heslo}  ${heslo}      #selektor k nalezeni hesla a heslo
    Click           ${SEL_tl_prihlasit}
    #overeni neprihlaseni
    #Get Text        ${SEL_prohlasovaci_stranky}  ==  Přihlášení

Logout
    Click           ${SEL_tl_odhlasit}
    #overeni odhlaseni
    Get Text        ${SEL_prihlasovaci_stranky}  ==  Přihlášení

