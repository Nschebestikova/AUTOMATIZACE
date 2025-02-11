# Test data for login_API Test cases

*** Variables ***
#login_API TCs
#correct data
${user}                         admin
${password}                     tajneadmin
${useragent}                    Chrome 101.0.4951.67


#wrong data
${user_20}                      abcdefghijklmnoprstu
${long_user}                    abcdefghijklmnoprstuv
${long_password}                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Volutpat diam ut venenatis tellus in. Porttitor eget dolor morbi non arcu risus quis varius. Diam donec adipiscing tristique risus nec feugiat in. Magna fermentum iaculis eu non. Turpis egestas pretium aenean pharetra. Id velit ut tortor pretium viverra suspendisse potenti nullam ac. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique. Suscipit tellus mauris a diam maecenas sed. Parturient montes nascetur ridiculus mus mauris vitae ultricies. Accumsan in nisl nisi scelerisque eu ultrices. Vitae semper quis lectus nulla at volutpat diam ut. Amet nisl purus in mollis nunc sed id semper. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum. Et tortor consequat id porta nibh venenatis. Non enim praesent elementum facilisis leo vel fringilla est. Mi proin sed libero enim sed faucibus turpis in eu. Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis a. Nibh mauris cursus mattis molestie a iaculis at. Egestas maecenas pharetra convallis posuere morbi leo. Id volutpat lacus laoreet non curabitur. Imperdiet proin fermentum leo vel orci porta non. Massa enim nec dui nunc mattis enim.
${empty_user}
${empty_password}
${empty_useragent}

${null_user}                    null
${null_password}                null
${null_useragent}               null

${wrong_user}                   josef
${wrong_password}               spatneheslo
${wrong_useragent}              Chram 101.0.4951.67

${special_char_user}            #@♥{
${special_char_password}        #@♥{

${user_diacritic}               ěščřžý
${password_diacritic}           ěščřžý

