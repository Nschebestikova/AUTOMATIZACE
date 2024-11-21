*** Variables ***
${url}                 https://rohlik.cz
${cookies}             id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#Page logo
${SEL_PageLogo}         data-test=logo-main

#User
${USER_NAME}               ucet.testing@seznam.cz
${PASSWORD}                tajne@heslo&
${invalid_PASSWORD}        abcdefgh

#Login
${SEL_HeaderLogin}       data-test=header-user-icon
${SEL_InputEmail}        id=email
${SEL_InputPassword}     id=password
${SEL_LoginBtn}          data-test=btnSignIn
${SEL_NotifContent}      data-test=notification-content

#Logout
${SEL_HeaderUser}           id=headerUser
${SEL_LogoutButton}         data-test=user-box-logout-button
${SEL_NotifBell}            data-test=notification-bell

#Chybove hlasky
${SEL_INVALIDLOGIN}           Zadal(a) jste nesprávný e-mail nebo heslo.

#Strings
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_EmptyCartReview}             Zboží můžete
${TEXT_FillinCart}                  Do košíku
${TEXT_Prihlasit}                   Účet
${TEXT_ToOrder}                     K objednávce

#Zbozi
${Item_1}             tvaroh
${Item_2}             brambory

#SELEKTORY pro zboží
${SEL_SearchItem}           id=searchGlobal
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_BtnMinus}             data-test=btnMinus
${SEL_ProductID}            data-product-id=1306511
${SEL_CssForAdding}         .amountCounterWrap

#Kosik
${SEL_CartIcon}             data-test=IconCart
${SEL_FinishOrder}          data-test=cart-redirectToCart  == K objednávce
${SEL_EmptyCart}            data-gtm-button=clear-cart
${SEL_EmptyCard_Text}       id=cartReviewMainTitle  == Košík funguje i jako nákupní seznam

#Vyskakovací okno
${SEL_CloseBtn}             data-test=modal-close-button