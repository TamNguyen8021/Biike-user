import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripDetailsController extends GetxController {
  Rx<String> buttonText = CustomStrings.kStartTrip.obs;
  Rx<IconData> buttonIcon = Icons.navigation.obs;
  Function onPressedFunc = () {};

  changeToFinishTripButton() {
    if (buttonText.value != CustomStrings.kCompleteTrip) {
      buttonText.value = CustomStrings.kCompleteTrip;
    }

    if (buttonIcon.value != Icons.done_all) {
      buttonIcon.value = Icons.done_all;
    } else {
      Get.offAllNamed('/feedback');
    }
  }
}
