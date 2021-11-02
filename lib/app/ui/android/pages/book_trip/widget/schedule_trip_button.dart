import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleTripButton extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  _toNextScreen(BuildContext context) {
    if (_bookTripController.departureStation.value.stationId == -1 ||
        _bookTripController.destinationStation.value.stationId == -1) {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kNotChooseStation.tr);
      return;
    }

    Get.toNamed(CommonRoutes.BOOK_SCHEDULE_TRIP);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: CustomTextButton(
            hasBorder: false,
            backgroundColor: CustomColors.kOrange,
            foregroundColor: Colors.white,
            text: CustomStrings.kBookScheduleTrip.tr,
            onPressedFunc: () => _toNextScreen(context)),
      ),
    );
  }
}
