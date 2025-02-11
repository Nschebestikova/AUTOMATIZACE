*** Settings ***
Library  Browser

*** Variables ***
${MENU_NOT_LOGGEDIN}  Ovládací panel  Přihlášení  Registrace  Zapomenuté Heslo  Přidat film  Přidat tvůrce
${MENU_LOGGEDIN}      Ovládací panel  Automatestik  Pošta  Oblíbení uživatelé  Chci vidět  Filmotéka  Poznámky  Spřízněné duše  Návštěvníci  Nastavení  Přítomní  Odhlásit

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page        https://www.csfd.cz/

#cookies
    Click           id=didomi-notice-agree-button

    Get Title      ==    ČSFD.cz
    Click           "Můj účet"
    Get Variables   ${MENU_NOT_LOGGEDIN}
#Log in
    Go To           https://www.csfd.cz/prihlaseni/
    Get Text        "Účet uživatele ČSFD"
    Username_Login  Automatestik
    Password_Login  4testik
    Click           css=[type="submit"][name="send"]
    Log Entry       Automatestik
    Get Text        "Nové trailery a rozhovory"
    Click           css=.profile.initialized
    Get Variables   ${MENU_LOGGEDIN}
#Log out
    Click           css=.dropdown-content.main-menu a[href="/odhlasit/"]
    Get Text        "Můj účet"

*** Keywords ***
Username_Login
    [Arguments]     ${username}
    Type Text       id=frm-loginForm-username  ${username}

Password_Login
    [Arguments]     ${password}
    Type Text       id=frm-loginForm-password  ${password}

Log Entry
    [Arguments]     ${username}
    Log To Console  User ${username} succesfully logged in.




