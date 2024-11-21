*** Variables ***
${URL}                 https://rohlik.cz
${cookies}             id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#Page logo
${SEL_PageLogo}         data-test=logo-main

#Uzivatel
${USER_NAME}               denisa.sumerauerova@seznam.cz
${PASSWORD}                hesloheslo
${USER1_SHORT}             DS

#Prihlaseni
${SEL_HeaderLogin}       data-test=header-user-icon
${SEL_InputEmail}        id=email
${SEL_InputPassword}     id=password
${SEL_LoginBtn}          data-test=btnSignIn

#Chybove hlasky
${SEL_INVALIDLOGIN}           Zadal(a) jste nesprávný e-mail nebo heslo.

#Strings
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_EmptyCartReview}             Zboží můžete
${TEXT_FillinCart}                  Do košíku
${TEXT_Prihlasit}                   Účet
${TEXT_ToOrder}                     K objednávce

#Zbozi
${Item_1}             banán
${Item_2}             kofola

#SELEKTORY pro zboží
${SEL_SearchItem}           id=searchGlobal
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_ProductID}            data-product-id=733945
${SEL_CssForAdding}         .amountCounterWrap

#Kosik
${SEL_CartIcon}             data-test=IconCart
${SEL_FinishOrder}          data-test=cart-redirectToCart  == K objednávce
${SEL_EmptyCart}            data-gtm-button=clear-cart
${SEL_EmptyCard_Text}       id=cartReviewMainTitle  == Košík funguje i jako nákupní seznam

#Logout
${SEL_HeaderUser}           id=headerUser
${SEL_LogoutButton}         data-test=user-box-logout-button
