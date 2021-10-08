import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/trip_status_enum.dart';
import 'package:bikes_user/app/data/providers/view_user_provider.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/data/models/area.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/starting_station.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/history_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewUserController extends GetxController {
  final _viewUserProvider = Get.put(ViewUserProvider());

  User user = User.empty();
  Area area = Area.empty();
  RxList<dynamic> historyTrips = [].obs;

  /// Gets partner's profile and shows it on [context] .
  ///
  /// Author: TamNTT
  Future<void> getPartnerProfile(
      {required BuildContext context, required int partnerId}) async {
    var partnerProfile =
        await _viewUserProvider.getPartnerProfile(partnerId: partnerId);
    // print('data: ' + data.toString());
    // print('data length: ' + data.length.toString());
    user = User.fromJson(partnerProfile);
    area = Area.fromJson(partnerProfile);
    // print(user.toJson());
  }

  /// Gets history trips with partner and shows it on [context].
  ///
  /// Author: TamNTT
  Future<void> getHistoryTripsWithPartner(
      {required BuildContext context,
      required int userId,
      required int partnerId}) async {
    historyTrips.clear();
    List historyTripsWithPartner = await _viewUserProvider.getHistoryPairTrips(
        userId: userId, partnerId: partnerId);
    // print('data: ' + tempHistoryTrips.toString());
    for (var historyTrip in historyTripsWithPartner) {
      // print(item);
      User user = User.fromJson(historyTrip);
      // print(user.toJson());
      Trip trip = Trip.fromJson(historyTrip);
      // print(trip.toJson());
      StartingStation startingStation = StartingStation.fromJson(historyTrip);
      // print(startingStation.toJson());
      DestinationStation destinationStation =
          DestinationStation.fromJson(historyTrip);
      // print(destinationStation.toJson());
      TripStatus tripStatus;
      String date = DateTime.parse(trip.timeBook).day.toString() +
          ' Th ' +
          DateTime.parse(trip.timeBook).month.toString();

      switch (trip.tripStatus) {
        case 1:
          tripStatus = TripStatus.finding;
          break;
        case 2:
          tripStatus = TripStatus.waiting;
          break;
        case 3:
          tripStatus = TripStatus.started;
          break;
        case 4:
          tripStatus = TripStatus.finished;
          break;
        case 5:
          tripStatus = TripStatus.canceled;
          break;
        default:
          tripStatus = TripStatus.none;
          Get.defaultDialog(
              title: CustomErrorsString.kError.tr,
              middleText: CustomErrorsString.kErrorMessage.tr);
      }

      HistoryTripCard historyTripCard = HistoryTripCard(
          userId: user.userId,
          avatarUrl: user.avatar,
          name: user.userFullname,
          time: DateFormat('HH:mm').format(DateTime.parse(trip.timeBook)),
          date: date,
          status: tripStatus,
          sourceStation: startingStation.startingPointName,
          destinationStation: destinationStation.destinationName);

      historyTrips.add(historyTripCard);
      // print(historyTrips.length);
    }
  }

  /// Display a dialog on [context] to report a user.
  ///
  /// Author: TamNTT
  dynamic showReportDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kReport.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        hintText: CustomStrings.kEnterYourReport.tr,
                        filled: true,
                        fillColor: CustomColors.kLightGray,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextButton(
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReport.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
                              }),
                          CustomTextButton(
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kReportAndBlock.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showConfirmBlockDialog(context: context);
                              }),
                          CustomTextButton(
                              backgroundColor: CustomColors.kLightGray,
                              foregroundColor: CustomColors.kDarkGray,
                              text: CustomStrings.kBtnExit.tr,
                              onPressedFunc: () {
                                Get.back();
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Display a dialog on [context] to confirm if user wants to block another user.
  ///
  /// Author: TamNTT
  dynamic _showConfirmBlockDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kConfirmBlock.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 30.0),
                    child: Text(
                      CustomStrings.kSeeBlacklist.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CustomTextButton(
                              backgroundColor: CustomColors.kBlue,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kSure.tr,
                              onPressedFunc: () {
                                Get.back();
                                _showThankYouForReportDialog(context: context);
                              }),
                          CustomTextButton(
                              backgroundColor: CustomColors.kLightGray,
                              foregroundColor: CustomColors.kDarkGray,
                              text: CustomStrings.kBtnExit.tr,
                              onPressedFunc: () {
                                Get.back();
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Display a dialog on [context] to thank you user for their report.
  ///
  /// Author: TamNTT
  dynamic _showThankYouForReportDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CustomStrings.kThankYouForReport.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      CustomStrings.kSorryMessage.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Center(
                    child: CustomTextButton(
                        width: 100,
                        backgroundColor: CustomColors.kLightGray,
                        foregroundColor: CustomColors.kDarkGray,
                        text: CustomStrings.kBtnExit.tr,
                        onPressedFunc: () {
                          Get.back();
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
