import 'package:bikes_user/pages/home/controller/home_controller.dart';
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
import 'package:get/get.dart';

/// The 'ke_er_home' screen widget
class CustomerHomeFull extends StatelessWidget {
  const CustomerHomeFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    List<String> earliestUpcomingTripDate =
        homeController.upcomingTrips[0].date.toString().split('Th');
    int earliestUpcomingTripDay = int.parse(earliestUpcomingTripDate.first);
    int earliestUpcomingTripMonth = int.parse(earliestUpcomingTripDate.last);

    List<String> earliestUpcomingTripTime =
        homeController.upcomingTrips[0].time.toString().split(':');
    int earliestUpcomingTripHour = int.parse(earliestUpcomingTripTime.first);
    int earliestUpcomingTripMin = int.parse(earliestUpcomingTripTime.last);
    DateTime currentTime = DateTime.now();

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TopBiker(),
                    ),
                    if (earliestUpcomingTripDay == currentTime.day &&
                        earliestUpcomingTripMonth == currentTime.month &&
                        earliestUpcomingTripHour == currentTime.hour &&
                        earliestUpcomingTripMin - currentTime.minute == 15) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
                            avatarUrl:
                                homeController.upcomingTrips[0].avatarUrl,
                            name: homeController.upcomingTrips[0].name,
                            time: homeController.upcomingTrips[0].time,
                            date: CustomStrings.kToday,
                            sourceStation:
                                homeController.upcomingTrips[0].sourceStation,
                            destinationStation: homeController
                                .upcomingTrips[0].destinationStation),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Divider(),
                      ),
                      homeController.upcomingTrips.removeAt(0)
                    ]
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AdContainer(),
                    if (homeController.upcomingTrips.length > 1) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 35.0),
                        child: Text(
                          CustomStrings.kUpcomingTrips,
                          style: TextStyle(color: CustomColors.kDarkGray),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: homeController.upcomingTrips.length > 2
                                ? 70.0
                                : 0.0),
                        child: ListUpcomingTrips(
                          listUpcomingTrips:
                              homeController.upcomingTrips.toList(),
                          itemPadding: 16.0,
                        ),
                      ),
                    ]
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
