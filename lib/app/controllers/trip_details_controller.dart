import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/models/destination_station.dart';
import 'package:bikes_user/app/data/models/departure_station.dart';
import 'package:bikes_user/app/data/models/trip_feedback.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/data/providers/trip_details_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  final _tripDetailsProvider = Get.put(TripDetailsProvider());

  Rx<String> buttonText = CustomStrings.kStartTrip.tr.obs;
  Rx<IconData> buttonIcon = Icons.navigation.obs;
  Function onPressedFunc = () {};
  Trip trip = Trip.empty();
  User user = User.empty();
  DepartureStation departureStation = DepartureStation.empty();
  DestinationStation destinationStation = DestinationStation.empty();

  /// Feedback of user
  TripFeedback feedback1 = TripFeedback.empty();

  /// Feedback of trip partner
  TripFeedback feedback2 = TripFeedback.empty();

  Rx<String> _cancelReason = ''.obs;

  changeToFinishTripButton() {
    if (buttonText.value != CustomStrings.kCompleteTrip.tr) {
      buttonText.value = CustomStrings.kCompleteTrip.tr;
    }

    if (buttonIcon.value != Icons.done_all) {
      buttonIcon.value = Icons.done_all;
    } else {
      Get.offAllNamed(CommonRoutes.FEEDBACK);
    }
  }

  /// Loads trip details.
  ///
  /// Author: TamNTT
  Future<void> getTripDetails({required int tripId}) async {
    var data = await _tripDetailsProvider.getTripDetails(tripId: tripId);
    trip = Trip.fromJson(data);
    user = User.fromJson(data);
    departureStation = DepartureStation.fromJson(data);
    destinationStation = DestinationStation.fromJson(data);
    if (data['feedbacks'].length > 0) {
      feedback1 = TripFeedback.fromJson(data['feedbacks'][0]);
      feedback2 = TripFeedback.fromJson(data['feedbacks'][1]);
    }
  }

  /// Loads location details.
  ///
  /// Author: TamNTT
  Future<Map<String, String>> getLocationDetails(
      {required double latitude, required double longtitude}) async {
    Map<String, String> data = await _tripDetailsProvider.getLocationDetails(
        latitude: latitude, longtitude: longtitude);
    return data;
  }

  /// Cancel a trip based on [tripId].
  ///
  /// Author: TamNTT
  Future<void> cancelTrip(
      {required BuildContext context,
      required int tripId,
      required String cancelReason}) async {
    Map<String, String> body = {'cancelReason': cancelReason};
    bool response = await _tripDetailsProvider.cancelTrip(
        tripId: tripId, body: jsonEncode(body));
    if (response) {
      Get.back();
      Get.back();
      CommonFunctions().showSuccessDialog(
          context: context, message: CustomStrings.kCancelTripSuccess);
    } else {
      Get.back();
      Get.back();
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError);
    }
  }

  /// Display a dialog on [context] to enter cancel reason.
  ///
  /// Author: TamNTT
  dynamic showCancelReasonDialog(
      {required BuildContext context, required int tripId}) {
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
                    CustomStrings.kLetUsKnowYourCancelReason.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (String text) {
                        _cancelReason.value = text;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        hintText: CustomStrings.kEnterYourCancelReason.tr,
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
                              backgroundColor: CustomColors.kRed,
                              foregroundColor: Colors.white,
                              text: CustomStrings.kCancel.tr,
                              onPressedFunc: () {
                                cancelTrip(
                                    context: context,
                                    tripId: tripId,
                                    cancelReason: _cancelReason.value);
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
}
