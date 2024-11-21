*** Settings ***
Library  Browser
*** Variables ***
${USER1_NAME}               Michal Novák
${USER1_EMAIL}              giyipem264@v1zw.com
${USER1_PASSWORD}           tajnenovak

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page        http://testovani.kitner.cz/login
    #titulek stránka kde hledáme
    Get Title      ==    Testování - přihlášení
#    lze napsat i jiným způsobem
#    ${titulek}  =
#    Should Be Equal  ${title}  Swag Labs
#print screen
    Take Screenshot
    Type text  data-test=email_input  ${USER1_EMAIL}
#    Type text  id=email_input  neco@nic.cz
#    Type text  class=input_box email border-[#E9EDF4] focus:border-[#bec0c2] w-full rounded-md border bg-white py-3 px-5 text-base text-body-color placeholder-[#ACB6BE] outline-none focus:border-primary focus-visible:shadow-none  neco@nic.cz
#    Type text  xpath=//*[@id="email_input"]  neco@nic.cz
    Type text  data-test=password_input  ${USER1_PASSWORD}
    Click   data-test=login_button
    Take Screenshot
