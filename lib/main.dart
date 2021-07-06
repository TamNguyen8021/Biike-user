import 'package:bikes_user/pages/open_page.dart';
import 'package:flutter/material.dart';

/// Runs the application.
void main() {
  runApp(Bikes());
}

/// This widget is the root of your application.
class Bikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove debug banner when running app.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Apply a combination of colors based on the provided one to entire app.
          primarySwatch: Colors.blue,
          fontFamily: 'SVN-Product Sans'),
      home: OpenPage(),
    );
  }
}
