import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// On [HomePage] screen, this widget means user has arrived at the pick up point.
///
/// On [TripDetailsPage] screen, ke-er taps this button to finish a trip.
class ConfirmArrivalButton extends StatelessWidget {
  final isOnHomeScreen;

  ConfirmArrivalButton({Key? key, required this.isOnHomeScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isAtDestination = false.obs;
    Rx<Color> buttonColor = CustomColors.kBlue.obs;
    Rx<String> buttonText = CustomStrings.kConfirmArrival.obs;

    return SizedBox(
      height: 35,
      width: isOnHomeScreen ? 170 : null,
      child: Obx(() => ElevatedButton.icon(
            onPressed: () {
              if (isOnHomeScreen && isAtDestination.isFalse) {
                isAtDestination.value = true;
                buttonColor.value = CustomColors.kDarkGray;
                buttonText.value = CustomStrings.kArriveAtDestination.tr;
              } else if (!isOnHomeScreen) {
                Biike.role.value = Role.keer;
                Get.offAllNamed(CommonRoutes.FEEDBACK);
              }
            },
            icon: Icon(Icons.done_all, size: 25),
            label: Text(
              buttonText.value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width >= 400 ? 12 : 10),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              primary: buttonColor.value,
            ),
          )),
    );
  }
}
