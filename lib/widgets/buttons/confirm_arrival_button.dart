import 'package:bikes_user/pages/home/view/home_page.dart';
import 'package:bikes_user/pages/trip_details/view/trip_details_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// On [HomePage] screen, this widget means user has arrived at the pick up point.
///
/// On [TripDetailsPage] screen, customer taps this button to finish a trip.
class ConfirmArrivalButton extends StatelessWidget {
  final isOnHomeScreen;

  ConfirmArrivalButton({Key? key, required this.isOnHomeScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isAtDestination = false.obs;
    Rx<Color> buttonColor = CustomColors.kBlue.obs;
    Rx<String> buttonText = CustomStrings.kConfirmFinishTrip.obs;

    return SizedBox(
      height: 35,
      width: isOnHomeScreen ? 152 : null,
      child: Obx(() => ElevatedButton.icon(
            onPressed: () {
              if (isOnHomeScreen && isAtDestination.isFalse) {
                isAtDestination.value = true;
                buttonColor.value = CustomColors.kDarkGray;
                buttonText.value = CustomStrings.kArriveAtDestination;
              } else if (!isOnHomeScreen) {
                Get.offAllNamed('/keerFeedback');
              }
            },
            icon: Icon(Icons.done_all, size: 25),
            label: Text(
              buttonText.value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: buttonColor.value,
            ),
          )),
    );
  }
}
