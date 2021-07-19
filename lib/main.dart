import 'package:bikes_user/pages/home_page.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/pages/open_page.dart';
import 'package:bikes_user/pages/trip_history_page.dart';
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
          primarySwatch: CustomColors.kBlue,
          fontFamily: 'SVN-Product-Sans'),
      initialRoute: '/home',
      routes: {
        '/open': (BuildContext ctx) => OpenPage(),
        '/history': (BuildContext ctx) => TripHistoryPage(),
        '/activity': (BuildContext ctx) => Activity(
              role: 'Customer',
            ),
        '/home': (BuildContext ctx) => HomePage(),
      },
    );
  }
}
