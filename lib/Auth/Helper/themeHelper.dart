import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';

class ThemeHelper{
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    accentColor: Colors.grey,
    backgroundColor: kContentColorDarkTheme,
    buttonTheme: ButtonThemeData(buttonColor: Colors.green,textTheme: ButtonTextTheme.primary),
    textTheme: TextTheme(headline1: TextStyle(color: Colors.blue),
        headline2: TextStyle(color: Colors.yellow),
    )
  );

  static ThemeData dark = ThemeData.light().copyWith(
      primaryColor: Colors.black,
      accentColor: Colors.grey,
      backgroundColor: Colors.black,
      buttonTheme: ButtonThemeData(buttonColor: Colors.orange,textTheme: ButtonTextTheme.primary),
      textTheme: TextTheme(headline1: TextStyle(color: Colors.white))
  );
}