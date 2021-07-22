import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/appbars/custom_appbar.dart';
// import 'package:bikes_user/widgets/appbars/bottom_tabbar.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/widgets/buttons/finish_trip_button.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:flutter/material.dart';

/// The state of the customer home page widget
class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

/// The customer home page widget
class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
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
                          CustomStrings.kCustomerMode,
                          style:
                              TextStyle(color: CustomColors.kBlue, fontSize: 10),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.kLightGray),
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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          CustomStrings.kCustomerReadyReminder,
                          style: TextStyle(
                              color: CustomColors.kDarkGray, fontSize: 14),
                        ),
                        Text(
                          '15' + CustomStrings.kReminderTime,
                          style: TextStyle(
                              color: CustomColors.kBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: UpcomingTripCard(
                        backgroundColor: CustomColors.kBlue,
                        foregroundColor: Colors.white,
                        iconColor: Colors.white,
                        avatarUrl: 'assets/images/test_avatar.jpg',
                        name: 'Phát Đỗ',
                        time: '06:45',
                        date: CustomStrings.kToday,
                        sourceStation: 'Đại học FPT TP.HCM',
                        destinationStation: 'Chung cư SKY9'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[FinishTripButton(), ContactButtons()],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(
                      width: double.infinity,
                      height: 135.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          'assets/images/demo_ads.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      CustomStrings.kToday,
                      style:
                          TextStyle(color: CustomColors.kDarkGray, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListUpcomingTrips(listUpcomingTrips: [1], isTodayFirstActivity: false, itemPadding: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      CustomStrings.kOtherDays,
                      style:
                          TextStyle(color: CustomColors.kDarkGray, fontSize: 14),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: ListUpcomingTrips(listUpcomingTrips: [1, 2, 3, 4, 5], isTodayFirstActivity: false, itemPadding: 16.0,)),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {},
          backgroundColor: CustomColors.kOrange,
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}
