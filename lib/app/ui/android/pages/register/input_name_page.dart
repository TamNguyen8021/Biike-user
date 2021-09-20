import 'package:bikes_user/app/controllers/input_name_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// '004.3_input_name' screen
class InputNamePage extends StatelessWidget {
  final inputNameController = Get.find<InputNameController>();

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
                  Text(CustomStrings.kInputName.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white)),
                  Obx(
                    () => TextFormField(
                      initialValue: '${inputNameController.fullname}',
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
                  ),
                  ErrorText(
                      errorText: CustomStrings.kErrorName.tr, marginTop: 50.0)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: NextPageButton(
        onPressedFunc: () => Get.toNamed(CommonRoutes.CHOOSE_MODE),
        backgroundColor: Colors.white,
        foregroundColor: CustomColors.kBlue,
        hoverColor: CustomColors.kLightGray,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
