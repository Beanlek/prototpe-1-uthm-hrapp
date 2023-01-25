// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, constant_identifier_names

import 'package:flutter/material.dart';
// import '../util/helper_widget.dart';

const SWATCH_PRIMARY = Colors.amber;

const COLOR_PRIMARY = Color(0xffFFB200); //#FFB200
const SECONDARY_COLOR = Color(0xffCDCDCD); //#cdcdcd
const TERTIARY_COLOR = Color(0xffFFCA4F); //#FFCA4F
const MAIN_BACKGROUND_COLOR = Color(0xff212832); //#212832
const SEC_BACKGROUND_COLOR = Color(0xff19202a); //#19202a

ThemeData mainTheme = ThemeData(
  //colour scheme
  primaryColor: COLOR_PRIMARY,
  primarySwatch: SWATCH_PRIMARY,
  scaffoldBackgroundColor: MAIN_BACKGROUND_COLOR,
  backgroundColor: SEC_BACKGROUND_COLOR,

  //text style
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: SECONDARY_COLOR,
      fontWeight: FontWeight.w200,
    )
  )
);

class ThemeText {
  static const TextStyle bigyellow = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 48,
    color: COLOR_PRIMARY
  );

  TextStyle smallsubtitle(double fsize, dynamic txtcolor) {
      return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fsize,
      color: txtcolor
    );
  }

  TextStyle semiboldtext(double fsize, dynamic txtcolor) {
      return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fsize,
      color: txtcolor
    );
  }

  TextStyle boldtext(double fsize, dynamic txtcolor) {
      return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fsize,
      color: txtcolor
    );
  }
}

class ThemeContainer {
  BoxDecoration roundedRectangle(dynamic boxColor, double radius) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: boxColor
    );
  }
  
  Container roundedRectangleContainer(double w, double h, dynamic deco, dynamic child) {
    return Container(
      width: w, //110,
      height: h, //35,
      decoration: deco,
      child: child, //ThemeContainer().roundedRectangle(COLOR_PRIMARY, 10),
    );
  }
  // static const BoxDecoration dropdownbox = BoxDecoration(
  //   borderRadius: BorderRadius.all(Radius.circular(10)),
  //   color: COLOR_PRIMARY
  // );

  // static const BoxDecoration inputbox_1 = BoxDecoration(
  //   borderRadius: BorderRadius.all(Radius.circular(30)),
  //   color: SEC_BACKGROUND_COLOR
  // );
}

InputDecoration myInputDecoration(String myLabel) {
  return InputDecoration(
    labelText: myLabel,
    labelStyle: ThemeText().smallsubtitle(16,SECONDARY_COLOR),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: SECONDARY_COLOR)
    )
  );
}

ShapeDecoration roundedCorners(double radius) {
  return ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1.0, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );
}