*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://lucietomankova.com/
   Get Title      ==    Lucie Tománková