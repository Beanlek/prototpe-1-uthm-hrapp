// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'log_in_page.dart';
import 'util/helper_widget.dart';
import 'theme/style.dart';
import 'home_page.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'prototype_1_uthm_hrapp',
    //   theme: mainTheme,
    //   home: AuthWrapper()
    // );
    return Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
        builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'prototype_1_uthm_hrapp',
          theme: mainTheme,
          home: AuthWrapper(),
        );
      }
    );
        // StreamProvider(
        //   create: (context) => context.read<AuthService>().authStateChanges,
        //   initialData: FirebaseAuth.instance.currentUser,
        // )
      
      
    //-----------------------------------------------------------------------
      // child: MaterialApp(
      //   title: 'prototype_1_uthm_hrapp',
      //   theme: mainTheme,
      //   home: AuthWrapper(),
      // ),
    
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: mainTheme,
    //   home: AuthWrapper(),
    // );
  }
}

class AuthWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            }else {
              return LogInPage();
            }
          },
        ),
      );
  }
}
// class AuthWrapper extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<User?>();
    
//     if (user != null) {
//       print(user);
//       return HomePage();
//     }

//     return LogInPage();
//   }
// }