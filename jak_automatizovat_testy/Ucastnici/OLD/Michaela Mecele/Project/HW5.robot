*** Settings ***
Library  Browser
Library    Telnet
Resource   TestData/ProjectData.robot
Suite Setup       OpenBrowserPageAndAcceptCookies
Suite Teardown    Close Browser
Test Setup        Set Browser Timeout       30s
Test Teardown     New Page                                        ${PageAdress}

*** Test Cases ***
LogInPosGoodMailGoodPassword
    LogIn               ${emailGood}          ${passwordGood}      1
    LogOut

LogInPosGoodMailWithLargeFirstCharacterGoodPassword
    LogIn               ${emailGoodBigFirstCHarakter}          ${passwordGood}     1
    LogOut

LogInNegGoodMailWithWrongSizeOfFirstCharacterInPassword
    LogIn               ${emailGood}          ${passwordSmallFirstCHaracter}    2

LogInNegCAPSLOCK
    LogIn               ${emailCapsLock}          ${passwordCapsLock}    2

LogInNegUsesÍÁInPassword
    LogIn               ${emailGood}          ${passwordNabodenicka}    2

LogInNegUsesÍÁInMailAndPassword
    LogIn               ${emailNabodenicka}          ${passwordGood}    4

LogInNegUndefined
    LogIn               ${emailEmpty}          ${passwordEmpty}    3

LogInNegWrongEmailFormat
    LogIn               ${emailWrongFormat}          ${passwordGood}    4

LogOutTest
    LogIn               ${emailGood}          ${passwordGood}      1
    LogOut

BasketPosUserWithLogIn
     LogIn                  ${emailGood}          ${passwordGood}         1
     PlaceToTheBasket       ${Category}           ${2ndCategory}          ${UsArcticle}        1      True
     RemoveFromTheBasket
     LogOut

BasketPosUserWithoutLogIn
    PlaceToTheBasket        ${Category}       ${2ndCategory}     ${UsArcticle}        2         True
    RemoveFromTheBasket

BasketNegTooMuchWithLogIn
    LogIn                   ${emailGood}      ${passwordGood}      1
    PlaceToTheBasket        ${Category}       ${2ndCategory}       ${UsArcticle}         2        True
    PlaceToTheBasket        ${Category}       ${2ndCategory}       ${UsArcticle}         2        False
    Click                   ${PathIconBasket}
    RemoveFromTheBasket
    LogOut

BasketNegTooMuchWithoutLogIn
    PlaceToTheBasket    ${Category}       ${2ndCategory}     ${UsArcticle}        2        True
    PlaceToTheBasket    ${Category}       ${2ndCategory}     ${UsArcticle}        2        False
    Click               ${PathIconBasket}
    RemoveFromTheBasket

BasketIsEmptyWithLogIn
    LogIn               ${emailGood}          ${passwordGood}      1
    Click               ${PathIconBasket}
    CheckEmptyBasket
    LogOut

BasketIsEmptyWithoutLogIn
    Click                                           ${PathIconBasket}
    CheckEmptyBasket

*** Keywords ***
LogIn
    [Arguments]                                     ${text1}   ${text2}   ${expectedSuccess}=True
    Hover                                           ${PathIconUser}
    Click                                           ${LogInText}
    Type Text                                       ${PathEmailInput}      ${text1}
    Type Text                                       ${PathPasswordInput}     ${text2}
    Wait For Elements State                         ${LogInButton1}    visible
    Click                                           ${LogInButton1}
    IF          ${expectedSuccess}==1
             UserIsLoged
    ELSE IF     ${expectedSuccess}==2
            Type Text                                       ${PathPasswordInput}     ${text2}
            Wait For Elements State                         ${LogInButton1}    visible
            Click                                           ${LogInButton1}
            UserIsNotLoged
    ELSE IF     ${expectedSuccess}==3
            Type Text                                       ${PathPasswordInput}     ${text2}
            Wait For Elements State                         ${LogInButton1}    visible
            Click                                           ${LogInButton1}
            UserIsNotLoged2
    ELSE IF      ${expectedSuccess}==4
            UserIsNotLoged3
    END

LogOut
    Hover                       ${PathIconUser}
    Wait For Elements State     ${PathWelcomeText}        visible
    Click                       ${LogOutButton}
    Take Screenshot

PlaceToTheBasket
    [Arguments]                 ${Category1}   ${Category2}   ${article}      ${amount}     ${Exp}
    Click                       ${Category1}
    Click                       ${Category2}
    Click                       ${article}
    ${element}=     Get Element     ${PathOrderQuantity}
    Select Options By               ${element}          value          ${amount}
    Click                           ${BuyButton}
    IF  ${Exp} == True
        Click                       ${BasketButton}
    ELSE
        ${error}           Get Text     ${PathPopUpError}
        Should Be Equal    ${error}     ${ErrorStringTooMuch}
        Click              ${PathCloseErrorString}
        Log To Console     ${TooMuchString}
    END

RemoveFromTheBasket
          ${Basket}           Get Text        ${PathWelcomeTextFullBasket}
          Should Be Equal     ${Basket}       ${FullBasketString}
          Log To Console      ${PathWelcometextFullBasket}
          Click               ${PathDeleteArticleBasket}

CheckEmptyBasket
        ${Basket}           Get Text            ${PathWelcometextEmptyBasket}
        Should Be Equal     ${Basket}           ${EmptyBasketString}
        Log To Console      ${EmptyBasketMyString}

UserIsNotLoged
        Wait For Elements State       ${PathUnderPasswordLogIn}     visible
        ${error}          Get Text    ${PathUnderPasswordLogIn}
        Should Be Equal   ${error}    ${ErrorString1}

UserIsNotLoged2
        Wait For Elements State       ${PathUnderPasswordLogIn}     visible
        ${error}          Get Text    ${PathUnderPasswordLogIn}
        Should Be Equal   ${error}    ${ErrorString2}

UserIsNotLoged3
        Wait For Elements State       ${PathUnderEmailLogIn}     visible
        ${error}          Get Text    ${PathUnderEmailLogIn}
        Should Be Equal   ${error}    ${ErrorString3}

UserIsLoged
        Wait For Elements State                         ${LogInButton1}           hidden
        Hover                                           ${PathIconUser}
        ${welcome}      Get Text                        ${PathWelcomeText}
        Log To Console                                  ${welcome}
        Should Contain    ${welcome}    ${WelcomeText}

OpenBrowserPageAndAcceptCookies
    New Browser                                     ${Browser}            headless=false
    New Page                                        ${PageAdress}
    ${titulek}                                      Get Title
    Log To Console                                  ${titulek}
    Get Title   ==                                  ${TitleString}
    Click                                           ${PathAcceptCookies}
