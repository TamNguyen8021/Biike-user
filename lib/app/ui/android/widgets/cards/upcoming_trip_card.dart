import 'dart:io';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// This widget contains an upcoming trip's details
class UpcomingTripCard extends StatelessWidget {
  final _tripProvider = Get.find<TripProvider>();
  final _homeController = Get.find<HomeController>();

  final bool isSearchedTrip;
  final int tripId;
  final int userId;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final String avatarUrl;
  final String name;
  final String phoneNo;
  final String bookTime;
  final String departureStation;
  final String destinationStation;

  UpcomingTripCard(
      {Key? key,
      required this.isSearchedTrip,
      required this.tripId,
      required this.userId,
      this.backgroundColor,
      this.foregroundColor,
      this.iconColor,
      required this.avatarUrl,
      required this.name,
      required this.phoneNo,
      required this.bookTime,
      required this.departureStation,
      required this.destinationStation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.tryParse(bookTime) ?? DateTime.now();
    String _date = _dateTime.day.toString() +
        ' Th ' +
        _dateTime.month.toString() +
        ', ' +
        _dateTime.year.toString();
    Rx<bool> _isStationVisible = true.obs;

    if (Platform.localeName == 'en_US') {
      _date = DateFormat.MMM().format(_dateTime) +
          ' ' +
          _dateTime.day.toString() +
          ', ' +
          _dateTime.year.toString();
    }

    return GestureDetector(
      onTap: () {
        if (!isSearchedTrip) {
          Get.toNamed(CommonRoutes.TRIP_DETAILS,
              arguments: {'tripId': tripId, 'route': 'home'});
        } else {
          _isStationVisible.value = !_isStationVisible.value;
        }
      },
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
                      if (name != CustomStrings.kFinding) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: SvgPicture.asset(
                            'assets/images/loading.svg',
                            height: 50,
                          ),
                        ),
                      ],
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: foregroundColor != null
                                          ? foregroundColor
                                          : CustomColors.kDarkGray,
                                      fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                DateFormat('HH:mm').format(_dateTime),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: foregroundColor != null
                                            ? foregroundColor
                                            : CustomColors.kDarkGray),
                              ),
                            ),
                            Text(
                              _date,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: foregroundColor != null
                                          ? foregroundColor
                                          : CustomColors.kDarkGray),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => _isStationVisible.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.adjust,
                                  color: iconColor != null
                                      ? iconColor
                                      : CustomColors.kBlue,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  departureStation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: foregroundColor != null
                                              ? foregroundColor
                                              : CustomColors.kDarkGray),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Icon(
                              Icons.more_vert_outlined,
                              color: iconColor != null
                                  ? iconColor
                                  : CustomColors.kBlue,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.location_on,
                                  color: iconColor != null
                                      ? iconColor
                                      : CustomColors.kBlue,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  destinationStation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: foregroundColor != null
                                              ? foregroundColor
                                              : CustomColors.kDarkGray),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextButton(
                            backgroundColor: CustomColors.kBlue,
                            foregroundColor: Colors.white,
                            text: CustomStrings.kAccept.tr,
                            onPressedFunc: () async {
                              bool isSuccess = await _tripProvider.acceptTrip(
                                  tripId: tripId);
                              if (isSuccess) {
                                CommonFunctions().showSuccessDialog(
                                    context: context,
                                    message:
                                        CustomStrings.kAcceptSuccessful.tr);
                              } else {
                                CommonFunctions().showErrorDialog(
                                    context: context,
                                    message:
                                        CustomErrorsString.kDevelopError.tr);
                              }
                              await _homeController.searchTrips(
                                  date: _homeController.searchDate.value,
                                  time: _homeController.searchTime.value,
                                  departureId: _homeController
                                      .departureStation.value.stationId,
                                  destinationId: _homeController
                                      .destinationStation.value.stationId);
                            },
                            hasBorder: false),
                      ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: backgroundColor != null
                ? backgroundColor
                : CustomColors.kLightGray,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: CustomColors.kDarkGray.withOpacity(0.5),
                // changes position of shadow
                offset: Offset(0, 1),
              )
            ]),
      ),
    );
  }
}
