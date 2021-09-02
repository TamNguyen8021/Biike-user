import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/widgets/buttons/confirm_arrival_button.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/widgets/lists/list_upcoming_trips.dart';
import 'package:bikes_user/widgets/others/ad_container.dart';
import 'package:bikes_user/widgets/others/top_biker.dart';
import 'package:flutter/material.dart';

/// The driver_home page widget
class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    TopBiker(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
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
                          avatarUrl: 'assets/images/profile-4.jpg',
                          name: 'Thảo Vân',
                          time: '06:35',
                          date: CustomStrings.kToday,
                          sourceStation: 'Đại học FPT TP.HCM',
                          destinationStation: 'Chung cư SKY9'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ConfirmArrivalButton(),
                        ContactButtons()
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: CustomColors.kLightGray,
                thickness: 1,
              ),
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
                                        Divider(
                                          color: CustomColors.kDarkGray
                                              .withOpacity(0.3),
                                        ),
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
                                            child: Divider(
                                              color: CustomColors.kDarkGray
                                                  .withOpacity(0.3),
                                            ),
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
              Divider(color: CustomColors.kLightGray),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5.0),
                child: Column(
                  children: <Widget>[
                    ListUpcomingTrips(
                      listUpcomingTrips: [1, 2, 3, 4],
                      itemPadding: 8.0,
                      isTodayFirstActivity: false,
                    ),
                    AdContainer(),
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
