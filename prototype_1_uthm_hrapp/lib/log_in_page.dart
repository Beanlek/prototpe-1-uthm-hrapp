// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'sign_up_page.dart';
import 'util/helper_widget.dart';
import 'theme/style.dart';

List<String> roles_login = [
  'Student',
  'Landlord',
  'Admin'
];

class LogInPage extends StatefulWidget{
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
//vvvvvvvvvvvvvvvv WELCOME BACK SINI VVVVVVVVVVVVVVVV
            verticalSpacing(130),
            AutoSizeText(
              'Welcome Back',
              textAlign: TextAlign.left,

              style: ThemeText.bigyellow
            ),
      
            AutoSizeText(
              'Log in to rent.',
              textAlign: TextAlign.left,

              style: ThemeText().smallsubtitle(20,SECONDARY_COLOR),
            ),
            verticalSpacing(80.0),

//^^^^^^^^^^^^^^^^ WELCOME BACK SINI ^^^^^^^^^^^^^^^^^
      
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Container(
                    decoration: ThemeContainer().roundedRectangle(SEC_BACKGROUND_COLOR, 30),

//vvvvvvvvvvvvvv ni dalam kotak hitammm vvvvvvvvvvvvvv
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                          child: Column(
                            children: [
                              TextField(
                                style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
                                controller: usernameController,
                                textInputAction: TextInputAction.next,
                                decoration: myInputDecoration('Username'),
                              ),
                              Stack(
                                children: [
                                  TextField(
                                    scrollPadding: const EdgeInsets.only(bottom: 100),
                                    style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
                                    controller: passwordController,
                                    textInputAction: TextInputAction.next,
                                    decoration: myInputDecoration('Password'),
                                    obscureText: !seepassword,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      splashColor: COLOR_PRIMARY,
                                      alignment: Alignment.bottomRight,
                                      color: SECONDARY_COLOR,
                                      onPressed: () {
                                        setState(() {
                                          seepassword = !seepassword;
                                        });
                                      },
                                      icon: Icon((seepassword == false) ? Icons.remove_red_eye_outlined : Icons.remove_red_eye)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  
                        

                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    value: remembermevalue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        remembermevalue = value!;
                                      });
                                    }
                                  ),
                                  Row(
                                    children: [
                                      horizontalSpacing(36),
                                      const AutoSizeText(
                                        'Remember me'
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              horizontalSpacing(65),

                              InkWell(
                                onTap: () {
                                  
                                },
                                child: AutoSizeText(
                                  'Forgot password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpacing(5),

                        Center(
                          child: SizedBox(
                            width: 316,
                            height: 45,
                            child: FloatingActionButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              splashColor: SECONDARY_COLOR,
                              onPressed: () async {
                                final String username = usernameController.text.trim();
                                final String password = passwordController.text.trim();
                                final String role = dropdownvalue;

                                bool error = false;

                                if (username.isEmpty){
                                  print("Username is empty.");
                                  error = true;
                                }
                                if (password.isEmpty){
                                  print("Pasword is empty.");
                                  error = true;
                                }
                                
                                if (error == false) {//if xde error, terus jalan code ni
                                  print(dropdownvalue);
                                  print("Mantap log in");

                                  QuerySnapshot snap = await FirebaseFirestore.instance
                                    .collection("Users")
                                    .where("username", isEqualTo: username).get();
                                  context.read<AuthService>().login(
                                    snap.docs[0]['email'],
                                    password,
                                  );
                                  // readUsername(context, username, password);

                                  // FutureLogIn(username);
                                  // context.read<AuthService>().login(
                                  //   readUsername(username).docs[0]['email'],
                                  //   password,
                                  // );
                                }
                              },
                              child: AutoSizeText(
                                'LOG IN',
                                style: ThemeText().semiboldtext(24, SEC_BACKGROUND_COLOR),
                              ),
                            ),
                          ),
                        ),
                        verticalSpacing(15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              '''Don't have an account? '''
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder:
                                    (context) => SignUpPage()
                                  )
                                );
                              },
                              child: AutoSizeText(
                                'Sign Up',
                                style: TextStyle(
                                  decoration: TextDecoration.underline
                                ),
                              )
                            ),
                          ],
                          
                        ),
                        verticalSpacing(25),

                      ],
                    ),
                  ),
                ),

//^^^^^^^^^^^^^^^^ ni dalam kotak hitammm  ^^^^^^^^^^^^^^^^
//vvvvvvvvvvvvvv ni kotak kuning belakang dropdownnnnn vvvvvvvvvvvvvv

                Align(
                  alignment: Alignment.centerRight,
                  child: ThemeContainer().roundedRectangleContainer(110, 35,
                  ThemeContainer().roundedRectangle(COLOR_PRIMARY, 10),null)
                ),

//^^^^^^^^^^^^^^^^ ni kotak kuning belakang dropdownnnnn ^^^^^^^^^^^^^^^^

                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 35,
              
                    child: DropdownButton(
                      alignment: Alignment.centerRight,
                      value: dropdownvalue,
                      dropdownColor: COLOR_PRIMARY,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconEnabledColor: SEC_BACKGROUND_COLOR,
                      items: roles_login.map((String roles_login) {
                          return DropdownMenuItem(
                            value: roles_login,
                            child: Text(
                              roles_login,
                              style: ThemeText().smallsubtitle(16,SEC_BACKGROUND_COLOR),
                            )
                          );
                        }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ]
            ),


      
            
      
            
          ],
        ),
      )
    );
  }
}