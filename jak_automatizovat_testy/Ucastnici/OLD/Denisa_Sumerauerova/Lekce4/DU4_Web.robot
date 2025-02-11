*** Settings ***
Library     Browser

*** Keywords ***
Open webpage
    New Browser               chromium                headless=false
    New Page                  https://rohlik.cz
    Get                       data-test=logo-main
    Sleep                     5
    Click                     data-test=header-user-icon
    Set Strict Mode           False

Invalid login
    [Arguments]          ${email}            ${invalid_password}
    Type Text            id=email                ${email}
    Type Text            id=password             ${invalid_password}
    Click                data-test=btnSignIn
    Browser.Get Text     data-test=notification-content  ==  Zadal(a) jste nesprávný e-mail nebo heslo.

Login
    [Arguments]         ${email}            ${password}
    Type Text           id=email            ${email}
    Type Text           id=password         ${password}
    Click               data-test=btnSignIn
    Get                 id=headerUser
    Log to console      ${text}
    Take Screenshot


Add items
    [Arguments]         ${search_item}
    Type text           id=searchGlobal     ${search_itemitem}
    Click               data-test=btnAdd
    Sleep               5s
    Hover               data-test=cart
    Browser.Get Text    data-test=cart-redirectToCart  ==  K objednávce

Remove item
  [Arguments]          ${item}
  Type Text            id=searchGlobal      ${item}
  Sleep                5s
  Click                text="Do košíku"
  Click                data-test=cart
  Sleep                5s
  Click                text="Vysypat košík"
  Browser.Get Text     css=.CartReview__emptySubTitle  contains  Zboží

Logout
    Click  data-id=header-user-icon
    Click  data-test=user-box-logout-button



*** Test Cases ***
Login - invalid email
  Open webpage
  Login  denisa.sumerauerova@email.cz  hesloheslo


Successfull login
  Open webpage
  Login     denisa.sumerauerova@seznam.cz  hesloheslo

Add item
  Open webpage
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Add item  Tofu
  Add item  Lilek
  #k dopracování - zatím failed

Remove item
  Open webpage
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Remove item  Tofu
  #k dopracování - zatím failed

Logout
  Open webpage
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Click                     id=headerUser
  BuiltIn.Sleep             5s
  Click                     data-test=user-box-logout-button
  #k dopracování - zatím failed