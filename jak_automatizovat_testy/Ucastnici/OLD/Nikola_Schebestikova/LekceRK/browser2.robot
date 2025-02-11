
#*** Variables ***
#${zvire}  slon
#
#*** Test Cases ***
#Podminky
#
##    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
#    IF  "${zvire}" == "slon"
#        Log To Console    Je to slon
#    ELSE
#        Log To Console    Neni to slon
#    END
#
#
#   # příklad Radka K.
#   IF  "${zvire}" == "slon"
#        Log To Console    Je to slon
#    ELSE
#        Log To Console    Neni to slon
#    END
#
#
#    IF    ${zvire} == 10
#         Log To Console    Je to 10
#    ELSE
#         Log To Console    NENI
#    END
#
## cykly
#Cykly
#    FOR    ${counter}    IN RANGE    1    10    2  # od, do, krok takto to jde, jako v Pythonu
#        Log To Console    ${counter}
#    END




*** Settings ***
Library  Browser
#Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor/lokátor) kde
#...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
#...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
#...             v našem případě to bude selektor data-test=login_link pokud nejsem přihlášen
#...             data-test=logout_button pokud jsem přihláše
#...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
#...             přidat podmínku

*** Variables ***
${URL}      http://testovani.kitner.cz/courses



*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
#   KS                          login                                heslo             očekávám úspěšné přihlášení
    Login_s_kontrolou           giyipem264@v1zw.com                  tajnenovak        ano


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           giyipem264@v1zw.com                  chyba             ne



*** Keywords ***   #klíčoivá slova, podle níž si testy spouštíme, naše promněnné klíčové pro test
Login_s_kontrolou
   [Arguments]          ${Email}            ${Heslo}            ${JeUzivatelPrihlasen}  #ideální dobře projmenovat proměnnou

   # Doplní kód pro login
   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů
   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button

   # Doplní kód pro kontrolu
   IF    "${JeUzivatelPrihlasen}" == "ano"   #podmínka pro přihlášení = podmínka je nejtěžší vymyslet(potřebuji co je mým očekávání z testu = například ano a toto dát do klíčových slov a potom si to vložit do podmínky a na tom si vytvořit test)
      Log To Console    Uživatel musí být přihlášen
      Get Text    data-test=logout_button    ==   Odhlásit se  # kontrolní lokátor pro přihlášení
   ELSE
      Log To Console    Uživatel nesmí být přihlášen
      Get Text     data-test=login_link          ==       Přihlásit se    #kontrolní lokátor pro nepřihlášení
   END

Login_bez_kontroly
   [Arguments]          ${Email}            ${Heslo}

   New Browser        headless=False
   New Page           ${URL}
   Get Title  ==      Testování - Přehled kurzů
   Click            data-test=login_link
   Type Text        data-test=email_input            ${Email}
   Type Text        data-test=password_input         ${Heslo}
   Click            data-test=login_button

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        data-test=logout_button       ==       Odhlásit se


Uživatel není přihlášen
    Get Text        data-test=login_link          ==       Přihlásit se



# CV přidat do CV41 a cv 41 mít jako hotové, jak to má vypadat
#1. ukázat s chybou
#2.2. ukázat jak vypnout strict mode
#3. ukázat ja spočítat počet kurzu přes Get Element Count
#3. ukázat jak přidat cyklus a vypsat všechny


** Settings ***
Library  Browser


*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***
Jake kurzy jsou k dispozici na prehledu kurzu
   New Browser                           headless=False
   Otevření stránky se seznamem kurzu    ${URL}
   Seznam kurzu                          ${URL}

*** Keywords ***
Seznam kurzu
   [Arguments]          ${pURL}

   Go To                ${pURL}

#   Sleep                  1              # kvůli dynamičnosti je třeba zde dávat tento příkaz, aby se to stihlo načíst, jinak nenačte - lazy loading toto je možnost selenia natvrdo

   # Je třeba počkat až se všechny kurzy nahrají, to se zajistí čekáním na element na konci stránky
   Get Text             "Máte zájem o naše kurzy?"   #toto je dynamické čekání - moderní pro playwright - framework r. = ČEKÁNÍ NA OBJEKT/NĚJAKÝ TEXT A NAHRAZUJE TO SLEEP = BUDE TO STOKRÁT RYCHLEJŠÍ/RADŠI NEVYUŽÍVAT SLEEPY!!!

   Take Screenshot
   # ${old_mode} =      Set Strict Mode    False

   ${PocetKurzu} =   Get Element Count   data-test=course_name

   ${nazev_kurzu}    Get Text    data-test=course_name  >>  nth=0
   Log To Console    ${nazev_kurzu}

   FOR   ${counter}   IN RANGE  ${PocetKurzu}
          Log    ${counter}
          ${nazev_kurzu} =  Get Text    data-test=course_name >>  nth=${counter}
          Log To Console    ${nazev_kurzu}
   END

#   # spočítá kolik je tam kurzu podle počtu výskytu elementů s atributem data-test=course_name
#   # v dev tools je třeba najít  [data-test=course_name]
#   ${PocetKurzu} =      Get Element Count           data-test=course_name
#   Log To Console       ${PocetKurzu}



Otevření stránky se seznamem kurzu
   [Arguments]          ${pURL}

   New Page             ${pURL}
   Get Title  ==        Testování - Přehled kurzů