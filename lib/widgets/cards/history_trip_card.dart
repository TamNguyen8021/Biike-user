import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget contains a history trip's details
class HistoryTripCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String time;
  final String date;
  final TripStatus status;
  final String sourceStation;
  final String destinationStation;

  HistoryTripCard(
      {required this.avatarUrl,
      required this.name,
      required this.time,
      required this.date,
      required this.status,
      required this.sourceStation,
      required this.destinationStation,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _statusColor = CustomColors.kBlue;
    String _statusText = '';

    if (status != TripStatus.Finished) {
      _statusColor = CustomColors.kRed;
    }

    switch (status) {
      case TripStatus.Finding:
      case TripStatus.Waiting:
      case TripStatus.Started:
      case TripStatus.Finished:
        _statusText = CustomStrings.kTripFinished;
        break;
      case TripStatus.Canceled:
        _statusText = CustomStrings.kTripCanceled;
        break;
      default:
    }

    return GestureDetector(
      child: Container(
        height: 82,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  time,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Text(
                                date,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
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
                    ],
                  ),
                ],
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
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.adjust,
                        ),
                      ),
                      Text(
                        sourceStation,
                        style: Theme.of(context).textTheme.bodyText1,
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
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.location_on,
                        ),
                      ),
                      Text(
                        destinationStation,
                        style: Theme.of(context).textTheme.bodyText1,
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
                spreadRadius: 0.5,
                blurRadius: 0.5,
                // changes position of shadow
                offset: Offset(0, 0.5),
              )
            ]),
      ),
      onTap: () => Get.toNamed('/viewUser'),
    );
  }
}
