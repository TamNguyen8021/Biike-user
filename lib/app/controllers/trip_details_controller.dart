import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  Rx<String> buttonText = CustomStrings.kStartTrip.tr.obs;
  Rx<IconData> buttonIcon = Icons.navigation.obs;
  Function onPressedFunc = () {};

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
}
