*** Settings ***
Library     Browser

Resource    make_TestData.robot


*** Test Cases ***

# Pozitivní test
Prihlaseni - správné údaje
    Login           ${USER_EMAIL}               ${USER_PASSWORD}
    Sleep    15
    Kontrola prihlasen

Odhlášení z účtu
    Login           ${USER_EMAIL}               ${USER_PASSWORD}
    Sleep    15
    Logout
    Kontrola neprihlasen

#Negativní test

Prihlaseni - chybny mail a heslo
    Login           ${USER_INVALID_EMAIL}       ${USER_INVALID_PASSWORD}
    Sleep    10
    Kontrola neprihlasen


*** Keywords ***

Login
    [Arguments]         ${Email}                                ${Password}

    New Browser         browser=${prohlizec}                    headless=False
    New Page            ${URL}
    Type Text           ${SEL_LoginFormEmail}                   ${Email}
    Type Text           ${SEL_LoginFormPwd}                     ${Password}
    Click               ${SEL_UserLoginBtn}

Logout
     Click           ${SEL_LogoutAvatar}
     Click           ${SEL_LogoutBtn}

#kontroly
Kontrola prihlasen
    Get Title   ==   My Organization | Make

Kontrola neprihlasen
    Get Title   ==   Sign in | Make HQ