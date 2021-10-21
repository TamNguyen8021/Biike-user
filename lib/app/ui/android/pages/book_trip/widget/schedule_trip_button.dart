import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleTripButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: CustomTextButton(
            backgroundColor: CustomColors.kOrange,
            foregroundColor: Colors.white,
            text: CustomStrings.kBookScheduleTrip.tr,
            onPressedFunc: () =>
                Get.toNamed(CommonRoutes.BOOK_SCHEDULE_TRIP)),
      ),
    );
  }
}