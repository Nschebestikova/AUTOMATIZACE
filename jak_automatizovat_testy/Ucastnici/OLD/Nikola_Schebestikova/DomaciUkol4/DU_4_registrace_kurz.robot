** Settings ***
Library  Browser

*** Variables ***
${pageURL}      http://testovani.kitner.cz/courses
${pageURL2}     http://testovani.kitner.cz/courses/1
${name}         NikolaTesterka
${email}        nikolaschebestikova@gmail.com
${password}     Testerka123



*** Test Cases ***
Načtení kurzů, jaké jsou k dispozici
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Pocet kurzu                      ${pageURL}
  Take Screenshot

Načtení názvů kurzů
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Názvy kurzů                     ${pageURL}
  Take Screenshot


#kurz na přihlášení - konkrétně tlačítko registrovat se, bez kompletní registrace (registraci jsem raději nedělala...)
Výběr a přihlášení na kurz
  New Browser     chromium        headless=false
  Otevření stránky s kurzy        ${pageURL}
  Registrace na kurz              ${pageURL2}
  Take Screenshot

#Ziskaní názvů kurzů a výpis = MŮŽEME NA TOTO MRKNOUT PO HODINĚ JEŠTĚ PROSÍM? CHTĚLA JSEM VYPSAT TY NÁZVY KURZŮ DO LOGU... :)
#  New Browser     chromium        headless=false
#  Otevření stránky s kurzy        ${pageURL}
#  Zkouska získání názvu           ${pageURL2}


*** Keywords ***
#ARGUMENTY A KS PRO NAČTENÍ SEZNAMU KURZŮ
Pocet kurzu
    [Arguments]          ${pageURL}
     Go To                ${pageURL}
    Take Screenshot
    ${Pocetkurzu} =   Get Element Count   css=[data-test=course_name]
     Wait For Elements State    "Máte zájem o naše kurzy?"   timeout=11 s
     Log To Console   ${Pocetkurzu}

  #cyklus pro kurzy pro zobrazení počtu kurzů - elementu ze stránky
    FOR   ${counter}   IN RANGE  ${PocetKurzu}
          Log To Console    ${counter}
    END


# nejsem si jistá, jak tam určit vypsání listu metoda nth se šipkama mi háže fail - ???
Názvy kurzů
     [Arguments]          ${nazvykurzu}
     Go To                ${pageURL}
     Take Screenshot
     ${nazvykurzu}    Get Text    css=[data-test=course_name]  >>  nth=1
     Wait For Elements State    Zaregistrujte se zde   timeout=15s
     Log To Console    ${nazvykurzu}

## #CYKLUS PRO VÝPIS KURZŮ - NAME ????  - # ??? probrat prosím na hodině? možná v tom jen hledám složitosti
#    FOR    ${counter}    IN RANGE     ${nazvykurzu}
#        Log    ${counter}
#    END



# ARGUMENTY PRO OTVĚVŘENÍ STRÁNKY NA KTEROU PŘEJDEME A VYBEREME KURZ
Otevření stránky s kurzy
   [Arguments]          ${pageURL}

   New Page             ${pageURL}
   Get Title  ==        Testování - Přehled kurzů  #ověření titulku stránka

#vytvoření registrace - kliknutí ne registraci prvního kurzu
Registrace na kurz
   [Arguments]    ${pageURL2}

   Go To         ${pageURL2}
   ${old_timeout} =    Set Browser Timeout    2m 30 seconds   #je třeba použít počkání ne element, protože to nestíhá najít a pádá to (nápověda v Browser R.F.)
   Click             data-test=registration_link
   Set Browser Timeout    ${old_timeout}
   Get Url   ==    http://testovani.kitner.cz/register
   Take Screenshot
   Type Text       data-test=name_input       ${name}
   Type Text       data-test=email_input      ${email}
   Type Text       data-test=password_input   ${password}
   Type Text       data-test=password_again_input    ${password}
   Click           data-test=register_button

    

