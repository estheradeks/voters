import 'package:flutter/material.dart';

// app theme
ThemeData votersTheme(context) => ThemeData(
      primaryColor: primaryColor,
      accentColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: bgColor,
      dividerColor: greyColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: blackColor,
            displayColor: blackColor,
          ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blackColor,
            width: 0.5,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: blackColor,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: redColor,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: redColor,
            width: 0.5,
          ),
        ),
      ),
    );

// colors
const Color primaryColor = Color(0xff06AB52);
const Color greyColor = Color(0xff9A9A9D);
const Color blackColor = Color(0xff000000);
const Color whiteColor = Color(0xffFFFFFF);
const Color bgColor = Color(0xffF2F2F2);
const Color redColor = Colors.red;
const Color transparentColor = Colors.transparent;
