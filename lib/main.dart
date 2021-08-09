import 'package:bikes_user/pages/biker_feedback_page.dart';
import 'package:bikes_user/pages/choose_role_page.dart';
import 'package:bikes_user/pages/driver_point_page.dart';
import 'package:bikes_user/pages/driver_profile_page.dart';
import 'package:bikes_user/pages/edit_profile_page.dart';
import 'package:bikes_user/pages/home_page.dart';
import 'package:bikes_user/pages/customer_profile_page.dart';
import 'package:bikes_user/pages/finding_biker_fail_page.dart';
import 'package:bikes_user/pages/finding_biker_page.dart';
import 'package:bikes_user/pages/finding_biker_success_page.dart';
import 'package:bikes_user/pages/get_trip_success_page.dart';
import 'package:bikes_user/pages/input_name_page.dart';
import 'package:bikes_user/pages/input_phone_page.dart';
import 'package:bikes_user/pages/keer_feedback_page.dart';
import 'package:bikes_user/pages/login_page.dart';
import 'package:bikes_user/pages/open_page.dart';
import 'package:bikes_user/pages/trip_history_page.dart';
import 'package:bikes_user/pages/verify_phone_page.dart';
import 'package:bikes_user/pages/view_user_page.dart';
import 'package:bikes_user/pages/welcome_page.dart';
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
        appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            elevation: 0.0,
            backgroundColor: CustomColors.kBlue,
            titleTextStyle: TextStyle(
                fontSize: 13,
                color: Colors.white,
                letterSpacing: 0.5,
                fontFamily: 'SVN Product Sans')),
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 12, color: CustomColors.kDarkGray),
            bodyText2: TextStyle(color: CustomColors.kDarkGray),
            button: TextStyle(fontSize: 10, color: Colors.white),
            headline1: TextStyle(fontSize: 25, color: Colors.white),
            headline2: TextStyle(
                fontSize: 18,
                color: CustomColors.kBlue,
                fontWeight: FontWeight.bold),
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
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.only(top: 12.0),
          labelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/open': (BuildContext ctx) => OpenPage(),
        '/welcome': (BuildContext ctx) => WelcomePage(),
        '/login': (BuildContext ctx) => LoginPage(),
        '/inputPhone': (BuildContext ctx) => InputPhonePage(),
        '/verifyPhone': (BuildContext ctx) => VerifyPhonePage(),
        '/inputName': (BuildContext ctx) => InputNamePage(),
        '/chooseRole': (BuildContext ctx) => ChooseRolePage(),
        '/history': (BuildContext ctx) => TripHistoryPage(),
        '/driverHome': (BuildContext ctx) => HomePage(
              role: 'Driver',
            ),
        '/customerHome': (BuildContext ctx) => HomePage(
              role: 'Customer',
            ),
        '/customerProfile': (BuildContext ctx) => CustomerProfilePage(
              role: 'Customer',
            ),
        '/driverProfile': (BuildContext ctx) => DriverProfilePage(
              role: 'Driver',
            ),
        '/editProfile': (BuildContext ctx) => EditProfilePage(),
        '/viewUser': (BuildContext ctx) => ViewUserPage(),
        '/bikerFeedback': (BuildContext ctx) => BikerFeedbackPage(),
        '/keerFeedback': (BuildContext ctx) => KeerFeedbackPage(),
        '/findBiker': (BuildContext ctx) => FindingBikerPage(),
        '/findBikerSuccess': (BuildContext ctx) => FindingBikerSuccessPage(),
        '/findBikerFail': (BuildContext ctx) => FindingBikerFailPage(),
        '/getTripSuccess': (BuildContext ctx) => GetTripSuccessPage(),
        '/exchangeVoucher': (BuildContext ctx) => DriverPointPage(),
      },
    );
  }
}
