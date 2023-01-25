// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

String dropdownvalue = 'Student';

bool remembermevalue = false;
bool seepassword = false;
bool seeconfpassword = false;

Widget verticalSpacing(double h) {
  return SizedBox(
    height: h
  );
}

Widget horizontalSpacing(double w) {
  return SizedBox(
    width: w
  );
}


//database authentication
class AuthService {
  final FirebaseAuth _auth;
  // String confRole = '';

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<User?> login(String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signup(String email, String username, String password, String role) async {
    User? user = FirebaseAuth.instance.currentUser;
    // FirebaseDatabase database = FirebaseDatabase.instance;
    // String key = database.ref("User").push().get().key;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
        print(role);

        await FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
          'uid' : user.uid,
          'email' : email,
          'username' : username,
          'password' : password,
          'role' : role
        });
      });
      return user;
    } catch (e) {
      print(e);
    }
  }
}



FutureBuilder<DocumentSnapshot> FutureLogIn(String username) {
  CollectionReference user = FirebaseFirestore.instance.collection('Users');

  return FutureBuilder<DocumentSnapshot>(
    future: user.doc().get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        

        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document (user) does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("User: ${data['username']}, ${data['role']}, ${data['email']}");
        }

        return Text("loading");
      },
  );
}