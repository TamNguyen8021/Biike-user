import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/app_bar.dart';
import 'package:bikes_user/widgets/bottom_navigation.dart';
import 'package:bikes_user/widgets/contact_buttons.dart';
import 'package:bikes_user/widgets/finish_trip_button.dart';
import 'package:bikes_user/widgets/list_trips.dart';
import 'package:bikes_user/widgets/trip_card.dart';
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
                          CustomStrings.customerMode,
                          style:
                              TextStyle(color: CustomColors.blue, fontSize: 10),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.lightGray),
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
                          CustomStrings.readyReminder,
                          style: TextStyle(
                              color: CustomColors.darkGray, fontSize: 14),
                        ),
                        Text(
                          '15' + CustomStrings.reminderTime,
                          style: TextStyle(
                              color: CustomColors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TripCard(
                        backgroundColor: CustomColors.blue,
                        foregroundColor: Colors.white,
                        iconColor: Colors.white,
                        avatarUrl: 'assets/images/test_avatar.jpg',
                        name: 'Phát Đỗ',
                        time: '06:45',
                        date: CustomStrings.today,
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
                      CustomStrings.today,
                      style:
                          TextStyle(color: CustomColors.darkGray, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTrips(list: [1]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      CustomStrings.otherDays,
                      style:
                          TextStyle(color: CustomColors.darkGray, fontSize: 14),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: ListTrips(list: [1, 2, 3, 4, 5])),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {},
          backgroundColor: CustomColors.orange,
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
