import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Nunito',
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      //headline6: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    cardColor: Colors.black,
    fontFamily: 'Nunito',
    primaryColor: Colors.black,
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
    ),
  );
}
