import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/pages/activity.dart';
import 'package:bikes_user/widgets/pages/customer_home_full.dart';
import 'package:flutter/material.dart';

/// The home screen template for both ke-er and biker
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget homePage = CustomerHomeFull();
    Widget activityPage = Activity(
      role: 'Customer',
    );
    String role = 'Customer';
    String modeButtonText = CustomStrings.kCustomerMode;
    Color modeButtonForegroundColor = CustomColors.kBlue;
    Color modeButtonBackgroundColor = CustomColors.kLightGray;
    if (role != 'Customer') {
      homePage = CustomerHomeFull();
      activityPage = Activity(
        role: 'Driver',
      );
      modeButtonText = CustomStrings.kBikerMode;
      modeButtonBackgroundColor = CustomColors.kOrange;
      modeButtonForegroundColor = Colors.white;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-white.png',
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Text(
                          modeButtonText,
                          style: TextStyle(
                              color: modeButtonForegroundColor, fontSize: 10),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              modeButtonBackgroundColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionWidgets: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[homePage, activityPage],
        ),
        bottomNavigationBar: BottomTabBar(),
      ),
    );
  }
}
