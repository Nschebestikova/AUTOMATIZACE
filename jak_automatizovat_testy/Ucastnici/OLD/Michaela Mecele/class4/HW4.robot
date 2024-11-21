*** Settings ***
Library  Browser

*** Test Cases ***
LogInPosGoodMailGoodPassword
    LogIn            ${emailGood}          ${passwordGood}      1

LogInPosGoodMailWithLargeFirstCharacterGoodPassword
    LogIn            ${emailGoodBigFirstCHarakter}          ${passwordGood}     1

LogInNegGoodMailWithWrongSizeOfFirstCharacterInPassword
    LogIn            ${emailGood}          ${passwordSmallFirstCHaracter}    2

LogInNegCAPSLOCK
    LogIn            ${emailCapsLock}          ${passwordCapsLock}    2

LogInNegUsesÍÁInPassword
    LogIn            ${emailGood}          ${passwordNabodenicka}    2

LogInNegUsesÍÁInMailAndPassword
    LogIn            ${emailNabodenicka}          ${passwordGood}    4

LogInNegUndefined
    LogIn            ${emailEmpty}          ${passwordEmpty}    3

LogInNegWrongEmailFormat
    LogIn            ${emailWrongFormat}          ${passwordGood}    4

LogOutTest
    LogIn            ${emailGood}          ${passwordGood}      1
    LogOut

BasketPosUserWithLogIn
     LogIn               ${emailGood}          ${passwordGood}      1
     PlaceToTheBasket    text="Káva"       text="Kávovary"       text="Esperto2 Milk, Granite Black"        1      True
     RemoveFromTheBasket   

BasketPosUserWithoutLogIn
    New Browser                                     chromium            headless=false
    New Page                                        https://tchibo.cz
    ${titulek}                                      Get Title
    Log To Console                                  ${titulek}
    Get Title   ==                                  Tchibo - káva, móda, nábytek a více | Tchibo.cz
    Click                                           //*[@id="onetrust-accept-btn-handler"]
    PlaceToTheBasket    text="Káva"       text="Kávovary"     text="Esperto2 Milk, Granite Black"        2         True
    RemoveFromTheBasket

BasketNegTooMuchWithLogIn
    LogIn               ${emailGood}          ${passwordGood}      1
    PlaceToTheBasket    text="Káva"       text="Kávovary"     text="Esperto2 Milk, Granite Black"         2        True
    PlaceToTheBasket    text="Káva"       text="Kávovary"     text="Esperto2 Milk, Granite Black"         2        False
    Click               //*[@id="c-header2020-icons-link-cart"]
    RemoveFromTheBasket

BasketNegTooMuchWithoutLogIn
    New Browser                                     chromium            headless=false
    New Page                                        https://tchibo.cz
    ${titulek}                                      Get Title
    Log To Console                                  ${titulek}
    Get Title   ==                                  Tchibo - káva, móda, nábytek a více | Tchibo.cz
    Click                                           //*[@id="onetrust-accept-btn-handler"]
    PlaceToTheBasket    text="Káva"       text="Kávovary"     text="Esperto2 Milk, Granite Black"         2        True
    PlaceToTheBasket    text="Káva"       text="Kávovary"     text="Esperto2 Milk, Granite Black"         2        False
    Click                //*[@id="c-header2020-icons-link-cart"]
    RemoveFromTheBasket

BasketIsEmptyWithLogIn
    LogIn               ${emailGood}          ${passwordGood}      1
    Click               //*[@id="c-header2020-icons-link-cart"]
    CheckEmptyBasket

BasketIsEmptyWithoutLogIn
    New Browser                                     chromium            headless=false
    New Page                                        https://tchibo.cz
    ${titulek}                                      Get Title
    Log To Console                                  ${titulek}
    Get Title   ==                                  Tchibo - káva, móda, nábytek a více | Tchibo.cz
    Click                                           //*[@id="onetrust-accept-btn-handler"]
    Click                                           //*[@id="c-header2020-icons-link-cart"]
    CheckEmptyBasket

