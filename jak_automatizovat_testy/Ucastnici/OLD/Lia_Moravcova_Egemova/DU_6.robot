*** Settings ***
Library   Collections
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}



*** Test Cases ***

radna registrace
     Registrace   2  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   200

registrace bez volby kurzu
    Registrace   ""  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace bez klice kurz
     Registrace     Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   0     500

Registrace k minusovym kurzem
      Registrace   -1  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

Registrace s horni hranicni hodnotou kurzu
      Registrace   4  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace s písmeny ve volbě kurzu
    Registrace   uiefžčá  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace s mnoha cisly ve volbe kurzu
    Registrace   95236485687125  Lia     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace beze jmena
    Registrace   3    ""     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace s dlouhym jmenem
    Registrace   1  ailailailailaialajibfzžýřáčíšéhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhářýžýřžřášíšéěéěáýřžrýřčzřžčýáší     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   200

registrace se specialnimi znaky ve jmenu
    Registrace   2  L@{###Đ]Đ\|€$     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace s cisly misto textu ve jmenu
    Registrace   3  526489696324415632348     Moravcová Egemová   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   200

registrace bez prijmeni
     Registrace     1   Lia     ""   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace s cisly misto textu v prijmeni
    Registrace   2  Lia     9523695124747869363414456   kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   200

registrace se specialnimi znaky v prijmeni
     Registrace   3  Lia     M\|#&@{]ˇ~^  kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace s dlouhym prijmenim
     Registrace   1  Lia     moravoravoravpdkfdzjsdhsgdzfjskaidgfsjsakamdxbcgsdjaskajudsgdzteuashjajyjndgdfgshajauiihabsgdzhfz gggggggggggggggggggggggg  kasslovalia@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   200

registrace bez mailu
    Registrace   3  Lia     Moravcová Egemová   ""   737926673   fyz     Kostelec nad Labem   1   null    true   400

registrace s dlouhym nickem v mailu
     Registrace   1  Lia     Moravcová Egemová   kaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssssssssllloooooooooooooooooovaaaaaaaaa@gmail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace s dlouhou domenou v mailu
     Registrace   2  Lia     Moravcová Egemová   kasslovalia@gmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiail.com   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace s dlouhou koncovkou v mailu
    Registrace   3  Lia     Moravcová Egemová   kasslovalia@gmail.coooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooom   737926673   fyz     Kostelec nad Labem   1   null    true   500

registrace bez telefonu
    Registrace   2  Lia     Moravcová Egemová   kasslovalia@gmail.com   ""   fyz     Kostelec nad Labem   1   null    true   400

registrace s textem misto cisel
    Registrace   2  Lia     Moravcová Egemová   kasslovalia@gmail.com   uuuuuuuuulllu   fyz     Kostelec nad Labem   1   null    true   500



*** Keywords ***

Registrace
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${response_code}

    # vytvoření těla (body) zprávy

    ${json}=     Catenate      {"targetid":"","kurz":"${course}",
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

 #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status should be    ${response_code}
    #nebo
    Should Be Equal As Strings	    ${resp.status_code}     ${response_code}

    #vyhodnocení JSONu klíč response
    Dictionary Should Contain Item	${resp.json()}          response    ${response_code}
    #nebo
    Should Contain      ${resp.json()}[response]            ${response_code}