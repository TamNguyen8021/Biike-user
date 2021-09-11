import 'package:bikes_user/main.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchRoleButton extends StatelessWidget {
  final String route;

  SwitchRoleButton({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<String> _modeButtonText = CustomStrings.kCustomerMode.obs;
    Rx<Color> _modeButtonForegroundColor = CustomColors.kBlue.obs;
    if (Biike.role.value == Role.Driver) {
      _modeButtonText.value = CustomStrings.kDriverMode;
      _modeButtonForegroundColor.value = CustomColors.kOrange;
    }

    return SizedBox(
      height: 20,
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            if (Biike.role.value == Role.Customer) {
              Biike.role.value = Role.Driver;
              _modeButtonText.value = CustomStrings.kDriverMode;
              _modeButtonForegroundColor.value = Colors.white;
            } else {
              Biike.role.value = Role.Customer;
              _modeButtonText.value = CustomStrings.kCustomerMode;
              _modeButtonForegroundColor.value = CustomColors.kBlue;
            }
            if (ModalRoute.of(context)!.settings.name.toString() !=
                '/profile') {
              Get.offAllNamed(route);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              _modeButtonText.value,
              style: TextStyle(
                  color: _modeButtonForegroundColor.value, fontSize: 10),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
