*** Settings ***
Library  Browser

*** Test Cases ***
LogInNegative
   New Browser      chromium            headless=false
   New Page         https://tchibo.cz
   ${titulek}       Get Title
   Log To Console   ${titulek}
   Get Title   ==   Tchibo - káva, móda, nábytek a více | Tchibo.cz
   Click            //*[@id="onetrust-accept-btn-handler"]
   Hover            //*[@id="c-header2020-icon--user"]
   Click            "Přihlásit se"
   Type Text         //input[@type="email"]        muj@email.cz
   Type Text         //input[@type="password"]     heslo
   Sleep             2
   Click             "Přihlásit"
   Sleep             2
   ${error}          Get Text    //input[@type="password"]/parent::div/following-sibling::div[@class="tp-form-input-message"]
   Should Be Equal   ${error}    Vaše e-mailová adresa a heslo si neodpovídají.

LogIn&LogOutPossitive
   New Browser      chromium            headless=false
   New Page         https://tchibo.cz
   ${titulek}       Get Title
   Log To Console   ${titulek}
   Get Title   ==   Tchibo - káva, móda, nábytek a více | Tchibo.cz
   Click            //*[@id="onetrust-accept-btn-handler"]
   Sleep            2
   Hover            //*[@id="c-header2020-icon--user"]
   Click            "Přihlásit se"
   Type Text        //input[@type="email"]           testovaci@gmail.com
   Type Text        //input[@type="password"]        1234Testovani
   Sleep            2
   Click            "Přihlásit"
   Sleep            1
   Hover            //*[@id="c-header2020-icon--user"]
   Sleep            1
   Take Screenshot

OnlyLogin
    LogIn            ${email}          ${password}

*** Keywords ***
LogIn
    [Arguments]      ${text1}   ${text2}
    New Browser      chromium            headless=false
    New Page         https://tchibo.cz
    ${titulek}       Get Title
    Log To Console   ${titulek}
    Get Title   ==   Tchibo - káva, móda, nábytek a více | Tchibo.cz
    Click            //*[@id="onetrust-accept-btn-handler"]
    Hover            //*[@id="c-header2020-icon--user"]
    Click            "Přihlásit se"
    Type Text         //input[@type="email"]        ${text1}
    Type Text         //input[@type="password"]     ${text2}
    Sleep             2
    Click             "Přihlásit"
    Sleep             1
    Take Screenshot


*** Variables ***
${email}        testovaci@gmail.com
${password}     1234Testovani
