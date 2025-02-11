# Konfigurace - timeouty

*** Variables ***
${URL}                         http://testovani.kitner.cz/courses
${BROWSER} =                   chromium
${SIZE_BROWSER} =               {'width':1920, 'height':1080}

# NEJSEM SI JISTÁ, JAK ZDE ZAPRACPOVAT PORT ... ?

${TIME_BETWEEN_CLICKS}          100ms
${TIME_BETWEEN_CHECKS}          200ms

${SLEEP_BEFORE_TEST}            10s

${TIMEOUT_BROWSER}              20 s
${TC_TIMEOUT_ROBOT_KW}          2 minutes ${TIME_BETWEEN_CHECKS}  200ms

${TIMEOUT_BROWSER}      20 s
${TC_TIMEOUT_ROBOT_KW}  3 minutes
