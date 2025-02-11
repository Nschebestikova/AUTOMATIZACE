*** Settings ***
Library      Browser    timeout=18s
Resource     Data/TestData.robot
Resource     Data/Configuration.robot

Suite Setup       Open Browser    https://www.rohlik.cz/vitejte    Chromium
Suite Teardown    Close Browser 

*** Keywords ***

Browser Settings
    New Browser         chromium    headless=false
    New Page            ${url}
    Click               ${cookies}
    Get Text            ${SEL_PageLogo}
    Set Strict Mode     False
    Take Screenshot
    

Login
    [Arguments]         ${email}      ${heslo}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_InputEmail}  ${email}
    Type Text           ${SEL_InputPassword}  ${heslo}
    Click               ${SEL_LoginBtn}
    Take Screenshot

Logout
    Click               ${SEL_HeaderUser}
    Sleep               2
    Click               ${SEL_LogoutButton}
    Take Screenshot

Přidat do košíku
    [Arguments]          ${Item_1}
    Type Text            ${SEL_SearchItem}    ${Item_1}
    Click                ${SEL_ProductID}
    Click                ${SEL_BtnAdd}        #(//*[@data-test="btnAdd"])[1]

Zruš vyskakovací okno
    Click                ${SEL_CloseBtn} 
    Sleep                2
    Click                ${SEL_PageLogo}

Odebrat z košíku
    [Arguments]          ${Item_1}
    Type Text            ${SEL_SearchItem}      ${Item_1}
    Click                ${SEL_ProductID}
    Click                ${SEL_BtnMinus} >> nth=1

Vysypat košík
    Click                ${SEL_CartIcon}                        

*** Test Cases ***

Prihlaseni success
    [Tags]   první
    Browser Settings
    Login               ${USER_NAME}              ${PASSWORD}
    Get Text            ${SEL_NotifBell}
    [Teardown]    Logout

Negativní přihlášení
    [Tags]  druhý
    Browser Settings
    Login              ${USER_NAME}              ${invalid_PASSWORD}
    Get Text           ${SEL_NotifContent}  ==  ${SEL_INVALIDLOGIN}

Krátká návštěva
    [Tags]  třetí
    Browser Settings
    Login               ${USER_NAME}              ${PASSWORD}
    Logout

# Přidání položky
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Přidat do košíku    brambory
#     Přidat do košíku    tvaroh

# Odebrání položky
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Odebrat z košíku    tvaroh

# Zrušení nákupu
#     Browser Settings
#     Login               ucet.testing@seznam.cz              tajne@heslo&
#     Get Text            data-test=notification-bell
#     Vysypat košík

Váhavý klient
    [Tags]  čtvrtý
    Browser Settings
    Login               ${USER_NAME}              ${PASSWORD}
    Get Text            ${SEL_NotifBell}
    Přidat do košíku    ${Item_2}
    Zruš vyskakovací okno
    Přidat do košíku    ${Item_1}
    Zruš vyskakovací okno
    Odebrat z košíku    ${Item_2}
    Zruš vyskakovací okno
    Vysypat košík
    [Teardown]    Logout
