import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookScheduledTripButton extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  Future<void> _bookScheduledTrip(BuildContext context) async {
    var result = await _bookTripController.createScheduledTrip();

    if (result is bool) {
      Get.offAllNamed(CommonRoutes.HOME);
    } else {
      CommonFunctions().showErrorDialog(context: context, message: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: CustomTextButton(
            hasBorder: false,
            backgroundColor: CustomColors.kOrange,
            foregroundColor: Colors.white,
            width: 135,
            text: CustomStrings.kBookScheduleTrip.tr,
            onPressedFunc: () => _bookScheduledTrip(context)),
      ),
    );
  }
}
