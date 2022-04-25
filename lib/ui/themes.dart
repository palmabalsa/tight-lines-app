import 'package:flutter/material.dart';

class Themes {

  static final light = ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal.shade50,

        fontFamily:'Sofiapro',


        textTheme: const TextTheme(
        headline1: TextStyle(),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.white),
        headline6: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w900),
        bodyText2: TextStyle(),
        ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontWeight: FontWeight.w900,
        ),
        contentPadding: EdgeInsets.all(8.0),
        fillColor: Colors.teal.shade50,
        filled: true,
        // dropdownColor: Colors.teal.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(99)
          ),
          borderSide: BorderSide.none
        ),
      ),
      );

}