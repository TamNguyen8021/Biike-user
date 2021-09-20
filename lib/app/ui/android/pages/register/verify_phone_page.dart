import 'package:bikes_user/app/controllers/verify_phone_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/previous_page_button.dart';
import 'package:bikes_user/app/ui/android/pages/trip_history/widgets/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// The '004.2_verify_phone' screen
class VerifyPhonePage extends StatelessWidget {
  final verifyPhoneController = Get.find<VerifyPhoneController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              CustomStrings.kInputVerifyCode.tr,
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              width: 200.0,
              margin: const EdgeInsets.only(bottom: 5.0, top: 10.0),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                cursorColor: CustomColors.kBlue,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 40),
                pastedTextStyle: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 40),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: CustomColors.kLightGray,
                  inactiveColor: CustomColors.kLightGray,
                ),
                onChanged: (code) {
                  verifyPhoneController.inputVerifyCode(code);
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Icon(
                    Icons.refresh,
                    color: CustomColors.kDarkGray,
                  ),
                ),
                Text(
                  CustomStrings.kResendVerifyCode.tr,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            ErrorText(
              errorText: CustomStrings.kInvalidPin.tr,
              marginTop: 25.0,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PreviousPageButton(
              onPressedFunc: () => Get.back(),
              backgroundColor: CustomColors.kBlue,
              foregroundColor: Colors.white,
              hoverColor: CustomColors.kDarkGray,
            ),
            NextPageButton(
              onPressedFunc: () => Get.offAllNamed(CommonRoutes.INPUT_NAME),
              backgroundColor: CustomColors.kBlue,
              foregroundColor: Colors.white,
              hoverColor: CustomColors.kDarkGray,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
