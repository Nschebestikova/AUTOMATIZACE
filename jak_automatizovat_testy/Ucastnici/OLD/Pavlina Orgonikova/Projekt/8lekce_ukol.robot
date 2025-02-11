*** Settings ***
Library  RequestsLibrary
Library  String
Library  DebugLibrary
#Library  Collections

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

#POZTIVNI TESTY
Registrace ok - prav  
    Registrace Na Kurz API      2  Jan  B.  jan.novak@abc.cz  608123123  pra  25596641  1  nějaký moudrý komentář k registraci o vysněný kurz  false  200
    
registrace ok - fyz      
    Registrace Na Kurz API      2  Ján  Novakščěšíů  jan.novak@abc.cz  608123123  fyz  Brno, Nějaka ulice 123, 602 00  1  ${EMPTY}  true  200

registrace ok - telefon s predvolbou +420
    Registrace Na Kurz API       3  Jan Pavel  Novakščěšíů  jan.novak@abc.cz  +420608123123  fyz  Brno  1  123  true  200

registrace ok - max. délka "name"
     Registrace Na Kurz API       1  Llanfairpwllgwyngyllgogerychwy  Novakščěšíů  jan.novak@abc.cz  608123123  fyz  Brno  5  Testovaci komentáááář  true  200

registrace ok - max. délka "surname"
     Registrace Na Kurz API       2  Johan  Llanfairpwllgwyngyllgogerychwy  jan.novak@abc.cz  608123123  fyz  Aš  5  ${EMPTY}  true  200


#NEGATIVNI TESTY
registrace bez volby kurzu
    Registrace Na Kurz API       ${EMPTY}  Jan  Novak  jan.novak@abc.cz  608123123  fyz  Brno  1  ${EMPTY}  true   500

registrace žádné jméno
    Registrace Na Kurz API       2  ${EMPTY}  Novakščěšíů  jan.novak@abc.cz  608123123"  fyz  Brno Nejaka ulice  1  ${EMPTY}  true  500

registrace žádné příjmení
    Registrace Na Kurz API       2  LlanfairpwllgwyngyllgogerychwyA  ${EMPTY}  jan.novak@abc.cz  608123123  fyz  Přerov  1  nic  true  500

registrace - moc dlouhé "name"   #registrace na webu projde úspěšně, ale v tabulce je překročen limit pro jméno. Test nehlásí chybu!
    Debug
    Registrace Na Kurz API       2  LlanfairpwllgwyngyllgogerychwyA  Novakščěšíů  jan.novak@abc.cz  608123123  fyz  Brno  1  null  true  500
     
registrace - moc dlouhé "surname"   #registrace na webu projde úspěšně, ale v tabulce je překročen limit pro příjmen í. Test nehlásí chybu!
    Debug
    Registrace Na Kurz API       1  Carlos  LlanfairpwllgwyngyllgogerychwyA  jan.novak@abc.sk  608123123  pra  25596641  1  blablabbbbbbbbbla  false  500

registrace žádný telefon
    Registrace Na Kurz API       3  JJJan  Novsgersgserak  jan.novak@abc.cz  ${EMPTY}  fyz  Brno  5  nevim  true   500

registrace chybny telefon (000000000)  #test nehlásí chybu, registrace dle webu probehne, ale v databázi registrace není
    Debug
    Registrace Na Kurz API       1  Jan  Novak  j@abc.cz  000000000  fyz  Brno  1  něco  true   500

registrace chybny telefon (moc dlouhy)
    Registrace Na Kurz API        3  žouželína  Helemeseřčščřščř  kolerg.sergsergk@google.com  60853445345345123123  fyz  Příbram  1  ${EMPTY}  true  500

registrace chybny email - bez @    #tento test hlásí chybu, ale registrace podle webu i BE tabulku proběhne úspěšně!
    Debug
    Registrace Na Kurz API        1  A  B  kolerg.sergsergkgoogle.com  605123432  fyz  Příbram  1  .f  true  500

registrace jméno se speciálními znaky    #tento test hlásí chybu, ale registrace podle webu i BE tabulku proběhne úspěšně!
    Registrace Na Kurz API       2  @  $  s@c.ct  608123123  fyz  řčš  1  neco  true   500

registrace na 0 osob
    Registrace Na Kurz API       3  hlava  noha  s@c.ct  608123123  fyz  řčš  0  null  :false   500

registrace záporný počet osob   #test by neměl projít, ale registrace je úspěšná!
    Debug
    Registrace Na Kurz API       3  hlava  noha  s@c.ct  608123123  fyz  řčš  -1  null  false   500

registrace počet osob nečíselný údaj
    Registrace Na Kurz API       3  hlava  noha  s@c.ct  608123123  fyz  řčš  hodne  -  false   500

registrace příliš vysokého počtu osob   #lze zaregistrovat i v tabulce je zapsáno. Ale měl by být nastavený reálný limit a test by měl failovat.
    Registrace Na Kurz API       3  hlava  noha  s@c.ct  608123123  fyz  řčš  100  bez komentare  false   500

   

*** Keywords ***

Registrace na kurz API
    [Arguments]    ${kurz}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${response_code}

#tvorba JSON body
      ${json}=     Catenate      {"targetid":"","kurz":"${kurz}",
    ...  "name":"${name}",
    ...  "surname":"${surname}",
    ...  "email":"${email}",
    ...  "phone":"${phone}",
    ...  "person":"${person}",
    ...  "address":"${address_ico}",
    ...  "ico":"${address_ico}",
    ...  "count":"${count}",
    ...  "comment":"${comment}",
    ...  "souhlas":${souhlas}}

  Log                Argumenty json=${json}, error_resp=${response_code}   TRACE

  Log                Převod na UTF-8: ${json}   level=INFO
  Log                Převod na UTF-8: ${json}   level=DEBUG   formatter=repr
    
      #převedení do UTF-8
  ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
  Log                Převod na UTF-8: ${json_utf8}   level=INFO
  Log                Převod na UTF-8: ${json_utf8}   level=DEBUG   formatter=repr
  
 # ${header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
 # Log                  HEADER&:  ${header}  level=DEBUG  formatter=repr
    #OTAZKA: nejde mi zakomponovat header do testu. můžeme se na to podívat?

  ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=Anything

    Log                 Response: ${resp}  level=DEBUG  formatter=repr
    
    #Vyhodnocení
    Status Should Be      ${response_code}  #kontroluje status kod
    Should Be Equal       ${resp.json()}[response]   ${response_code}   #kontroluje status v těle
    
