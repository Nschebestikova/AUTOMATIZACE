
*** Settings ***
Library     Browser
Resource    C:\Users\Nikča\PycharmProjects\Jak_automatizovat_testy\jak_automatizovat_testy\Ucastnici\Aktualni\Nikola_Schebestikova\Projekt\Data_and_Config\TestData_megaknihy.robot
Resource    C:\Users\Nikča\PycharmProjects\Jak_automatizovat_testy\jak_automatizovat_testy\Ucastnici\Aktualni\Nikola_Schebestikova\Projekt\Data_and_Config\Konfigurace_megaknihy.robot

#*** Variables ***
#${URL}        https://www.megaknihy.cz/autentifikace?back=identity.php
#${email}      nikolaschebestikova@gmail.com
#${heslo}      Testerka2593


*** Test Cases ***
Otevreni webového prohlizece a prihlaseni
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=  Megaknihy
    Click          "Povolit vše"
#Přihlášení správné
    Type Text       id=email    ${email}
    Type Text       id=passwd   ${heslo}
    Click           "Přihlásit"
    Sleep  4
    Take screenshot
#Odhlášení ze stránky - uživatel je odhlášen
     Click      "Odhlásit se"
     Get Url     !=  https://www.megaknihy.cz/profil
     Take screenshot
     Close Page

*** Test Cases ***

Uzivatel neni prihlasen - spatne prihlaseni email
       Login     nikolasch@gmail.com    Testerka2593
       Click     "Přihlásit"
       Get text  "Vyskytla se chyba"
       Get Url      ==  https://www.megaknihy.cz/autentifikace  #"Assert
       Take Screenshot

Spatne prihlaseni heslo
     Login     nikolaschebestikova@gmail.com    Tester2593
     Click     "Přihlásit"
     Get text  "Vyskytla se chyba"
     Get Url      ==  https://www.megaknihy.cz/autentifikace  #"Assert
     Take Screenshot
     Close Page

*** Keywords ***
Login
    [Arguments]         ${email}                ${heslo}

    log                 ${email}
    log                 ${heslo}

    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=  Megaknihy
    Click          "Povolit vše"
    Type Text       id=email    ${email}
    Type Text       id=passwd   ${heslo}
    Click           "Přihlásit"
    Sleep  2
    Take screenshot

    #Přidat do keywords - uzivatel je přihlašen a uživatel není přihlášen a toto dát na konec testu - výpis "Uživatel není přihlášen"


#DOTAZY - New Context: Po inicializaci prohlížeče
#jak zapracovst? Go To: Přejde na určené URL
#VYSVĚTLENÍ OHLEDNĚ PUPPETEER A PROHLÍŽEČŮ - FIREFOX = jak použít v testu Mozilla prohlížeč a zda stačí napsat jenom Chrome místo Chromium?
