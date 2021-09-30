import 'package:bikes_user/pages/login/password.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// '004.3_input_name' screen
class InputNamePage extends StatelessWidget {
  static const String routeName = '/inputName';
  final userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/line-map.png'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    CustomColors.kLightGray.withOpacity(0.5),
                    BlendMode.dstIn))),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(CustomStrings.kInputName,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white)),
                  TextFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp(r'\p{L}+'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 20.0),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  ErrorText(
                      errorText: CustomStrings.kErrorName, marginTop: 50.0)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: NextPageButton(
        //old
        //  onPressedFunc: () => Get.toNamed('/chooseMode'),
        //new
        onPressedFunc: () => Get.toNamed(
          PasswordScreen.routeName,
          arguments: userNameController.text,
        ),
        backgroundColor: Colors.white,
        foregroundColor: CustomColors.kBlue,
        hoverColor: CustomColors.kLightGray,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
