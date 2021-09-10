import 'package:bikes_user/pages/home/controller/home_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/widgets/others/ad_container.dart';
import 'package:bikes_user/widgets/others/top_biker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The driver_home page widget
class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 4.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
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
                              CustomStrings.kDriverReadyReminder,
                              style: Theme.of(context).textTheme.bodyText2,
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
                    ] else ...[
                      AdContainer(),
                    ]
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(CustomStrings.kFilter,
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.kLightGray,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: CustomColors.kDarkGray
                                              .withOpacity(0.4),
                                          // changes position of shadow
                                          offset: Offset(0, 1),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(
                                                Icons.event_outlined,
                                              ),
                                            ),
                                            Text(
                                              CustomStrings.kToday,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(
                                                Icons.access_time,
                                              ),
                                            ),
                                            Text(
                                              CustomStrings.kSelectHour,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: CustomColors.kLightGray,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: CustomColors.kDarkGray
                                            .withOpacity(0.4),
                                        // changes position of shadow
                                        offset: Offset(0, 1),
                                      )
                                    ]),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(
                                            Icons.adjust,
                                          ),
                                          Icon(
                                            Icons.more_vert_outlined,
                                          ),
                                          Icon(
                                            Icons.location_on,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            CustomStrings.kSelectSourceStation,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Expanded(
                                            child: Divider(),
                                          ),
                                          Text(
                                            CustomStrings
                                                .kSelectDestinationStation,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.swap_vert_sharp,
                                      size: 30,
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 5.0, 22.0,
                    homeController.upcomingTrips.length > 2 ? 35.0 : 8.0),
                child: Column(
                  children: <Widget>[
                    // if (homeController.upcomingTrips.isNotEmpty) ...[
                    //   ListUpcomingTrips(
                    //     listUpcomingTrips:
                    //         homeController.upcomingTrips.toList(),
                    //     itemPadding: 12.0,
                    //   ),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
