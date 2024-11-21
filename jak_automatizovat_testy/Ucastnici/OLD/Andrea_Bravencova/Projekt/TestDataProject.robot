*** Variables ***

#  Menu
${MENU_NOT_LOGGEDIN}      Ovládací panel  Přihlášení  Registrace  Zapomenuté Heslo  Přidat film  Přidat tvůrce
${MENU_LOGGEDIN}          Ovládací panel  Automatestik  Pošta  Oblíbení uživatelé  Chci vidět  Filmotéka  Poznámky  Spřízněné duše  Návštěvníci  Nastavení  Přítomní  Odhlásit

# Movie
${MOVIE_MujSousedTotoro}  Můj soused Totoro
${MOVIE_SvetPodleProta}  Svět podle Prota

# Positive User Data
${USER1_USERNAME}         Automatestik
${USER1_PASSWORD}         4testik

# Negative User Data
${USER2_USERNAME}          NonExistent
${USER2_PASSWORD}          NonExistent

# Selectors
${SEL_AcceptCookies}       id=didomi-notice-agree-button
${SEL_LogOutBtn}           css=.dropdown-content.main-menu a[href="/odhlasit/"]
${SEL_MenuStart}           css=.profile.initialized
${SEL_loginFormUsername}   id=frm-loginForm-username
${SEL_loginFormPasssword}  id=frm-loginForm-password
${SEL_loginMissPasssword}  css=.has-error
${SEL_SubmitBtn}           css=[type="submit"][name="send"]
${SEL_SearchBtn}           css=.btn-search
${SEL_SearchInput}         css=.tt-input
${SEL_WrongCredentials}    id=snippet--flashes

# Star Rates
${SEL_star-100}            css=.star.star-100
${SEL_star-80}             css=.star.star-80

# Strings
${TEXT_LoginPage}          "Účet uživatele ČSFD"
${TEXT_Menu}               "Můj účet"
${TEXT_LoggedIn}           "Nové trailery a rozhovory"
${TEXT_ReviewAdded}        "Hodnocení bylo úspěšně uloženo."
${TEXT_MainTitle}           ČSFD.cz
${TEXT_CredentialsFailed}   Přihlášení se nezdařilo. Přezdívka nebo heslo jsou nesprávné. Zadáváš správně velká a malá písmena v heslu?
${TEXT_MissPassword}        Zadej heslo.

# Logs text
${LOG_UserLoggedIn}         User ${USER1_USERNAME} succesfully logged in.
${LOG_UserNotLoggedIn}      User ${USER2_USERNAME} is not logged in.
${LOG_PageFailed}           Something went wrong.

#API
${json}=  catenate {"name":"","search_name": null, "year":"", "rating_icon_class":"","link":""}
