// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'log_in_page.dart';
import 'util/helper_widget.dart';
import 'theme/style.dart';
import 'package:provider/provider.dart';

List<String>  roles_signup = [
  'Student',
  'Landlord'
];

// var roles_signup = usertypes('signup');

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (dropdownvalue == 'Admin') {
      dropdownvalue = 'Student';
    }
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
      
            verticalSpacing(130),
            AutoSizeText(
              'Create an Account',
              textAlign: TextAlign.left,
      
              style: ThemeText.bigyellow
            ),
      
            AutoSizeText(
              'Welcome, newcomer!',
              textAlign: TextAlign.left,
      
              style: ThemeText().smallsubtitle(20,SECONDARY_COLOR),
            ),
            verticalSpacing(50.0),

            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Container(
                    decoration: ThemeContainer().roundedRectangle(SEC_BACKGROUND_COLOR, 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                          child: Column(
                            children: [
                              TextField(
                                style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: myInputDecoration('Email'),
                              ),
                              TextField(
                                style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
                                controller: usernameController,
                                textInputAction: TextInputAction.next,
                                decoration: myInputDecoration('Username'),
                              ),
                              Stack(
                                children: [
                                  TextField(
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
                              Stack(
                                children: [
                                  TextField(
                                    scrollPadding: const EdgeInsets.only(bottom: 100),
                                    style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
                                    controller: confirmPasswordController,
                                    textInputAction: TextInputAction.next,
                                    decoration: myInputDecoration('Confirm Password'),
                                    obscureText: !seeconfpassword,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      splashColor: COLOR_PRIMARY,
                                      alignment: Alignment.bottomRight,
                                      color: SECONDARY_COLOR,
                                      onPressed: () {
                                        setState(() {
                                          seeconfpassword = !seeconfpassword;
                                        });
                                      },
                                      icon: Icon((seeconfpassword == false) ? Icons.remove_red_eye_outlined : Icons.remove_red_eye)
                                    ),
                                  ),
                                ],
                              ),

                              verticalSpacing(20),

                              Center(
                                child: SizedBox(
                                  width: 316,
                                  height: 45,
                                  child: FloatingActionButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    splashColor: SECONDARY_COLOR,

                                    onPressed: () {
                                      final String email = emailController.text.trim();
                                      final String username = usernameController.text.trim();
                                      final String password = passwordController.text.trim();
                                      final String confpassword = confirmPasswordController.text.trim();

                                      bool error = false;
                                      bool noPass = true;
                                      bool noConPass = true;

                                      if (email.isEmpty){
                                        print("Email is empty.");
                                        error = true;
                                      }
                                      if (username.isEmpty){
                                        print("Username is empty.");
                                        error = true;
                                      }
                                      if (password.isEmpty){
                                        print("Pasword is empty.");
                                        error = true;
                                      }else{noPass = false;}

                                      if (confpassword.isEmpty){
                                        print("Confirm Password is empty.");
                                        error = true;
                                      }else{noConPass = false;}

                                      if ((confpassword != password) && (noPass == false && noConPass == false)){
                                        print("Passord and Confirm Password is notthe same.");
                                        error = true;
                                      }
                                      
                                      if (error == false) {//if xde error, terus jalan code ni
                                        print(dropdownvalue);
                                        print("Mantap");
                                        context.read<AuthService>().signup(
                                          email,
                                          username,
                                          password,
                                          dropdownvalue
                                        // );
                                        ).then((value) async {
                                          User? user = FirebaseAuth.instance.currentUser;

                                          await FirebaseFirestore.instance.collection("Users").doc(user?.uid).set({
                                            'uid': user?.uid,
                                            'email': email,
                                            'username': username,
                                            'password': password,
                                            'role': dropdownvalue,
                                          });
                                        });

                                        Navigator.pop(context);
                                      }
                                    },

                                    child: AutoSizeText(
                                      'SIGN UP',
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
                                    '''Alrready have an account? '''
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: AutoSizeText(
                                      'Log in',
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
                        )
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: ThemeContainer().roundedRectangleContainer(110, 35,
                  ThemeContainer().roundedRectangle(COLOR_PRIMARY, 10),null)
                ),

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
                      items: roles_signup.map((String roles_signup) {
                          return DropdownMenuItem(
                            value: roles_signup,
                            child: Text(
                              roles_signup,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}