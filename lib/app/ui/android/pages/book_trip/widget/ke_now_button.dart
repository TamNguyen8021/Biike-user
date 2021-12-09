import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeNowButton extends StatelessWidget {
  final _bookTripController = Get.find<BookTripController>();

  _bookKeNowTrip(BuildContext context) async {
    dynamic result = await _bookTripController.createKeNowTrip();

    if (result is bool) {
      Get.toNamed(CommonRoutes.FIND_BIKER);
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: result == '' ? CustomErrorsString.kError.tr : result)
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: CustomTextButton(
            hasBorder: false,
            backgroundColor: CustomColors.kBlue,
            foregroundColor: Colors.white,
            text: CustomStrings.kBookNowTrip.tr,
            onPressedFunc: () => _bookKeNowTrip(context)),
      ),
    );
  }
}
