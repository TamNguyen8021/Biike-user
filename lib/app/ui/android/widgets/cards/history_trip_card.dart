import 'dart:io';

import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// This widget contains a history trip's details
class HistoryTripCard extends StatelessWidget {
  final int tripId;
  final int userId;
  final DateTime dateTime;
  final TripStatus status;
  final String sourceStation;
  final String destinationStation;
  final bool isOnViewUserPage;

  const HistoryTripCard(
      {required this.tripId,
      required this.userId,
      required this.dateTime,
      required this.status,
      required this.sourceStation,
      required this.destinationStation,
      required this.isOnViewUserPage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _statusColor = CustomColors.kBlue;
    String _statusText = '';
    double _screenWidth = MediaQuery.of(context).size.width;
    String _date = dateTime.day.toString() +
        ' Th ' +
        dateTime.month.toString() +
        ', ' +
        dateTime.year.toString();

    if (Platform.localeName == 'en_US') {
      _date = DateFormat.MMM().format(dateTime) +
          ' ' +
          dateTime.day.toString() +
          ', ' +
          dateTime.year.toString();
    }

    if (status != TripStatus.finished) {
      _statusColor = CustomColors.kRed;
    }

    switch (status) {
      case TripStatus.finding:
      case TripStatus.waiting:
      case TripStatus.matched:
      case TripStatus.started:
      case TripStatus.finished:
        _statusText = CustomStrings.kTripFinished.tr;
        break;
      case TripStatus.canceled:
        _statusText = CustomStrings.kTripCanceled.tr;
        break;
      default:
    }

    return GestureDetector(
        child: Container(
          height: 82,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  right: _screenWidth >= 400 ? 16.0 : 5.0),
                              child: Text(
                                DateFormat('HH:mm').format(dateTime),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Text(
                              _date,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _statusText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: _statusColor),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.adjust,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            sourceStation,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Icon(
                        Icons.more_vert_outlined,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.location_on,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            destinationStation,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: CustomColors.kLightGray,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CustomColors.kDarkGray.withOpacity(0.5),
                  // changes position of shadow
                  offset: Offset(0, 1),
                )
              ]),
        ),
        onTap: () {
          if (!isOnViewUserPage) {
            Get.toNamed(CommonRoutes.TRIP_DETAILS, arguments: {
              'tripId': tripId,
              'userId': userId,
              'route': 'history'
            });
          }
        });
  }
}
