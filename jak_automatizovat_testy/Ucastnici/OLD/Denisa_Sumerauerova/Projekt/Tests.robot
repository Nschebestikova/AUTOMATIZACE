*** Settings ***
Library     Browser  timeout=10s

Resource      Ucastnici/Aktualni/Denisa_Sumerauerova/Projekt/TestData.robot
Resource      Ucastnici/Aktualni/Denisa_Sumerauerova/Projekt/Configuration.robot


*** Keywords ***
Open webpage
    New Browser               chromium                headless=false
    New Page                  ${URL}
    Click                     ${cookies}
    Get                       ${SEL_PageLogo}
    Sleep                     5
    Click                     ${SEL_HeaderLogin}
    Set Strict Mode           False

Invalid login
    [Arguments]          ${email}            ${invalid_password}
    Click                ${SEL_HeaderLogin}
    Type Text            ${SEL_InputEmail}                ${email}
    Type Text            ${SEL_InputPassword}             ${invalid_password}
    Click                ${SEL_prihlaseni}
    Browser.Get Text     ${SEL_INVALIDLOGIN}

Login
    [Arguments]         ${email}                ${password}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_InputEmail}       ${email}
    Type Text           ${SEL_InputPassword}    ${password}
    Click               ${SEL_LoginBtn}
    Log to console      ${text}
    Take Screenshot


Add items
    [Arguments]         ${Item_1}
    Type Text           ${Item_1}     ${Item_1}
    Click               ${SEL_ProductID}
    Sleep               5s
    Click               ${SEL_BtnAdd}
    Click               ${SEL_CartIcon}
    Browser.Get Text    ${SEL_FinishOrder}

Remove item
  [Arguments]          ${Item_2}
  Type Text            ${Item_2}      ${Item_2}
  Click                ${SEL_ProductID}
  Sleep                5s
  Click                ${SEL_BtnAdd}
  Click                ${SEL_CartIcon}
  Sleep                5s
  Click                ${SEL_EmptyCart}
  Browser.Get Text     ${SEL_EmptyCard_Text}

Logout
    Click       ${SEL_HeaderUser}
    Click       ${SEL_LogoutButton}



*** Test Cases ***

Test Setup  Open webpage

Login - invalid email
  Login  denisa.sumerauerova@email.cz  hesloheslo


Successfull login
  Login     denisa.sumerauerova@seznam.cz  hesloheslo

Add item
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Add item  banán
  Add item  kofola


Remove item
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Remove item  kofola


Logout
  Login  denisa.sumerauerova@seznam.cz  hesloheslo
  Click                     ${SEL_HeaderUser}
  BuiltIn.Sleep             5s
  Click                     ${SEL_LogoutButton}
