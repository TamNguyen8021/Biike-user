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
  static const String routeName = '/verifyPhoneScreen';
  final String fullPhone;

  VerifyPhonePage({Key? key, required this.fullPhone}) : super(key: key);

  static VerifyPhonePage initial(String fullPhone) {
    return VerifyPhonePage(
      fullPhone: fullPhone,
    );
  }

  final controllerOtp = TextEditingController();
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
              style: Theme.of(context).textTheme.bodyText1!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              fullPhone,
              style: Theme.of(context).textTheme.bodyText1!,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 5.0, top: 10.0),
              child: PinCodeTextField(
                appContext: context,
                controller: controllerOtp,
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
                  activeColor: CustomColors.kLightGray,
                  inactiveColor: CustomColors.kLightGray,
                ),
                onChanged: (code) {},
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
            GetBuilder<VerifyPhoneController>(builder: (controller) {
              return NextPageButton(
                onPressedFunc: () => VerifyPhoneController.to
                    .verifyOtp(controllerOtp.text, fullPhone),
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
