#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#prihlasovacie udaje
${validMail}    rohlikrohlikovsky@seznam.cz
${validPSW}     Rohlikovac1234!
${invalidPSW}   xxx
${invalidMail}  rohlikrohlikovsk@seznam.cz

#tovar
${itemNo1}      Máslo
${itemNo2}      Pivo

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_EmptyCartReview}             Zboží můžete
${TEXT_FillinCart}                  Do košíku
${TEXT_Prihlasit}                   Účet
${TEXT_ToOrder}                     K objednávce

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login
${SEL_HeaderLogin}          data-test=header-user-icon     #dříve bylo id=headerLogin
${SEL_HeaderLoginErrorTxt}  css=[data-type=negative]       # selektor pro výběr chybové hlášky při neúspěšném přihlášení
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
#${SEL_LoginFormEmail}       data-test=user-login-form-email
#${SEL_LoginFormPwd}         data-test=user-login-form-password
${SEL_Email}                id=email
${SEL_Password}             id=password
${SEL_BtnSignIn}            data-test=btnSignIn
#${SEL_BtnSignIn}            css=[data-test=btnSignIn]
${SEL_NotifContent}         data-test=notification-content


#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
#Tohle nebude fungovat, je nutné dělat selektror po částech
#${SEL_BtnAddId}             css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
#${SEL_BtnPlusId}            css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]
#Je třeba použít
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap

${SEL_BtnMinus}             data-test=btnMinus
${SEL_IconMinus}            data-test=IconMinus
${SEL_HeaderPrice}          data-test=headerPrice

#SELEKTORY pro Logout
${SEL_HeaderUser}           id=headerUser
${SEL_LogoutBTN}            data-test=user-box-logout-button

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_DT_Cart}              data-test=cart
${SEL_CartItem}             data-test=cart-item
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=
${SEL_RedirectToCart}       data-test=cart-redirectToCart
${SEL_RemoveBasket}         [aria-label^="Odstranit z košíku"]

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline