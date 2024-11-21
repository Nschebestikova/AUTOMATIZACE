*** Variables ***
${URL1}      http://testovani.kitner.cz/regkurz/
${URLREGISTLIST}                http://testovani.kitner.cz/regkurz/list.php


#BROWSER A DATA BROWSER
${BROWSER} =                    chromium
${TIME_BROWSER}                 100ms
${PORT}                         80

#ČASY MEZI PROKLIKY A TESTY
${CAS_MEZICLICKY}          50ms
${CAS_MEZIKONTROLOU}          200ms

${SLEEP_PREDTESTEM}            2s


#TIMEOUT PRO VŠECHNY TESTY
${TC_TIMEOUT_ROBOT_KW}          2 minutes ${CAS_MEZIKONTROLOU}  200ms



