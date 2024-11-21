#file contains variables for Projekt Verejne-brusleni.info

*** Variables ***
# strings

# selectors
#IR = ice rink
${SEL_IR_title}                             xpath=//h2[@class='widget-title']//a[not(contains(text(), 'TIPY A TRIKY PRO VÁS'))]
${SEL_IR_ice_rink_ostatni}                  xpath=//*[contains(@class,'whole-post-link')]           #selector of ice rink elements in /ostatni page
${SEL_consent_dialog_btn_consent}           xpath=//button[@aria-label='Consent']                   #selector of Consent btn in Consent dialog
${SEL_IR_photo}                             xpath=//div[@class='thumbnail1']/img
${SEL_IR_status}                            xpath=//div[contains(@class,'stav')]


