*** Variables ***
#UserInputs
${emailGood}                      testovaci@gmail.com
${passwordGood}                   1234Testovani
${emailGoodBigFirstCHarakter}     Testovaci@gmail.com
${passwordSmallFirstCHaracter}    1234testovani
${emailCapsLock}                  TESTOVACI@GMAIL.COM
${passwordCapsLock}               1234TESTOVANI
${emailNabodenicka}               testovací@gmail.com
${passwordNabodenicka}            1234Testování
${emailWrongFormat}               testovacigmail.com
${emailEmpty}                     ${EMPTY}
${passwordEmpty}                  ${EMPTY}

#Strings
${Browser}                          chromium
${PageAdress}                       https://tchibo.cz
${TitleString}                      Tchibo - káva, móda, nábytek a více | Tchibo.cz
${UsArcticle}                       "Esperto2 Milk, Granite Black"
${Category}                         "Káva"
${2ndCategory}                      "Kávovary"
${LogOutButton}                     "Odhlásit se"
${LogInText}                        text="Přihlásit se"
${LogInButton1}                     "Přihlásit"
${WelcomeText}                      Vítejte
${BuyButton}                        "Koupit"
${BasketButton}                     "Nákupní košík"
${EmptyBasketString}                Váš nákupní košík neobsahuje žádné položky.
${WelcometextFullBasketString}      The Basket Contains Something
${FullBasketString}                 Váš nákupní košík
${TooMuchString}                    It is too much
${EmptyBasketMyString}              The Basket Is Empty

#Error Strings
${ErrorString1}                  Vaše e-mailová adresa a heslo si neodpovídají.
${ErrorString2}                  Vyplnění tohoto pole je povinné.
${ErrorString3}                  Zadejte prosím platnou e-mailovou adresu.
${ErrorStringTooMuch}            Bohužel nemůžete v rámci jednoho nákupu zakoupit více než max. 2 kusů tohoto artiklu. V případě zájmu o objednání většího množství se neváhejte obrátit na náš zákaznický servis.

#Selectors
${PathAcceptCookies}            //*[@id="onetrust-accept-btn-handler"]
${PathEmailInput}               //input[@type="email"]
${PathPasswordInput}            //input[@type="password"]
${PathUnderPasswordLogIn}       //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
${PathUnderEmailLogIn}          //input[@type="email"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
${PathWelcomeText}              //*[@class="m-salutation-welcometext"]
${PathIconUser}                 //*[@id="c-header2020-icon--user"]
${PathIconBasket}               //*[@id="c-header2020-icons-link-cart"]
${PathDeleteArticleBasket}      //*[@icon-name="delete"]
${PathWelcomeText}              //*[@class="m-salutation-welcometext"]
${PathCloseErrorString}         //*[@class="tp-modal-close"]
${PathOrderQuantity}            //*[@name='TpSelectOrderQuantity']
${PathWelcometextEmptyBasket}   //*[@class="tp-display-3"]
${PathWelcomeTextFullBasket}    //*[@data-locator="cart_your_cart_title"]
${PathPopUpError}               //*[@class="pdp-add-to-cart-modal__notification--error"]

#JSONS
*** Variables ***
${url}  http://testovani.kitner.cz/
${app}  regkurz/formsave.php
${urlapp}   ${url}${app}
${jsonOK}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonOK+420}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"+420777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyCourse}  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonHightCourse}  {"targetid":"","kurz":"5","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyName}  {"targetid":"","kurz":"3","name":"","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonTooLongName}  {"targetid":"","kurz":"3","name":"Janjendahonzicekhonzajenicekbezmarenkysamsamotinkysamecek","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonWrongEmailFormat}  {"targetid":"","kurz":"3","name":"Petr","surname":"Tester","email":"jan.teserdata.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyEmail}  {"targetid":"","kurz":"3","name":"Petr","surname":"Tester","email":"","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptySurname}  {"targetid":"","kurz":"3","name":"Petr","surname":"","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyTel}  {"targetid":"","kurz":"3","name":"Petr","surname":"Tester","email":"jan.teser@data.cz","phone":"","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonShortTel}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonTooLongTel}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"7771231325667868699","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyPer}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonOKPerPrav}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"pra","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyAdress}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"","ico":"27232433","count":"1","comment":"nic","souhlas":true}
${jsonEmptyIco}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"","count":"1","comment":"nic","souhlas":true}
${jsonNoPermit}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":false}
${jsonEmptyComent}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"","souhlas":true}
${jsonShortIco}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"272324","count":"1","comment":"nic","souhlas":true}
${jsonTooLongIco}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433657656445767","count":"1","comment":"nic","souhlas":true}
${jsonStringIco}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"nejakeico","count":"1","comment":"nic","souhlas":true}
${jsonEmptyCount}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"","comment":"nic","souhlas":true}
${jsonNullCount}  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"0","comment":"nic","souhlas":true}

#variablesloginkitner
${url2}      http://testovani.kitner.cz/
${app2}      /login_app/userauth.php
${urlapp2}   ${url2}${app2}
${NAMEsmalladmin}   admin
${NAMEfirstlargeadmin}  Admin
${NAMEcapslockadmin}  ADMIN
${NAMEnabodenickaadmin}    admín
${NAMEsmallnovak}   novak
${NAMEfirstlargenovak}  Novak
${NAMEcapslocknovak}  NOVAK
${NAMEnabodenickanovak}   novák
${Nevyplneno}    ${EMPTY}
${PASSWORDnovakG}   tajnenovak
${PASSWORDnovakFirstLarge}   Tajnenovak
${PASSWORDnovakCapslock}   TAJNENOVAK
${PASSWORDnovakW}   tajnejnovak
${PASSWORDadminW}   tajnejadmin
${PASSWORDnovakNABODENICKA}    tajnénovák
${PASSWORDadminNABODENICKA}     tajnéadmin
${PASSWORDadminSpecial}   tajne@dm!n
${PASSWORDnovakSpecial}   tajnen&vak
${num}      23456575487
${PASSWORDadminG}   tajneadmin
${browserchro}  Chrome
${browsermozz}  Mozzila
${browsersa}    Safari
