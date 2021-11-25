import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/previous_page_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// The '001.1_open' screen
class PasswordPage extends StatelessWidget {
  static const String routeName = '/passwordScreen';

  const PasswordPage({Key? key, required this.nameUser}) : super(key: key);

  final String nameUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: _BackgroundPassword(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo-white.png'),
                  width: 204,
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    CustomStrings.kIntroduction,
                    style: TextStyle(
                        color: CustomColors.kLightGray.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
            Text('Xin chao $nameUser',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            Text('Hãy nhập mật khẩu của bạn',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              width: 400,
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                // obscureText: true,
                // obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 6) {
                    return 'I\'m from validator';
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.blue.shade900,
                  activeFillColor: Colors.white,
                  fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 5),
                ),
                mainAxisAlignment: MainAxisAlignment.center,
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  Biike.logger.d('Completed');
                },
                onChanged: (value) {
                  Biike.logger.d(value);
                },
                beforeTextPaste: (text) {
                  Biike.logger.d('Allowing to paste $text');
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            SizedBox(
              width: 400,
              child: Row(
                children: [
                  Expanded(child: Text('Quên mật khẩu?')),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    'Không phải tôi',
                    textAlign: TextAlign.right,
                  )),
                ],
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
            NextPageButton(
              onPressedFunc: () => Get.offAllNamed('/chooseMode'),
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

class _BackgroundPassword extends StatelessWidget {
  final Widget child;
  const _BackgroundPassword({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Image(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 0.6,
            image: AssetImage('assets/images/line-map.png'),
            fit: BoxFit.fitWidth,
            color: CustomColors.kLightGray.withOpacity(0.5),
          ),
        ),
        child
      ],
    );
  }
}
