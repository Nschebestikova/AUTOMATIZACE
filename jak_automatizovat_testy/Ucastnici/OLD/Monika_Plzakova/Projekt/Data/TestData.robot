#testovaci data pro rohlik.cz

*** Variables ***
#uzivatele
${user1_email}          foniplz@seznam.cz
${user1_password}       HesloHeslo11

#selektory pro prihlaseni
${sel_EmailInput}       id=email
${sel_PwdInput}         id=password
${sel_LoginAccountBtn}  data-test=header-user-icon
${sel_LoginBtn}         data-test=btnSignIn

#selektory pro prihlaseneho uzivatele
${sel_UserBtn}          id=headerUser
${sel_NotificationBtn}  data-test=notification-bell
${sel_LogoutBtn}        data-test=user-box-logout-button
${sel_UserInfoBtn}      data-test=my-account-button

#selektory pro produkty
${sel_ProductListTitle}     data-test=productList_title

#selektory pro košík
${sel_CartBtn}                data-test=cart-header
${sel_ToTheCartBtn}           data-test=cart-redirectToCart
${sel_CreateShoppingListBtn}  data-test=shopping-lists
