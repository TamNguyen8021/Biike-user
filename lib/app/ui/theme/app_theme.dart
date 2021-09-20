import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  // Apply a combination of colors based on the provided one to entire app.
  primaryColor: CustomColors.kBlue,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'SVN Product Sans',
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          backgroundColor: CustomColors.kBlue,
          color: Colors.white,
          fontFamily: 'SVN Product Sans')),
  textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 12, color: CustomColors.kDarkGray),
      bodyText2: TextStyle(color: CustomColors.kDarkGray),
      button: TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      headline1: TextStyle(fontSize: 25, color: CustomColors.kBlue),
      headline2: TextStyle(
          fontSize: 18,
          color: CustomColors.kBlue,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
        fontSize: 16,
        color: CustomColors.kDarkGray,
      ),
      headline6: TextStyle(
          fontWeight: FontWeight.bold,
          color: CustomColors.kDarkGray,
          fontSize: 14),
      subtitle1: TextStyle(color: Colors.white, fontSize: 10)),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
  ),
  iconTheme: IconThemeData(color: CustomColors.kBlue, size: 15),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(CustomColors.kBlue),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: Colors.white, fontSize: 12)),
          elevation: MaterialStateProperty.all<double>(2.0))),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle:
        MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 12)),
      )),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.only(top: 8.0),
    labelStyle: TextStyle(fontWeight: FontWeight.normal),
    enabledBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
    focusedBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
    errorBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: CustomColors.kDarkGray.withOpacity(0.2))),
  ),
);