import 'package:flutter/material.dart';

/// Contains custom color for the app
class CustomColors {
  static const Map<int, Color> _kPrimaryColor = {
    50: Color.fromRGBO(12, 111, 249, .1),
    100: Color.fromRGBO(12, 111, 249, .2),
    200: Color.fromRGBO(12, 111, 249, .3),
    300: Color.fromRGBO(12, 111, 249, .4),
    400: Color.fromRGBO(12, 111, 249, .5),
    500: Color.fromRGBO(12, 111, 249, .6),
    600: Color.fromRGBO(12, 111, 249, .7),
    700: Color.fromRGBO(12, 111, 249, .8),
    800: Color.fromRGBO(12, 111, 249, .9),
    900: Color.fromRGBO(12, 111, 249, 1),
  };

  static const kBlue = MaterialColor(0xFF0C6FF9, _kPrimaryColor);
  static const kDarkBlue = Color(0xFF125BC2);
  static const kLightBlue = Color(0xFFCBE1FF);
  static const kLightGray = Color(0xFFF5F5F5);
  static const kDarkGray = Color(0xFF707070);
  static const kOrange = Color(0xFFFF7E1D);
  static const kRed = Color(0xFFFF0000);
}
