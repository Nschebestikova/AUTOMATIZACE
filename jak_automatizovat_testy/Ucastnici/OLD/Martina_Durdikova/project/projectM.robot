*** Settings ***
Library   Browser  timeout=10s
Resource  Data_and_Config/TestData.robot
Resource  Data_and_Config/Configuration.robot

Test Setup  Open webpage

*** Test Cases ***
Prihlasenie na rohlik.cz pomocou invalid PSWD - negativny scenar
  Invalid Login na rohlik.cz  ${validMail}  ${invalidPSW}

Prihlasenie na rohlik.cz - pozitivny scenar
  Valid Login na rohlik.cz  ${validMail}  ${validPSW}
  [Teardown]  Logout Keyword

Odhlasenie z rohlik.cz
  Valid Login na rohlik.cz  ${validMail}  ${validPSW}
  [Teardown]  Logout Keyword

Pridanie tovaru do kosika
  Valid Login na rohlik.cz  ${validMail}  ${validPSW}
  Pridat tovar              ${itemNo1}
  Pridat tovar              ${itemNo2}
  Vysypat kos               ${itemNo1}
  [Teardown]                Logout Keyword

Pridanie tovaru do kosika pomocou id
  Valid Login na rohlik.cz  ${validMail}  ${validPSW}
  Pridat tovar              ${itemNo1}
  [Teardown]                Vysypat kos    ${itemNo1}

Vysypanie tovaru z kosika
  Valid Login na rohlik.cz  ${validMail}  ${validPSW}
  Pridat tovar              ${itemNo1}
  Vysypat kos               ${itemNo1}
  
#Odstranenie jednej polozky, ked sme pridali len jednu polozku
#  Valid Login na rohlik.cz   ${validMail}  ${validPSW}
#  Pridat tovar               ${itemNo1}
#  Odstranit jednu polozku    ${itemNo1}

*** Keywords ***
Open webpage
  New Browser               chromium                headless=false
  New Page                  ${URL}
  Browser.Get Title         ==    ${TEXT_MainTitle}
  Click                     ${SEL_Cookie_AllowAll}
  sleep                     2
  Click                     ${SEL_HeaderLogin}
  Set Strict Mode           False

Invalid Login na rohlik.cz
  [Arguments]          ${email}                     ${wrongPSW}
  Type Text            ${SEL_Email}                 ${validMail}
  Type Text            ${SEL_Password}              ${invalidPSW}
  click                ${SEL_BtnSignIn}
  Browser.Get Text     ${SEL_NotifContent}      ==  ${ERROR_TEXT_IncorrectEmailOrPwd}
#  Browser.Get Text     data-test=notification-content >> nth=1  ==  Zadal(a) jste nesprávný e-mail nebo heslo.  #pridana hlaska o statnom sviatku

Valid Login na rohlik.cz
  [Arguments]          ${validEmail}                ${PSW}
  Type Text            ${SEL_Email}                 ${validMail}
  Type Text            ${SEL_Password}              ${validPSW}
  click                ${SEL_BtnSignIn}
  ${text} =            Browser.Get Text             xpath=//*[@id="headerUser"]/div
  log to console       ${text}
  Take Screenshot

Pridat tovar
  [Arguments]               ${tovarHladam}
  Type Text                 ${SEL_SearchGlobal}      ${tovarHladam}
  Sleep                     10s
  Click                     text="${TEXT_FillinCart}" >> nth=0
#  Click                     data-product-id="1362825" >> nth=0
# Click                     data-test=btnAdd >> nth=0     #clickCount=4  #nejde mi to
  Sleep                     10s
  Hover                     ${SEL_DT_Cart}
  Browser.Get Text          ${SEL_RedirectToCart}  ==  ${TEXT_ToOrder}

Vysypat kos
  [Arguments]          ${tovar}
  Type Text            ${SEL_SearchGlobal}      ${tovar}
  Sleep                10s
  Click                text="${TEXT_FillinCart}"
  Click                ${SEL_DT_Cart}
  Sleep                10s
  Click                text="${TEXT_EmptyCart}"
  Browser.Get Text     css=.CartReview__emptySubTitle  contains  ${TEXT_EmptyCartReview}

Odstranit jednu polozku
  [Arguments]          ${tovarOdstran}
  Type Text            ${SEL_SearchGlobal}      ${tovarOdstran}
  Sleep                10s
  Click                text="${TEXT_FillinCart}"
  Click                ${SEL_DT_Cart}
  Sleep                10s
  Click                ${SEL_IconMinus} >> nth=1
  Browser.Get Text     ${SEL_HeaderPrice}  ==  0,00\xa0Kč

Logout Keyword
  Click                     ${SEL_HeaderUser}
  BuiltIn.Sleep             3s
  Click                     ${SEL_LogoutBTN}


