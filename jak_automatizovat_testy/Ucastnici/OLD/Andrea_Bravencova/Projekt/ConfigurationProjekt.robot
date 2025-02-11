
*** Variables ***
# Pages
${URL_Main}             https://www.csfd.cz/
${LOG_IN_PAGE}          https://www.csfd.cz/prihlaseni/
${app}                  api/search/autocomplete/
${urlapp}               ${URL_Main}${app}

${BROWSER}              chromium
${PORT}                 80

${TIMEOUT_BROWSER}      30 s
