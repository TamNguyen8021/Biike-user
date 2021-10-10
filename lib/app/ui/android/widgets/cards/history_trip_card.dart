import 'package:bikes_user/app/bindings/view_user_binding.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/ui/android/pages/view_user/view_user_page.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This widget contains a history trip's details
class HistoryTripCard extends StatelessWidget {
  final int userId;
  final String time;
  final String date;
  final TripStatus status;
  final String sourceStation;
  final String destinationStation;

  const HistoryTripCard(
      {required this.userId,
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
    double screenWidth = MediaQuery.of(context).size.width;

    if (status != TripStatus.finished) {
      _statusColor = CustomColors.kRed;
    }

    switch (status) {
      case TripStatus.finding:
      case TripStatus.waiting:
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
                                right: screenWidth >= 400 ? 16.0 : 5.0),
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
      // onTap: () => Get.toNamed(CommonRoutes.VIEW_USER),
      onTap: () => Get.to(() => ViewUserPage(userId: userId),
          binding: ViewUserBinding()),
    );
  }
}
