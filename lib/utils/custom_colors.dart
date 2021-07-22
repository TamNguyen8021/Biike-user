import 'package:flutter/material.dart';

/// Contains custom color for the app
class CustomColors {
  static const Map<int, Color> _primaryColor = {
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

  static const blue = MaterialColor(0xFF0C6FF9, _primaryColor);
  static const darkBlue = Color(0xFF125BC2);
  static const lightBlue = Color(0xFFCBE1FF);
  static const lightGray = Color(0xFFF5F5F5);
  static const darkGray = Color(0xFF707070);
  static const orange = Color(0xFFFF7E1D);
  static const red = Color(0xFFFF0000);
  static const white = Color(0xFFFFFFFF);
}
