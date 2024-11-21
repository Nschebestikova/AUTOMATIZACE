#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatele
${user_mail_1}              giyipem264@v1zw.com
${user_pass_1}              tajnenovak

${user_mail_2}              giyipem264@v1zw.com
${user_pass_2}              hoja

${user_mail_3}              d@sieber.com
#                           dominik@sieber.com
${user_pass_3}              tajnenovak

${user_pass_4}              tajnenovak

${user_name_5}              DomSie
${user_mail_5}              dominik@sieber.com
${user_pass_5}              tajnenovak

${user_name_6}              Radek
${user_mail_6}              radek@radek.com
${user_pass_6}              123

${user_name_7}              Testik
${user_mail_7}              dominik@sieber.com
${user_pass_7}              tajnenovak

${user_name_8}              RaSun
${user_mail_8}              RaSun@RaSun.com
${user_pass_8}              tajnenovak
${user_worng_pass_8}        tajne

${user_name_9}              RaTilt
${user_mail_9}              ${EMPTY}
${user_pass_9}              tajnenovak

#Strings LOGIN
${TEXT_logged_in}                Prihlasen
${TEXT_not_logged_in}            Neprihlasen
${TEXT_logged_out}               Odhlasen
${TEXT_not_logged_out}           Neodhlasen

${TEXT_to_log_out}               Odhlásit se
${TEXT_to_log_in}                Přihlásit se

#Strings REGISTR
${TEXT_registr_res_registered}             Zaregistrovan
${TEXT_registr_res_notRegistered}          Nezaregistrovan

#Error LOGIN strings
${ErrorText_login_incorrect_mail}          These credentials do not match our records.
${ErrorText_login_blank_mail}              The email field is required.
${ErrorText_login_blank_pass}              The password field is required.

#SELEKTORY pro LOGIN
${SEL_error_login_incorrect_mail}          data-test=email_input_errors
${SEL_error_login_blank_mail}              data-test=email_input_errors
${SEL_error_login_blank_pass}              data-test=password_input_errors

${SEL_login_form_email}                    data-test=email_input
${SEL_login_form_pass}                     data-test=password_input
${SEL_login_form_login_button}             data-test=login_button

#SELEKTORY pro Prihlaseni/Odhlaseni
${SEL_button_logout}                        data-test=logout_button
${SEL_button_login_link}                    data-test=login_link
#data-test=home_section

#Error REGISTER strings
${ErrorText_register_used_mail}               The email has already been taken.
${ErrorText_register_blank_mail}              The email field is required.
${ErrorText_register_short_pass}              The password field must be at least 8 characters.
${ErrorText_register_wrong_pass_match}        The password field confirmation does not match.

#SELEKTORY pro REGISTER
${SEL_error_register_used_mail}               data-test=email_input_errors
${SEL_error_register_blank_mail}              data-test=email_input_errors
${SEL_error_register_short_pass}              data-test=password_input_errors
${SEL_error_register_wrong_pass_match}        data-test=password_input_errors

${SEL_login_form_register_link}               data-test=register_link
${SEL_register_form_name_input}               data-test=name_input
${SEL_register_form_mail_input}               data-test=email_input
${SEL_register_form_pass_input}               data-test=password_input
${SEL_register_form_pass_verif_input}         data-test=password_again_input
${SEL_register_form_button_register}          data-test=register_button
