import 'package:bikes_user/pages/biker_feedback_page.dart';
import 'package:bikes_user/pages/choose_mode.dart';
import 'package:bikes_user/pages/finding_biker_fail_page.dart';
import 'package:bikes_user/pages/finding_biker_page.dart';
import 'package:bikes_user/pages/finding_biker_success_page.dart';
import 'package:bikes_user/pages/get_trip_success_page.dart';
import 'package:bikes_user/pages/home_page.dart';
import 'package:bikes_user/pages/input_name.dart';
import 'package:bikes_user/pages/keer_feedback_page.dart';
import 'package:bikes_user/pages/open_page.dart';
import 'package:bikes_user/pages/trip_history_page.dart';
import 'package:bikes_user/pages/verify_phone.dart';
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
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'SVN Product Sans',
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              bodyText1: TextStyle(fontSize: 12, color: CustomColors.kDarkGray),
              bodyText2: TextStyle(color: CustomColors.kDarkGray),
              button: TextStyle(fontSize: 10, color: Colors.white)),
          tabBarTheme: TabBarTheme(
            indicatorSize: TabBarIndicatorSize.label,
          ),
          iconTheme: IconThemeData(color: CustomColors.kBlue, size: 15),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColors.kBlue),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: Colors.white, fontSize: 12))))),
      initialRoute: '/driverHome',
      routes: {
        '/open': (BuildContext ctx) => OpenPage(),
        '/history': (BuildContext ctx) => TripHistoryPage(),
        '/driverHome': (BuildContext ctx) => Verify(
        //       role: 'Driver',
        //     ),
        // '/customerHome': (BuildContext ctx) => HomePage(
        //       role: 'Customer',
            ),
      //   '/bikerFeedback': (BuildContext ctx) => BikerFeedbackPage(),
      //   '/keerFeedback': (BuildContext ctx) => KeerFeedbackPage(),
      //   '/findBiker': (BuildContext ctx) => FindingBikerPage(),
      //   '/findBikerSuccess': (BuildContext ctx) => FindingBikerSuccessPage(),
      //   '/findBikerFail': (BuildContext ctx) => FindingBikerFailPage(),
      //   '/getTripSuccess': (BuildContext ctx) => GetTripSuccessPage(),
      },
    );
  }
}
