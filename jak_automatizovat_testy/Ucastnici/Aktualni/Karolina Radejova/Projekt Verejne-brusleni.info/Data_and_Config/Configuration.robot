#file contains configuration variables for Projekt Verejne-brusleni.info

*** Variables ***
#${URL}                   https://brusleni.vivaladesign.cz/              # testing environment
${URL}                   https://verejne-brusleni.info                  # production environment
${URL_lektori}           /lektori/
${URL_tipy_triky}        /tipy-a-triky/
${URL_praha}             /praha/
${URL_brno}              /brno/
${URL_ostrava}           /ostrava/
${URL_ostatni}           /ostatni/

#files
#template files
${FILE_template_praha}              ${FILE_path}2024_04_23_13_25_https:__verejne-brusleni.info_praha_.txt
${FILE_template_brno}               ${FILE_path}2024_04_25_10_07_https:__verejne-brusleni.info_brno_.txt
${FILE_template_ostrava}            ${FILE_path}2024_04_25_10_07_https:__verejne-brusleni.info_ostrava_.txt
${FILE_template_ostatni}            ${FILE_path}2024_04_25_10_07_https:__verejne-brusleni.info_ostatni_.txt

#actual files
${FILE_actual_praha}                ${FILE_path}2024_04_28_21_53_https:__verejne-brusleni.info_praha_.txt
${FILE_actual_brno}                 ${FILE_path}2024_04_28_21_49_https:__verejne-brusleni.info_brno_.txt
${FILE_actual_ostrava}              ${FILE_path}2024_04_28_21_43_https:__verejne-brusleni.info_ostrava_.txt
${FILE_actual_ostatni}              ${FILE_path}2024_04_25_13_19_https:__verejne-brusleni.info_ostatni_.txt

#load time difference
${FILE_time_difference}             3 #allowed amount of seconds in difference of load times

#file paths
${FILE_path}            Ucastnici/Aktualni/Karolina Radejova/Projekt Verejne-brusleni.info/Data_and_Config/TestFiles/
${FILE_extension}       .txt

#settings before/after suite, test
${PORT}                         80

${TIME_BETWEEN_CLICKS}          10ms
${TIME_BETWEEN_CHECKS}          50ms

${SLEEP_BEFORE_TEST}            10ms

${TIMEOUT_BROWSER}              40 s
${TC_TIMEOUT_ROBOT_KW}          2 minutes

#commands
${time_command}    python -c "from datetime import datetime; print(datetime.now().strftime('%H:%M:%S.%f'))"


