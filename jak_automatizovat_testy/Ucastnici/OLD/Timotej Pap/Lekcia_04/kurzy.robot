*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://testovani.kitner.cz/courses


*** Test Cases ***

Prehlad kurzov
    New Browser         headless=false
    Server              ${URL}
    Zoznam kurzov       ${URL}

*** Keywords ***
Server
    [Arguments]         ${pURL}
    New Page            ${pURL}
    Get Title           contains            Testování

Zoznam kurzov
    [Arguments]         ${pURL}
    Go To               ${pURL}

    ${pocetKurzov} =    Get Element Count    data-test=course_name
    Log To Console      ${pocetKurzov}


    Set Strict Mode      off

   # následující cyklus se provede tolikrát kolik je kurzů na stránce
   FOR    ${counter}    IN RANGE    1    ${pocetKurzov}+1    1
#   FOR    ${counter}    IN RANGE    1    5    1    #Workaround pro chybu v indexování kurzů
      Log To Console   Kolo: ${counter}
      ${JmenoKurzu} =      Get Text                    data-test=course_name >> nth=${counter}
      Log To Console       KURZ: ${JmenoKurzu}
   END


  # ukázk apoužití podmínky
  IF    ${PocetKurzov} > 3
    Log To Console    Kurzů je víc než 3!
  END


