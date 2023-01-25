// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype_1_uthm_hrapp/theme/style.dart';
import 'package:prototype_1_uthm_hrapp/util/helper_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // QuerySnapshot snap = await FirebaseFirestore.instance.collection("Users") .where("email", isEqualTo: user.email).get();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270,
                  child: AutoSizeText(
                    'Welcome ${user.email}',

                    maxLines: 1,
                    style: ThemeText().boldtext(24, SEC_BACKGROUND_COLOR),
                  ),
                ),
                // Drawer()
                // horizontalSpacing(10),
                // IconButton(
                //   onPressed: () {

                //   },
                //   icon: Icon(Icons.menu),
                // )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              'THIS IS HOMEPAGE',

              textAlign: TextAlign.center,
              style: ThemeText.bigyellow,
            ),
            verticalSpacing(20),
            AutoSizeText(
              'Logged in as ',

              style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
            ),

            AutoSizeText(
              user.email!,

              style: ThemeText().semiboldtext(16, SECONDARY_COLOR),
            ),
            verticalSpacing(20),
            SizedBox(
              width: 316,
              height: 45,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                splashColor: SECONDARY_COLOR,
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: AutoSizeText(
                  'LOG OUT',
                  style: ThemeText().semiboldtext(24, SEC_BACKGROUND_COLOR),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}