${wrong_json_missing_value}     {"password":"${password}", "useragent":"${useragent}"}
${wrong_json_missing_char}      {"username":"${user}","password:"${password}","useragent":"${useragent}"}
${wrong_json_added_char}        {"username":#"${user}","password":"${password}","useragent":"${useragent}"}

#registration_to_course_API TCs
#correct
${name}                         Randomnameojkh
${surname}                      Randomsurnamekjh
${email}                        random.emailhf@kjhsd.cgds
${phone_420}                    +420777987123
${phone_777}                    777000001
${person_fyz}                   fyz
${person_pra}                   pra
${address}                      Random address 876324, 987324 Citykjwer
${ico}                          25596641
${count}                        4
${comment}                      Random comment, kjahsduywexc khasdkjh asdiuywe
${souhlas_true}                 true
${souhlas_false}                false

#empty
${course_empty}
${name_empty}
${surname_empty}
${email_empty}
${phone_empty}
${person_empty}
${address_empty}
${ico_empty}
${count_empty}
${comment_empty}
${souhlas_empty}

#null
${course_null}                  null
${name_null}                    null
${surname_null}                 null
${email_null}                   null
${phone_null}                   null
${person_null}                  null
${address_null}                 null
${ico_null}                     null
${count_null}                   null
${comment_null}                 null
${souhlas_null}                 null

#wrong format, long format
${course_wrong_number}          4
${course_wrong_string}          thisisnameofcourse
${email_wrong}                  thisisnotcorrectemail.com
${phone_420_short}              +420777663
${phone_777_short}              77723434
${phone_420_wrong}              +420this44
${phone_777_wrong}              777too88
${address_too_long}             Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Massa id neque aliquam vestibulum. Ornare quam viverra orci sagittis eu volutpat. Auctor augue mauris augue neque gravida in fermentum et. Faucibus et molestie ac feugiat sed lectus vestibulum. Facilisi cras fermentum odio eu feugiat pretium nibh. Adipiscing tristique risus nec feugiat in fermentum posuere urna. Blandit libero volutpat sed cras ornare arcu. Convallis aenean et tortor at risus. Quisque id diam vel quam elementum pulvinar etiam non quam. Porttitor leo a diam sollicitudin tempor id eu. Consequat nisl vel pretium lectus quam id leo in vitae. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat. Tellus in metus vulputate eu scelerisque felis imperdiet. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit. A erat nam at lectus. Integer feugiat scelerisque varius morbi enim nunc faucibus. Risus quis varius quam quisque id diam vel quam. Scelerisque felis imperdiet proin fermentum leo vel orci porta. Ultricies mi eget mauris pharetra. Egestas egestas fringilla phasellus faucibus scelerisque. Dui vivamus arcu felis bibendum ut tristique et egestas quis. Nisi vitae suscipit tellus mauris a. In eu mi bibendum neque egestas congue quisque egestas diam. Est placerat in egestas erat. Enim neque volutpat ac tincidunt vitae semper quis lectus nulla. Quam id leo in vitae.
${ico_wrong_incorrect_number}   12345678
${ico_wrong_long_number}        88888888909087
${ico_wrong_string}             25596string
${count_wrong_string}           thisiscount
${comment_long}                 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Massa id neque aliquam vestibulum. Ornare quam viverra orci sagittis eu volutpat. Auctor augue mauris augue neque gravida in fermentum et. Faucibus et molestie ac feugiat sed lectus vestibulum. Facilisi cras fermentum odio eu feugiat pretium nibh. Adipiscing tristique risus nec feugiat in fermentum posuere urna. Blandit libero volutpat sed cras ornare arcu. Convallis aenean et tortor at risus. Quisque id diam vel quam elementum pulvinar etiam non quam. Porttitor leo a diam sollicitudin tempor id eu. Consequat nisl vel pretium lectus quam id leo in vitae. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat. Tellus in metus vulputate eu scelerisque felis imperdiet. At ultrices mi tempus imperdiet nulla malesuada pellentesque elit. A erat nam at lectus. Integer feugiat scelerisque varius morbi enim nunc faucibus. Risus quis varius quam quisque id diam vel quam. Scelerisque felis imperdiet proin fermentum leo vel orci porta. Ultricies mi eget mauris pharetra. Egestas egestas fringilla phasellus faucibus scelerisque. Dui vivamus arcu felis bibendum ut tristique et egestas quis. Nisi vitae suscipit tellus mauris a. In eu mi bibendum neque egestas congue quisque egestas diam. Est placerat in egestas erat. Enim neque volutpat ac tincidunt vitae semper quis lectus nulla. Quam id leo in vitae.
${souhlas_wrong}                thisissouhlas4

#special symbols
${name_specials}                #@♥{
${surname_specials}             #@♥{
${address_specials}             #@♥{
${comment_specials}             #@♥{

#diacritics
${name_diacritics}              ěščřžýáíéúů
${surname_diacritics}           ěščřžýáíéúů
${address_diacritics}           ěščřžýáíéúů
${comment_diacritics}           ěščřžýáíéúů

#wrong format of json
${fyz_missing_quat_mark}        {"targetid":"","kurz":"1","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone_420}","person":"${person_fyz}","address":"${address}","ico":"","count":"${count}","comment":"${comment}",souhlas":${souhlas_true}}
${pra_missing_quat_mark}        {"targetid":"","kurz":"1","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone_420}","person":"${person_pra}","address":"","ico":"${ico}","count":"${count}","comment":"${comment}",souhlas":${souhlas_true}}
${fyz_missing_key_val_course}   {"targetid":"","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone_420}","person":"${person_fyz}","address":"${address}","ico":"","count":"${count}","comment":"${comment}","souhlas":${souhlas_true}}
${pra_missing_key_val_course}   {"targetid":"","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone_420}","person":"${person_pra}","address":"","ico":"${ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas_true}}