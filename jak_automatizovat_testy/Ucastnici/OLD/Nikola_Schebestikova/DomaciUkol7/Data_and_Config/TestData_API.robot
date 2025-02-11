*** Variables ***
${url}		    http://testovani.kitner.cz
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}
${URLREGISTRLIST}   http://testovani.kitner.cz/regkurz/list.php


#JSON BODY - OBSAH TESTŮ - pro testy!!!
${jsonBODY_OK}         {"targetid":"","kurz":"2","name":"Nikola","surname":"Schebestiková","email":"zkouska@test.cz","phone":"+420606505202","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","comment":"nic","souhlas":true}
${jsonBODY_PHONE}       {"targetid":"","kurz":"2","name":"Nikola","surname":"Nováková","email":"n.schebestikova@seznam.cz","phone":"606202","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","comment":Děkuji,"souhlas":true}
${jsonBODY_PHONE_EMPTY}    {"targetid":"","kurz":"2","name":"Nikola","surname":"Nováková","email":"n.schebestikova@seznam.cz","phone":"{empty}","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","comment":Děkuji,"souhlas":true}
${jsonBODY_EMAIL}          {"targetid":"","kurz":"2","name":"Nikola","surname":"Nováková","email":"nschebestikova@seznam","phone":"null","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","comment":Děkuji,"souhlas":true}
${jsonBODY_NOKURZ}      {"targetid":"","kurz":"","name":"Nikola","surname":"Nováková","email":"nschebestikova@seznam","phone":"null","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","comment":Děkuji,"souhlas":true}
${jsonBODY_NOTGOOD}        {"targetid":"",kurz:"2","name":"Nikola","surname":"Nováková","email":nschebestikova@seznam,"phone""null","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","coment":Děkuji,"souhlas":true}
${jsonBODY_EMPTY_E_EMAIL}    {"targetid":"","kurz":"2","name":"Nikola","surname":"Nováková","email":nschebestikova@seznam,"phone":"605315082","person":"fyz","address":"Ostrava","ico":"233564238","count":"1","coment":Děkuji,"souhlas":true}


# Jak zapsat do JSONu nic (null)  comment=${EMPTY} - viz materiály

# USER - případně vzít data odtud a vyplnit postupně do BODY json...
${email_1}  zkouska@zkouska.cz
${name}     Nikola
${surname}  Schebestiková
${phone}    +420606603033
${response_string}      ${email_1}


#NÁPAD JE VTVOŘIT TO JSON BODY DO KEYWORDS POD SEBOU, JAKO KLASICKÝ JSON...


#Strings CHECKING - ověření textací NA WEBU
${TEXT_Title}            Testování - Přehled kurzů
${TEXT_Prihlasit}        Přihlásit se

#Číselník chybové ODPOVĚDI
${error_resp}           text="Registrace zákazníka zamítnuta: Nesprávně vyplněné údaje."

