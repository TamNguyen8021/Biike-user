import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchRoleButton extends StatelessWidget {
  final String role;
  final String route;

  SwitchRoleButton({Key? key, required this.role, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _modeButtonText = CustomStrings.kCustomerMode;
    Color _modeButtonForegroundColor = CustomColors.kBlue;
    Color _modeButtonBackgroundColor = CustomColors.kLightGray;
    if (role != 'Customer') {
      _modeButtonText = CustomStrings.kDriverMode;
      _modeButtonBackgroundColor = CustomColors.kOrange;
      _modeButtonForegroundColor = CustomColors.kLightGray;
    }

    return SizedBox(
      height: 20,
      child: ElevatedButton(
        onPressed: () {
          Get.offAllNamed(route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Text(
            _modeButtonText,
            style: TextStyle(color: _modeButtonForegroundColor, fontSize: 10),
          ),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(_modeButtonBackgroundColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
      ),
    );
  }
}
