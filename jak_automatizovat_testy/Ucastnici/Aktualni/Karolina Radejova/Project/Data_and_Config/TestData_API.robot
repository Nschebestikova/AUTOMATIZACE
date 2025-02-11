# Test data for API tests

*** Variables ***
#user data for OK registrations
${course_name_1}        Jak se stát testerem
${course_name_2}        Testování v agilním prostředí
${course_name_3}        Základy testování software
${souhlas_string}       ANO
${souhlas_string_neg}   NE

#user 1
${name_1}               ysMEmilyKaRa1
${surname_1}            ysMŘezníKaR
${email_1}              ysMKaR.ilDavid@veryniceemail.com
${phone_1}              +420707554007
${person_1}             fyz
${address_1}            ysMKaRaa Random address 87234, 123 45 RandomBrnoščř
${ico_1}                25596641
${count_1}              5
${comment_1}            ysMKaRavNejkrásnější komentář pro daný kurz. Těším se.
${souhlas_1}            true

#user 2
${name_2}               Rajesh Sheldon
${surname_2}            Verynicesurname Cooper
${email_2}              emailemailem872634@email.com
${phone_2}              777112233
${person_2}             pra
${address_2}
${ico_2}                25596641
${count_2}              1
${comment_2}
${souhlas_2}

#user 3
${name_3}               MillieMillie
${surname_3}            Verynicesurname Nováková
${email_3}              emailkjahsd098@lkjsdf.com
${phone_3}              +420777112267
${person_3}             fyz
${address_3}            Nejkrásnější ulice 777, ŘŠČÁĚÍÚŮ 65455
${ico_3}
${count_3}              4
${comment_3}
${souhlas_3}

${NEG_course_number_int}        "4"
${NEG_course_number_string}     tři
${NEG_name}
${NEG_surname}
${NEG_email_format}             janedoe2345emailaddress.com
${NEG_phone_short_420}          +4207774442
${NEG_phone_short}              7771231
${NEG_phone_long_420}           +420777123123 999999 888 777
${NEG_phone_long}               777123999 345345 345
${NEG_phone_wrong_format}       +420999asdkjhasd?!@
${NEG_person}                   ááá #prá
${NEG_address_long}             Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
${NEG_ico}                      25596647
${NEG_count}                    0.5
${NEG_souhlas}                  "Toto je souhlas."

#jsons
#positive
${JSON_correct_values_1}                                                {"targetid":"","kurz":"1","name":"${name_1}","surname":"${surname_1}","email":"${email_1}","phone":"${phone_1}","person":"${person_1}","address":"${address_1}","ico":"${ico_1}","count":"${count_1}","comment":"${comment_1}","souhlas":${souhlas_1}}

${JSON_correct_values_2}                                                {"targetid":"","kurz":"2","name":"${name_2}","surname":"${surname_2}","email":"${email_2}","phone":"${phone_2}","person":"${person_2}","address":"${address_2}","ico":"${ico_2}","count":"${count_2}","comment":"${comment_2}","souhlas":${souhlas_2}}
#kurz 3, phone with prefix, fyzicka osoba, comment - empty, souhlas - true
${JSON_correct_values_3}                                                {"targetid":"","kurz":"3","name":"${name_3}","surname":"${surname_3}","email":"${email_3}","phone":"${phone_3}","person":"${person_3}","address":"${address_3}","ico":"${ico_3}","count":"${count_3}","comment":"${comment_3}","souhlas":${souhlas_3}}

#negative
${JSON_empty_all_values}                                                {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":null,"souhlas":null}
${JSON_empty_mandatory_values}                                          {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":"Very nice comment","souhlas":true}
${JSON_null_all_values}                                                 {"targetid":"","kurz":null,"name":null,"surname":null,"email":null,"phone":null,"person":null,"address":null,"ico":null,"count":null,"comment":null,"souhlas":null}
${JSON_empty_address_fyz_os}                                            {"targetid":"","kurz":"3","name":"Verynicename Jane","surname":"Verynicesurname Doe","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_empty_ico_pra_os}                                                {"targetid":"","kurz":"3","name":"Verynicename Joe","surname":"Verynicesurname Doe","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"pra","address":"Ulice 888, 76588 Město","ico":"","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_course_number_int}                                     {"targetid":"","kurz":"${NEG_course_number_int}","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorect_course_number_string}                                   {"targetid":"","kurz":"${NEG_course_number_string}","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_mail}                                                  {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"${NEG_email_format}","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_phone_short_420}                                       {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"${NEG_phone_short_420}","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_phone_short_without_420}                               {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"${NEG_phone_short}","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_phone_long_420}                                        {"targetid":"","kurz":"2","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"${NEG_phone_long_420}","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_phone_long_without_420}                                {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"${NEG_phone_long}","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_phone_format}                                          {"targetid":"","kurz":"3","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"${NEG_phone_wrong_format}","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_typ_os}                                                {"targetid":"","kurz":"1","name":"MartinekMartyMarťas","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"${NEG_person}","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_address_long}                                                    {"targetid":"","kurz":"3","name":"Verynicename Jane","surname":"Verynicesurname Doe","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"${NEG_address_long}","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_ico}                                                   {"targetid":"","kurz":"1","name":"Randomchoice","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"pra","address":"Random address, 123 45 Brno","ico":"${NEG_ico}","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_ico_fyz}                                               {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"${NEG_ico}","count":"1","comment":"Very nice comment","souhlas":true}
${JSON_incorrect_count}                                                 {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"${NEG_count}","comment":"Very nice comment","souhlas":true}
${JSON_souhlas_wrong_format}                                            {"targetid":"","kurz":"3","name":"VeryniceNameCh","surname":"Verynicesurname Doe","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"pra","address":"","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":${NEG_souhlas}}
${JSON_empty_course_number}                                             {"targetid":"","kurz":"","name":"Verynicename Jane","surname":"Verynicesurname Doe","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Zelená ulice, Říčany 77788, Město","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}

#incorrect format of json
#missing person key-value
${JSON_incorrect_json_format_missing_value}                             {"targetid":"","kurz":"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
#missing quatation marks in "kurz:"1"
${JSON_incorrect_format_missing_character}                              {"targetid":"","kurz:"1","name":"Verynicename","surname":"Verynicesurname","email":"veryniceemail@veryniceemail.com","phone":"+420777123456","person":"fyz","address":"Random address, 123 45 Brno","ico":"25596641","count":"1","comment":"Very nice comment","souhlas":true}
