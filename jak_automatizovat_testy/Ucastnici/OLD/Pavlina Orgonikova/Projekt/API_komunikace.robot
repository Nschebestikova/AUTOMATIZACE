*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

#POZITIVNI TESTY
registrace ok - fyz      #OTAZKA:  ve vzoru ve cviceni 64 bylo pro fyzickou osobu uvedeno i ičo. proč? aby se daly snadno kopírovat testy na pra a fyz?
    API Comunication   {"targetid":"","kurz":"2","name":"Ján","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}  200

registrace ok - prav     #OTAZKA: v API dokumentaci je jen metoda POST. Ale kdybych chtěla otestovat, jak se chová formulář při vyplňování, jaké přesně zobrazuje hlášky, jestli zůstane správně vyplněné např. IČO, je k tomu dokumentace pro GET metodu?
    API Comunication   {"targetid":"","kurz":"3","name":"Andrej ","surname":"B.","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","ico":"25596641","count":"1","comment":"nějaký moudrý komentář k registraci o vysněný kurz","souhlas":false}  200

registrace ok - telefon s predvolbou +420
    API Comunication   {"targetid":"","kurz":"3","name":"Jan Pavel","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"+420608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}  200

registrace ok - max. délka "name"
     API Comunication   {"targetid":"","kurz":"2","name":"Llanfairpwllgwyngyllgogerychwy","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":"testovaci komentáááář","souhlas":true}  200

registrace ok - max. délka "surname"
     API Comunication   {"targetid":"","kurz":"2","name":"Johan","surname":"Llanfairpwllgwyngyllgogerychwy","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Aš","count":"5","comment":null,"souhlas":true}  200


#NEGATIVNI TESTY
registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace žádné jméno
    API Comunication   {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}  500

registrace žádné příjmení
    API Comunication   {"targetid":"","kurz":"2","name":"LlanfairpwllgwyngyllgogerychwyA","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}  500

registrace - moc dlouhé "name"   #OTAZKA: registrace na webu projde úspěšně, ale v tabulce je překročen limit pro jméno. Test nehlásí chybu. Jak se takové případy řeší?
    API Comunication   {"targetid":"","kurz":"2","name":"LlanfairpwllgwyngyllgogerychwyA","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}  500

registrace - moc dlouhé "surname"   #OTAZKA: registrace na webu projde úspěšně, ale v tabulce je překročen limit pro příjmen í. Test nehlásí chybu. Jak se takové případy řeší?
    API Comunication   {"targetid":"","kurz":"1","name":"Carlos","surname":"LlanfairpwllgwyngyllgogerychwyA","email":"jan.novak@abc.sk","phone":"608123123","person":"pra","ico":"25596641","count":"1","comment":"blablabbbbbbbbbla","souhlas":false}  500

registrace žádný telefon
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (000000000)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"000000000","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunication    {"targetid":"","kurz":"3","name":"žouželína","surname":"Helemeseřčščřščř","email":"kolerg.sergsergk@google.com","phone":"60853445345345123123","person":"fyz","address":"Příbram","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny email - bez @    #tento test hlásí chybu, ale registrace podle webu i BE tabulku proběhne úspěšně!
    API Comunication    {"targetid":"","kurz":"1","name":"A","surname":"B","email":"kolerg.sergsergkgoogle.com","phone":"605123432","person":"fyz","address":"Příbram","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy "kurz":"" )
    API Comunication    {"targetid":"","":"" ,"name":"Pako","surname":"ucho","email":"kolerg.sergsergk@google.com","phone":"656345765","person":"pra","address":"Příbram","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny format JSON (bez slozenych zavorek)
    API Comunication    "targetid":"","kurz":"1","name":"Pako","surname":"ucho","email":"kolerg.sergsergk@google.com","phone":"656345765","person":"fyz","address":"Lány","ico":"234563234","count":"1","comment":null,"souhlas":true  500

registrace jméno se speciálními znaky    #tento test hlásí chybu, ale registrace podle webu i BE tabulku proběhne úspěšně!
    API Comunication   {"targetid":"","kurz":"","name":"@","surname":"$","email":"s@c.ct","phone":"608123123","person":"fyz","address":"řčš","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace na 0 osob
    API Comunication   {"targetid":"","kurz":"3","name":"hlava","surname":"noha","email":"s@c.ct","phone":"608123123","person":"fyz","address":"řčš","count":"0","comment":null,"souhlas":false}   500

registrace záporný počet osob   #test by neměl projít, ale registrace je úspěšná!
    API Comunication   {"targetid":"","kurz":"3","name":"hlava","surname":"noha","email":"s@c.ct","phone":"608123123","person":"fyz","address":"řčš","count":"-1","comment":null,"souhlas":false}   500

registrace příliš vysokého počtu osob   #lze zaregistrovat i v tabulce je zapsáno. Ale měl by být nastavený reálný limit a test by měl failovat.  
    API Comunication   {"targetid":"","kurz":"3","name":"hlava","surname":"noha","email":"s@c.ct","phone":"608123123","person":"fyz","address":"řčš","count":"100","comment":null,"souhlas":false}   500


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}
