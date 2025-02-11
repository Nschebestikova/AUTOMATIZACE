*** Settings ***
Library    Browser

*** Test Cases ***
Vyběr země
    New Browser         chromium                        headless=false
    New Page            https://rc.meddiapp.com/

    Get Title           contains                        MEDDI app

    Click               css=[data-id="frm-regionLanguagePicker-form-region"]
    Sleep               1
    Click               css=[role="option"]#bs-select-1-0    #varianta Perú
    Sleep               5

    Take Screenshot

