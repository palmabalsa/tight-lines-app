// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal.shade200,
    appBarTheme: AppBarTheme(color: Colors.teal),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Sofiapro',
    textTheme: const TextTheme(
        displayLarge: TextStyle(),
        headlineMedium: TextStyle(color: Colors.black),
        headlineSmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        titleMedium:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
        bodyMedium: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w900, fontSize: 14)),

    // button: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
    //for drop down menus ::::::::::::

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle:
          TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      helperStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      labelStyle: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
      contentPadding: EdgeInsets.all(8.0),
      fillColor: Colors.white,
      filled: true,
      focusColor: Colors.teal.shade400,
      enabledBorder: UnderlineInputBorder(),
    ),

    indicatorColor: Colors.teal.shade50,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.teal.shade50,
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

    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.teal,
        contentTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),

    // dropdownMenuTheme: DropdownMenuThemeData(
    //     inputDecorationTheme: InputDecorationTheme(
    //   // fillColor: Colors.white,
    //   fillColor: Colors.black,
    //   border: OutlineInputBorder(
    //       borderRadius: const BorderRadius.all(Radius.circular(99)),
    //       borderSide: BorderSide(color: Colors.black)),
    // )),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.black;
              },
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.white;
              },
            ),
            textStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            side: BorderSide(color: Colors.black, width: 0.5),
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