*** Keywords ***
LogIn
    [Arguments]                                     ${text1}   ${text2}   ${expectedSuccess}=True
    New Browser                                     chromium            headless=false
    New Page                                        https://tchibo.cz
    ${titulek}                                      Get Title
    Log To Console                                  ${titulek}
    Get Title   ==                                  Tchibo - káva, móda, nábytek a více | Tchibo.cz
    Click                                           //*[@id="onetrust-accept-btn-handler"]
    Hover                                           //*[@id="c-header2020-icon--user"]
    Click                                           text="Přihlásit se"
    Type Text                                       //input[@type="email"]      ${text1}
    Type Text                                       //input[@type="password"]     ${text2}
    Wait For Elements State                         text="Přihlásit"    visible
    Click                                           text="Přihlásit"
    IF          ${expectedSuccess}==1
             UserIsLoged
    ELSE IF     ${expectedSuccess}==2
            Type Text                                       //input[@type="password"]     ${text2}
            Wait For Elements State                         text="Přihlásit"    visible
            Click                                           text="Přihlásit"
            UserIsNotLoged
    ELSE IF     ${expectedSuccess}==3
            Type Text                                       //input[@type="password"]     ${text2}
            Wait For Elements State                         text="Přihlásit"    visible
            Click                                           text="Přihlásit"
            UserIsNotLoged2
    ELSE IF      ${expectedSuccess}==4
            UserIsNotLoged3
    END

LogOut
    Hover                       //*[@id="c-header2020-icon--user"]
    Wait For Elements State     //*[@class="m-salutation-welcometext"]      visible
    Click                       "Odhlásit se"
    Take Screenshot

PlaceToTheBasket
    [Arguments]                 ${Category1}   ${Category2}   ${article}      ${amount}     ${Exp}
    Click                       ${Category1}
    Click                       ${Category2}
    Click                       ${article}
    Sleep    2
    ${element}=     Get Element     xpath=//*[@name='TpSelectOrderQuantity']
    Select Options By               ${element}          value          ${amount}
    Click                           text="Koupit"
    IF  ${Exp} == True
        Click                       text="Nákupní košík"
    ELSE
        ${error}           Get Text     xpath=//*[@class="pdp-add-to-cart-modal__notification--error"]
        Should Be Equal    ${error}     Bohužel nemůžete v rámci jednoho nákupu zakoupit více než max. 2 kusů tohoto artiklu. V případě zájmu o objednání většího množství se neváhejte obrátit na náš zákaznický servis.
        Click              //*[@class="tp-modal-close"]
        Log To Console     It is too much
    END

RemoveFromTheBasket
          ${Basket}     Get Text            xpath=//*[@data-locator="cart_your_cart_title"]
          Should Be Equal     ${Basket}       Váš nákupní košík
          Log To Console      The Basket Contains Something
          Click               xpath=//*[@icon-name="delete"]

CheckEmptyBasket
        ${Basket}           Get Text            xpath=//*[@class="tp-display-3"]
        Should Be Equal     ${Basket}           Váš nákupní košík neobsahuje žádné položky.
        Log To Console      The Basket Is Empty

UserIsNotLoged
        Wait For Elements State       //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]     visible
        ${error}          Get Text    //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
        Should Be Equal   ${error}    Vaše e-mailová adresa a heslo si neodpovídají.

UserIsNotLoged2
        Wait For Elements State       //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]     visible
        ${error}          Get Text    //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
        Should Be Equal   ${error}    Vyplnění tohoto pole je povinné.

UserIsNotLoged3
        Wait For Elements State       //input[@type="email"]/parent::div/following-sibling::div[@class="tp-form-input-message"]     visible
        ${error}          Get Text    //input[@type="email"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
        Should Be Equal   ${error}    Zadejte prosím platnou e-mailovou adresu.

UserIsLoged
        Wait For Elements State                         text="Přihlásit"            hidden
        Hover                                           //*[@id="c-header2020-icon--user"]
        ${welcome}      Get Text                        //*[@class="m-salutation-welcometext"]
        Log To Console                                  ${welcome}
        Should Contain    ${welcome}    Vítejte
        
*** Variables ***
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
