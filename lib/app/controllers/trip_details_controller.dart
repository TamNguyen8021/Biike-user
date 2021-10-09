import 'dart:convert';

import 'package:bikes_user/app/data/models/trip_feedback.dart';
import 'package:bikes_user/app/data/models/trip.dart';
import 'package:bikes_user/app/data/models/user.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  Rx<String> buttonText = CustomStrings.kStartTrip.tr.obs;
  Rx<IconData> buttonIcon = Icons.navigation.obs;
  Function onPressedFunc = () {};
  Trip trip = Trip.empty();
  User user = User.empty();

  /// Feedback of user
  TripFeedback feedback1 = TripFeedback.empty();

  /// Feedback of trip partner
  TripFeedback feedback2 = TripFeedback.empty();

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

  /// Loads trip details
  ///
  /// Author: TamNTT
  Future<void> getTripDetails({required BuildContext context}) async {
    String response = await DefaultAssetBundle.of(context)
        .loadString('assets/files/trip_details.json');
    var data = jsonDecode(response);
    // print('data: ' + data.toString());
    trip = Trip.fromJson(data);
    // print(trip.toJson());
    user = User.fromJson(data);
    // print(user.toJson());
    if (data['feedbacks'].length > 0) {
      feedback1 = TripFeedback.fromJson(data['feedbacks'][0]);
      // print(feedback1.toJson());
      feedback2 = TripFeedback.fromJson(data['feedbacks'][1]);
    }
    // print(feedback2.toJson());
  }
}
