import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/verify_phone_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/previous_page_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// The '004.2_verify_phone' screen
class VerifyPhonePage extends StatelessWidget {
  final _verifyPhoneController = Get.find<VerifyPhoneController>();
  final String fullPhone = Get.arguments['phone'];

  VerifyPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerOtp = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              CustomStrings.kInputVerifyCode.tr,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: PinCodeTextField(
                appContext: context,
                // controller: controllerOtp,
                length: 6,
                keyboardType: TextInputType.number,
                cursorColor: CustomColors.kBlue,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 40.sp),
                pastedTextStyle: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 40.sp),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeColor: CustomColors.kBlue,
                  inactiveColor: CustomColors.kBlue,
                  activeFillColor: Colors.red,
                  inactiveFillColor: Colors.blue,
                ),
                onChanged: (code) {
                  controllerOtp.text = code;
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
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
            GetBuilder<VerifyPhoneController>(
                init: _verifyPhoneController,
                builder: (VerifyPhoneController controller) {
                  return NextPageButton(
                    onPressedFunc: () => controller.verifyOtp(
                        context: context,
                        otp: controllerOtp.text,
                        fullPhone: fullPhone),
                    backgroundColor: CustomColors.kBlue,
                    foregroundColor: Colors.white,
                    hoverColor: CustomColors.kDarkGray,
                    isLoading: controller.isLoading,
                  );
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
