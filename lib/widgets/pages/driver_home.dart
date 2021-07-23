import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/contact_buttons.dart';
import 'package:bikes_user/widgets/buttons/finish_trip_button.dart';
import 'package:bikes_user/widgets/cards/upcoming_trip_card.dart';
import 'package:bikes_user/widgets/lists/list_customers.dart';
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            CustomStrings.kDriverReadyReminder,
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
                          avatarUrl: 'assets/images/test_avatar.jpg',
                          name: 'Phát Đỗ',
                          time: '06:45',
                          date: CustomStrings.kToday,
                          sourceStation: 'Đại học FPT TP.HCM',
                          destinationStation: 'Chung cư SKY9'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[FinishTripButton(), ContactButtons()],
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
                                                color: CustomColors.kBlue,
                                                size: 15,
                                              ),
                                            ),
                                            Text(
                                              CustomStrings.kToday,
                                              style: TextStyle(
                                                  color: CustomColors.kDarkGray,
                                                  fontSize: 12),
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
                                                color: CustomColors.kBlue,
                                                size: 15,
                                              ),
                                            ),
                                            Text(
                                              CustomStrings.kSelectHour,
                                              style: TextStyle(
                                                  color: CustomColors.kDarkGray,
                                                  fontSize: 12),
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
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Icon(
                                              Icons.adjust,
                                              color: CustomColors.kBlue,
                                              size: 15,
                                            ),
                                          ),
                                          Text(
                                            CustomStrings.kSelectSourceStation,
                                            style: TextStyle(
                                                color: CustomColors.kDarkGray,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.more_vert_outlined,
                                            color: CustomColors.kBlue,
                                            size: 15,
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: CustomColors.kDarkGray
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          Icon(
                                            Icons.swap_vert_sharp,
                                            color: CustomColors.kBlue,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Icon(
                                              Icons.location_on,
                                              color: CustomColors.kBlue,
                                              size: 15,
                                            ),
                                          ),
                                          Text(
                                            CustomStrings
                                                .kSelectDestinationStation,
                                            style: TextStyle(
                                                color: CustomColors.kDarkGray,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: CustomColors.kLightGray),
              Container(
                child: ListCustomers(
                  listCustomers: [1],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
