*** Settings ***
Library         Browser
Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot
Library	        RequestsLibrary
Library         String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections

Suite Setup     Pred_sadou
#Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu
Test Timeout    ${TC_TIMEOUT_ROBOT_KW}      # Timeout pro všechny KS z RobotFW


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly         ${SPRAVNY_MAIL}        ${SPRAVNE_HESLO}
   Vyhodnoceni testu    ${SELECTOR_ODHLASENI}   ${ODHLASI_SE}
   Take Screenshot
   Odhlaseni_bez_kontroly         ${ODHLASI_SE}
   Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPRAVNY_MAIL}         ${SPATNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne heslo mezera - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPRAVNY_MAIL}         ${SPATNE_HESLO_MEZERA}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL}        ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez zavinace - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL_ZAVINAC}         ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez com - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly           ${SPATNY_MAIL_COM}          ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Login - Chybne email bez tečky - varianta kontrola v parametru klicoveho slova
   Login_bez_kontroly          ${SPATNY_MAIL_BEZTECKY}        ${SPRAVNE_HESLO}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

Odhlášení - uspěšné
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
#    Get Text    ${SELECTOR_PRIHLASENI}
Registrace prvni kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_PRVNI}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace druhy kurz - uspěšná
    Login_bez_kontroly         ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_DRUHY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace treti kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_TRETI}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace ctvrty kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_CTVRTY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace paty kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_PATY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace sesty kurz - uspěšná
    Login_bez_kontroly          ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_SESTY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}
Registrace sedmy kurz - uspěšná
    Login_bez_kontroly           ${SPRAVNY_MAIL}       ${SPRAVNE_HESLO}
    Registrace na kurz    ${SELECTOR_REGISTRACE_SEDMY}
    Odhlaseni_bez_kontroly         ${ODHLASI_SE}
    Vyhodnoceni testu    ${SELECTOR_PRIHLASENI}        ${PRIHLASI_SE}

#    API
registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"1111111111111111123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny email (tohleneniemail.cz)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500


registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy)
    API Comunication   {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500


#BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat) např scházející uvozovky nebo složené závorky
#přidat test
registrace moc dlouhe jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"Janaaaaaaaaaaaaaaajjjjjjjjjjjjjaaaaaaaaaakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkklllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace prazdne hodnoty - kurz=""
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace bez klíče kurzu
        API Comunication   {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace specialni znak
    API Comunication   {"targetid":"","kurz":"2","name":"$Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chyby v JSON formatu - bez kliče e-mailu a hodnoty
    API Comunication   {"targetid":"", "kurz":"2","name":"Jan","surname":"Novakščěšíů","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500


*** Keywords ***
Login_bez_kontroly
  [Arguments]      ${Email}            ${Heslo}
  Go to       ${URL}
  Click  ${SELECTOR_PRIHLASENI}
  Type Text        ${SELECTOR_MAIL}           ${Email}
  Type Text        ${SELECTOR_HESLO}         ${Heslo}
  Click            ${SELECTOR_PRIHLASENI_FORMULAR}
  Take Screenshot

Odhlaseni_bez_kontroly
   [Arguments]      ${Text}
   Take Screenshot
    Click  ${SELECTOR_ODHLASENI}
    Take Screenshot

Vyhodnoceni testu
    [Arguments]     ${SELECTOR}             ${VYSLEDEK}
    Get Text     ${SELECTOR}       ==        ${VYSLEDEK}
    Take Screenshot

#Pozitivni test prihlaseni
#    Get Text     ${SELECTOR_ODHLASENI}       ==            ${ODHLASI_SE}
#
#Negativni test prihlaseni
#    Get Text     ${SELECTOR_PRIHLASENI}           ==            ${PRIHLASI_SE}
Registrace na kurz
    [Arguments]     ${SELECTOR_REGISTRACE}
    Set Strict Mode    off
    Click  ${SELECTOR_REGISTRACE}
    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
    Type Text    ${SELECTOR_ICO}    ${IC}
    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
    Take Screenshot
    Set Strict Mode    on

#Registrace prvni kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_PRVNI}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace druhy kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_DRUHY}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace treti kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_TRETI}
#    Click   ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI}
#    Type Text    ${SELECTOR_ICO}    ${IC}
#    Type Text    ${SELECTOR_TELEFON}    ${TELEFON}
#    Click        ${SELECTOR_NEZAVAZNA_REGISTRACE_PRVNI_POSLEDNISTRANA}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace ctvrty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_CTVRTY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace paty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_PATY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace sesty kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_SESTY}
#    Take Screenshot
#    Set Strict Mode    on
#
#Registrace sedmy kurz
#    Set Strict Mode    off
#    Click  ${SELECTOR_REGISTRACE_SEDMY}
#    Take Screenshot
#    Set Strict Mode    on

Pred_sadou
    ${b_timeput} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}
    New Browser        headless=False
    New Page           ${URL}
    Get Title  ==      ${TITULEK_STRANKY}

Pred_testem
    Go to               ${URL}   #jdi na hlavní stránku

Uklid_po_testu
    Log         Uklid na konci každého testu.
    Go to       ${URL}

Uklid_sada
    Close Browser

#  IF    "${Text}" == "prihlasi se"
#      Get Text     data-test=logout_button       ==            Odhlásit se
#  ELSE
#      Get Text     data-test=login_link          ==            Přihlásit se
#  END

#API
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
  CreateSession       apilogin            ${url2}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}