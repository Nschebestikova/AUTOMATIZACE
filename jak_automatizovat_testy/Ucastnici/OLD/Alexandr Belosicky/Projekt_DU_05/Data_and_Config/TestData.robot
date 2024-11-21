# Tento soubor obsahuje všechny Testovací Data k Projekt_DU_05

*** Variables ***
#přihlašovací údaje
${corr_user_name}                               devopor490@horsgit.com
${corr_password}                                devopor490@
${incorr_user_name}                             gblabla@bla.com
${incorr_password}                              incorrblablapass
${incorr_user_name_format_missing_at}           aaa.bbb.cz
${incorr_user_name_format_missing_beginning}    @b.c
${incorr_user_name_format_missing_domain}       a@.c
${incorr_user_name_format_missing_domain_end}   a@b.

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_Uspesne_prihlaseny}          JT
${TEXT_Odhlaseny}                   Účet
${TEXT_CartToOrder}                 K objednávce

#Error strings
${ERROR_TEXT_IncorrectEmail}         Zadejte platný email
${ERROR_TEXT_MissingEmail}           Email je povinný
${ERROR_TEXT_MissingPassword}        Heslo je povinné

#SELEKTOR pro CookiesDialogButton
${SEL_CookiesDialogButtonAllowAll}       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#SELEKTOR pro IconCloseX
${SEL_IconCloseX_state}                      data-test=IconCloseX

#SELEKTOR pro Header
${SEL_HeaderUserIcon}       data-test=header-user-icon
${SEL_HeaderMainLogo}       data-test=logo-main

#SELEKTORY pro Login
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_LoginLink}            data-test=btnSignIn


#SELEKTORY pro chybové hlášky při loginu
${SEL_LoginInvalidEmailMessage}        css=[data-test=user-login-form-email] [data-test=validation-message]
${SEL_LoginMissingEmailMessage}        css=[data-test=user-login-form-email] [data-test=validation-message]
${SEL_LoginMissingPwd}                 css=[data-test=user-login-form-password] [data-test=validation-message]

#SELEKTORY pro Nákupní košík
${SEL_Cart}                            data-test=cart
${SEL_AddToCart}                       data-test=btnAdd
${SEL_RedirectToCart}                  data-test=cart-redirectToCart
${SEL_DeliveryMapCloseButton}          css=[data-test=modal-close-button] [data-test=IconCloseX]
${SEL_ClearCartButton}                 data-test=cart-review-clearCartButton

#SELEKTORY pro Logout
${SEL_LogoutButton}         data-test=user-box-logout-button





