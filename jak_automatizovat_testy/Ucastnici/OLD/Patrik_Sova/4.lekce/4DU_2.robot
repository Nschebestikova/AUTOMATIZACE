
*** Settings ***
Metadata    Author    Patrik Sova
Metadata    Purpose   a good is in the cart
Metadata    Created   3.1.2024

Library  Browser

*** Variables ***
${URL}      https://www.alza.cz/epson-workforce-pro-wf-3820dwf-d6204051.htm
${URL2}     https://www.alza.cz/Order1.htm

*** Test Cases ***
Kontrola1
    prazdy_kosik_1      yes
Kontrola2
    do_kosiku
    odeber_zbozi        yes


*** Keywords ***

prazdy_kosik_1
    [Arguments]     ${text}
    New Browser           CHROMIUM          headless=false
    New Page              ${URL2}
    Get Title            *=                 Nákupní košík
    Click               css=.btnx.cookies-info__button.js-cookies-info-accept

    Get Text            //*[@id="blocke"]/div/span      ==   Jsem tak prázdný...

    IF    "${text}" == "yes"
       Get Text            //*[@id="blocke"]/div/span      ==   Jsem tak prázdný...
       Log To Console    !!!Kosik je prazdny!!!
    ELSE

       Log To Console    !!!V kosiku neco je, chyba!!!
    END

do_kosiku

    New Browser           CHROMIUM          headless=false
    New Page              ${URL}

    Click               css=.btnx.cookies-info__button.js-cookies-info-accept
    Get Title            *=                 Epson WorkForce
    Click                css=.btnx.new.green.buy.js-buy-button
    Get Text     css=[class=productInfo__texts__message]       ==            Zboží bylo přidáno do košíku
    Log To Console    !!!Zboží je v košíku!!!
    Take Screenshot
odeber_zbozi
    [Arguments]     ${text}
    Click           id=varBToBasketButton
    Click           css=.countMinus
    Click           css=.btnx.normal.green.ok

    IF    "${text}" == "yes"
       Get Text            //*[@id="blocke"]/div/span      ==   Jsem tak prázdný...
       Log To Console    !!!Kosik je znovu prazdny!!!
    ELSE

       Log To Console    !!!V kosiku neco je, chyba!!!
    END

