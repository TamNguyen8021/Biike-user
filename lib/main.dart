import 'package:bikes_user/pages/feedback_page/binding/feedback_binding.dart';
import 'package:bikes_user/pages/feedback_page/view/feedback_page.dart';
import 'package:bikes_user/pages/book_schedule_trip/binding/book_schedule_trip_binding.dart';
import 'package:bikes_user/pages/book_trip/binding/book_trip_binding.dart';
import 'package:bikes_user/pages/choose_mode/binding/choose_mode_binding.dart';
import 'package:bikes_user/pages/choose_mode/view/choose_mode_page.dart';
import 'package:bikes_user/pages/exchange_voucher_page.dart';
import 'package:bikes_user/pages/edit_profile/binding/edit_profile_binding.dart';
import 'package:bikes_user/pages/edit_profile/view/edit_profile_page.dart';
import 'package:bikes_user/pages/home/binding/home_binding.dart';
import 'package:bikes_user/pages/home/view/home_page.dart';
import 'package:bikes_user/pages/profile_page.dart';
import 'package:bikes_user/pages/finding_biker_fail_page.dart';
import 'package:bikes_user/pages/finding_biker_page.dart';
import 'package:bikes_user/pages/finding_biker_success_page.dart';
import 'package:bikes_user/pages/get_trip_success_page.dart';
import 'package:bikes_user/pages/input_name/binding/input_name_binding.dart';
import 'package:bikes_user/pages/input_name/view/input_name_page.dart';
import 'package:bikes_user/pages/input_phone/binding/input_phone_binding.dart';
import 'package:bikes_user/pages/input_phone/view/input_phone_page.dart';
import 'package:bikes_user/pages/login_page.dart';
import 'package:bikes_user/pages/book_schedule_trip/view/book_schedule_trip_page.dart';
import 'package:bikes_user/pages/book_trip/view/book_trip_page.dart';
import 'package:bikes_user/pages/manage_bike/binding/manage_bike_binding.dart';
import 'package:bikes_user/pages/trip_details/binding/trip_details_binding.dart';
import 'package:bikes_user/pages/trip_details/view/trip_details_page.dart';
import 'package:bikes_user/pages/add_bike_page.dart';
import 'package:bikes_user/pages/manage_bike/view/manage_bike_page.dart';
import 'package:bikes_user/pages/trip_history_page.dart';
import 'package:bikes_user/pages/verify_phone/binding/verify_phone_binding.dart';
import 'package:bikes_user/pages/verify_phone/view/verify_phone_page.dart';
import 'package:bikes_user/pages/view_user_page.dart';
import 'package:bikes_user/pages/welcome_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Runs the application.
void main() {
  runApp(Biike());
}

/// This widget is the root of your application.
class Biike extends StatelessWidget {
  static Rx<Role> role = Role.None.obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Remove debug banner when running app.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Apply a combination of colors based on the provided one to entire app.
        primaryColor: CustomColors.kBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SVN Product Sans',
        appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            elevation: 0.0,
            backgroundColor: CustomColors.kBlue,
            titleTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
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
          contentPadding: const EdgeInsets.only(top: 12.0),
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
      ),
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/welcome', page: () => WelcomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(
            name: '/inputPhone',
            page: () => InputPhonePage(),
            binding: InputPhoneBinding()),
        GetPage(
            name: '/verifyPhone',
            page: () => VerifyPhonePage(),
            binding: VerifyPhoneBinding()),
        GetPage(
            name: '/inputName',
            page: () => InputNamePage(),
            binding: InputNameBinding()),
        GetPage(
            name: '/chooseMode',
            page: () => ChooseModePage(),
            binding: ChooseModeBinding()),
        GetPage(name: '/history', page: () => TripHistoryPage()),
        GetPage(
            name: '/driverHome',
            page: () => HomePage(),
            binding: HomeBinding()),
        GetPage(
            name: '/customerHome',
            page: () => HomePage(),
            binding: HomeBinding()),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
        ),
        GetPage(
            name: '/editProfile',
            page: () => EditProfilePage(),
            binding: EditProfileBinding()),
        GetPage(name: '/viewUser', page: () => ViewUserPage()),
        GetPage(
            name: '/feedback',
            page: () => FeedbackPage(),
            binding: FeedbackBinding()),
        GetPage(name: '/findBiker', page: () => FindingBikerPage()),
        GetPage(
            name: '/findBikerSuccess', page: () => FindingBikerSuccessPage()),
        GetPage(name: '/findBikerFail', page: () => FindingBikerFailPage()),
        GetPage(name: '/getTripSuccess', page: () => GetTripSuccessPage()),
        GetPage(name: '/exchangeVoucher', page: () => ExchangeVoucherPage()),
        GetPage(
            name: '/tripDetails',
            page: () => TripDetailsPage(
                  isWaitingForDriver: false,
                ),
            binding: TripDetailsBinding()),
        GetPage(
            name: '/bookTrip',
            page: () => BookTripPage(),
            binding: BookTripBinding()),
        GetPage(
            name: '/bookScheduleTrip',
            page: () => BookScheduleTripPage(),
            binding: BookScheduleTripBinding()),
        GetPage(
          name: '/manageBike',
          page: () => ManageBikePage(
            isBikeVerified: false,
          ),
          binding: ManageBikeBinding(),
        ),
        GetPage(
          name: '/addBike',
          page: () => AddBikePage(),
        ),
      ],
    );
  }
}
