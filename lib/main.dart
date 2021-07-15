import 'package:bikes_user/pages/customer_home_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// Runs the application.
void main() {
  runApp(Biike());
}

/// This widget is the root of your application.
class Biike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove debug banner when running app.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Apply a combination of colors based on the provided one to entire app.
          primarySwatch: CustomColors.blue,
          fontFamily: 'SVN-Product-Sans'),
      home: CustomerHomePage(),
    );
  }
}
