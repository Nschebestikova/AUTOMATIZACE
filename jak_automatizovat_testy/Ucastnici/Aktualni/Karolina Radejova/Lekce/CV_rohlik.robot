*** Settings ***
Library  Browser

*** Test Cases ***
Put product to basket in rohlik.cz
    Starting a browser rohlik.cz with a page
    Deny cookies
    Put products to basket
    Check product in basket

*** Variables ***
${URL}                  https://www.rohlik.cz/
${search_product}       schubert vejce
${product_title}        Schubert Podestýlková vejce čerstvá M10 ks

*** Keywords ***
Starting a browser rohlik.cz with a page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      ==     Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Get Title      *=    supermarket
    Get Url        ==     ${URL}vitejte
    Get Url        *=     rohlik.cz

Put products to basket
    Click       xpath=//img[@data-test='logo-main' and @class='logo']
    Sleep       3
    Log         Logo was clicked
    Type Text   xpath=//input[starts-with(@placeholder,'Hledat') and @id='searchGlobal']    ${search_product}
    Log         ${search_product} was searched
    Sleep       3
    #Click       xpath=//button[@data-test='header-search-button' and contains(@type,'submit')]
    Click       data-test=header-search-button
    Take Screenshot
    Get Url     *=      hledat?q=schubert
    Log         Page contains hledat?q=schubert
    Wait For Elements State    //h4[contains(@title,'Schubert Podestýlková vejce čerstvá M')]       visible
    Take Screenshot
    Click       xpath=//button[contains(@data-product-id,"1394444")]
    Sleep       3
    Get Text    xpath=//button[@data-test='cart-redirectToCart']
    Log         Redirect to basket button is displayed
    Take Screenshot

Check product in basket
    Click       xpath=//button[@data-test='cart-redirectToCart']
    Sleep       3
    Wait For Elements State    xpath=//h1[@id='cartReviewMainTitle']        visible
    Take Screenshot
    Get Text    xpath=//h3//a[contains(@href,'schubert-podestylkova-vejce-cerstva-m')]  ==  ${product_title}

Deny cookies
    Wait For Elements State    xpath=//div[@id='CybotCookiebotDialogBodyButtonsWrapper']    visible
    Click       xpath=//div[@id='CybotCookiebotDialogBodyButtonsWrapper']//button[contains(@id,'CybotCookiebotDialogBodyButtonDecline')]
    Take Screenshot
    Sleep       3

#Check price of product


