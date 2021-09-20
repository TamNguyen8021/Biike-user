import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/create_trip_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/widgets/ad_container.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/widgets/top_biker.dart';
import 'package:bikes_user/app/ui/android/widgets/painters/tooltip_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// The home screen widget
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    List<String>? earliestUpcomingTripDate;
    int? earliestUpcomingTripDay;
    int? earliestUpcomingTripMonth;
    int? earliestUpcomingTripYear;

    List<String>? earliestUpcomingTripTime;
    int? earliestUpcomingTripHour;
    int? earliestUpcomingTripMin;
    DateTime? currentTime;
    String timeLeft = '';

    if (homeController.upcomingTrips.isNotEmpty) {
      earliestUpcomingTripDate =
          homeController.upcomingTrips[0].date.toString().split('Th');
      earliestUpcomingTripDay = int.parse(earliestUpcomingTripDate.first);
      earliestUpcomingTripMonth = int.parse(earliestUpcomingTripDate.last);
      earliestUpcomingTripYear = homeController.upcomingTrips[0].year;

      earliestUpcomingTripTime =
          homeController.upcomingTrips[0].time.toString().split(':');
      earliestUpcomingTripHour = int.parse(earliestUpcomingTripTime.first);
      earliestUpcomingTripMin = int.parse(earliestUpcomingTripTime.last);
      currentTime = DateTime.now();

      if (earliestUpcomingTripHour - currentTime.hour > 0) {
        timeLeft = timeLeft +
            (earliestUpcomingTripHour - currentTime.hour).toString() +
            CustomStrings.kReminderHour.tr;
      }

      if (timeLeft.isNotEmpty) {
        timeLeft = timeLeft +
            (earliestUpcomingTripMin - currentTime.minute).abs().toString() +
            CustomStrings.kReminderMinute.tr +
            CustomStrings.kReminderLeft.tr;
      } else if (earliestUpcomingTripHour == currentTime.hour &&
          earliestUpcomingTripMin - currentTime.minute > 0) {
        timeLeft = timeLeft +
            (earliestUpcomingTripMin - currentTime.minute).toString() +
            CustomStrings.kReminderMinute.tr +
            CustomStrings.kReminderLeft.tr;
      }
    }

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
                      if (homeController.upcomingTrips.isNotEmpty) ...[
                        if (earliestUpcomingTripDay == currentTime!.day &&
                            earliestUpcomingTripMonth == currentTime.month &&
                            earliestUpcomingTripYear == currentTime.year) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  Biike.role.value == Role.keer
                                      ? CustomStrings.kKeerReadyReminder.tr
                                      : CustomStrings.kBikerReadyReminder.tr,
                                  style:
                                      TextStyle(color: CustomColors.kDarkGray),
                                ),
                                Text(
                                  timeLeft,
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
                                phoneNo:
                                    homeController.upcomingTrips[0].phoneNo,
                                time: homeController.upcomingTrips[0].time,
                                date: CustomStrings.kToday.tr,
                                year: homeController.upcomingTrips[0].year,
                                sourceStation: homeController
                                    .upcomingTrips[0].sourceStation,
                                destinationStation: homeController
                                    .upcomingTrips[0].destinationStation),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ConfirmArrivalButton(
                                isOnHomeScreen: true,
                              ),
                              ContactButtons(
                                phoneNo:
                                    homeController.upcomingTrips[0].phoneNo,
                              )
                            ],
                          ),
                        ],
                      ]
                    ]),
              ),
              if (homeController.upcomingTrips.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Divider(),
                ),
                if (Biike.role.value == Role.keer) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AdContainer(),
                        if (homeController.upcomingTrips.length > 1) ...[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 35.0),
                            child: Text(
                              CustomStrings.kUpcomingTrips.tr,
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
                                  homeController.upcomingTrips.sublist(1),
                              itemPadding: 16.0,
                            ),
                          ),
                        ]
                      ],
                    ),
                  )
                ] else ...[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(CustomStrings.kFilter.tr,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: Icon(
                                                    Icons.event_outlined,
                                                  ),
                                                ),
                                                Text(
                                                  CustomStrings.kToday.tr,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: Icon(
                                                    Icons.access_time,
                                                  ),
                                                ),
                                                Text(
                                                  CustomStrings.kSelectHour.tr,
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
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
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
                                                CustomStrings.kSelectSourceStation.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              Expanded(
                                                child: Divider(),
                                              ),
                                              Text(
                                                CustomStrings.kSelectDestinationStation.tr,
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
                ]
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: SvgPicture.asset('assets/images/blank.svg'),
                ),
              ]
            ],
          ),
        ),
      ),
      floatingActionButton: Biike.role.value == Role.keer
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (homeController.upcomingTrips.isEmpty) ...[
                  CustomPaint(
                    foregroundPainter: TooltipPainter(),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      margin: const EdgeInsets.only(
                          bottom: 20.0, left: 22.0, right: 22.0),
                      decoration: BoxDecoration(
                        color: CustomColors.kLightGray,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        CustomStrings.kCreateTrip.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ],
                CreateTripButton(),
              ],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
