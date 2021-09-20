import 'package:bikes_user/app/controllers/input_phone_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/next_page_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// The '004.1_input_phone_no' screen
class InputPhonePage extends StatelessWidget {
  final inputPhoneController = Get.find<InputPhoneController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 22.0, right: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  CustomStrings.kInputPhoneNumber.tr,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Obx(
                    () => IntlPhoneField(
                      keyboardType: TextInputType.phone,
                      initialCountryCode: 'VN',
                      initialValue: '${inputPhoneController.phoneNo}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 20.0),
                        counterText: "",
                      ),
                      dropdownDecoration: BoxDecoration(
                          color: CustomColors.kLightBlue,
                          borderRadius: BorderRadius.circular(20)),
                      showDropdownIcon: false,
                      inputFormatters: [MaskedInputFormatter('00 000 0000')],
                      onChanged: (phoneNo) =>
                          inputPhoneController.inputPhoneNo(phoneNo),
                    ),
                  ),
                ),
                ErrorText(
                    errorText: CustomStrings.kErrorInputPhoneNumber.tr,
                    marginTop: 50.0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: NextPageButton(
        onPressedFunc: () => Get.toNamed(CommonRoutes.VERIFY_PHONE),
        backgroundColor: CustomColors.kBlue,
        foregroundColor: Colors.white,
        hoverColor: CustomColors.kDarkGray,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
