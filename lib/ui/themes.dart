// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal.shade200,
    appBarTheme: AppBarTheme(color: Colors.teal.shade200),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Sofiapro',
    textTheme: const TextTheme(
        headline1: TextStyle(),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
        bodyText2: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w900, fontSize: 14)),
    // button: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
    //for drop down menus ::::::::::::

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: Colors.teal),
      helperStyle: TextStyle(color: Colors.teal),
      hintStyle: TextStyle(color: Colors.teal),
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      contentPadding: EdgeInsets.all(8.0),
      fillColor: Colors.white,
      filled: true,
      focusColor: Colors.teal.shade400,
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99)),
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99)),
          borderSide: BorderSide(color: Colors.teal.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99)),
          borderSide: BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99)),
          borderSide: BorderSide(color: Colors.grey.shade800)),
    ),

    indicatorColor: Colors.blueGrey.shade900,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.blueGrey.shade900,
      labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99)))),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.white;
              },
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.white;
              },
            ),
            textStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900),
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      textStyle: MaterialStateTextStyle.resolveWith((states) {
        return TextStyle(fontWeight: FontWeight.bold);
      }),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(24),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade200),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    )),
    dataTableTheme: DataTableThemeData(
        headingRowColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.teal.shade50;
          },
        ),
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
  );
}
