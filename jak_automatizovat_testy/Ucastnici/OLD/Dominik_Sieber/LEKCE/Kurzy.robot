*** Settings ***
Library     Browser

*** Variables ***
${URL}                  http://testovani.kitner.cz/courses

*** Test Cases ***
# str. obsahuje dane kurzy ze seznamu
Check count of displayed courses
    Otevrit Radka       ${URL}
    Pocty kurzu
# str. obsahuje polozky: course_name, course_capacity, course_price, course_buttons
# prihlasit se a zaregistrovat na kurz
# registrace na kurz bez prihlaseni
# vyber kurzu, registrace
# zjistit cenu vsech kurzu


*** Keywords ***
Otevrit Radka
    [Arguments]         ${url}

    New Browser         chromium    headless=true
    New Page            ${url}
    Get Title           ==      Testování - Přehled kurzů
    Get Text            [data-test=registration_link][class=_registrationLink_1nlxo_73]        ==      Zaregistrujte se zde
    Log                 Str je nactena!
    Set Strict Mode     off

Pocty kurzu
#spocitej kurzy
   ${pocet_kurzu} =     Get Element Count    data-test=course_name
   Log To Console       Pocet Kurzu je: ${pocet_kurzu}

#zaloguj kurzy
   FOR    ${counter}    IN RANGE    ${pocet_kurzu}
       ${Kurz} =            Get Text           data-test=course_name >> nth=${counter}
       Log To Console       Jmeno kurzu je: ${Kurz}
   END