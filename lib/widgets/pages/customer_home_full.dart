import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/widgets/others/ad_container.dart';
import 'package:bikes_user/widgets/others/top_biker.dart';
import 'package:flutter/material.dart';

/// The 'ke_er_home' screen widget
class CustomerHomeFull extends StatelessWidget {
  const CustomerHomeFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBiker(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            CustomStrings.kCustomerReadyReminder,
                            style: TextStyle(color: CustomColors.kDarkGray),
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
                          avatarUrl: 'assets/images/profile-1.jpg',
                          name: 'Phát Đỗ',
                          time: '06:45',
                          date: CustomStrings.kToday,
                          sourceStation: 'Đại học FPT TP.HCM',
                          destinationStation: 'Chung cư SKY9'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ConfirmArrivalButton(
                          isOnHomeScreen: true,
                        ),
                        ContactButtons()
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(
                  color: CustomColors.kLightBlue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AdContainer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        CustomStrings.kToday,
                        style: TextStyle(color: CustomColors.kDarkGray),
                      ),
                    ),
                    ListUpcomingTrips(
                      listUpcomingTrips: [1],
                      itemPadding: 16.0,
                      isTodayFirstActivity: false,
                    ),
                    AdContainer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        CustomStrings.kOtherDays,
                        style: TextStyle(color: CustomColors.kDarkGray),
                      ),
                    ),
                    ListUpcomingTrips(
                      listUpcomingTrips: [1, 2, 3, 4, 5],
                      itemPadding: 16.0,
                      isTodayFirstActivity: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: AdContainer(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CreateTripButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
