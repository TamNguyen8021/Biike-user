import 'package:bikes_user/main.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchRoleButton extends StatelessWidget {
  final String route;
  final bool isOnProfilePage;

  SwitchRoleButton({
    Key? key,
    required this.route,
    required this.isOnProfilePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<Color> _modeButtonForegroundColor = CustomColors.kBlue.obs;
    Rx<Color> _modeButtonBackgroundColor = Colors.white.obs;
    if (isOnProfilePage) {
      _modeButtonForegroundColor.value = Colors.white;
      _modeButtonBackgroundColor.value = CustomColors.kOrange;
    } else {
      if (Biike.role.value == Role.biker) {
        _modeButtonForegroundColor.value = CustomColors.kOrange;
        _modeButtonBackgroundColor.value = Colors.white;
      }
    }

    return SizedBox(
      height: 20,
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            if (Biike.role.value == Role.keer) {
              Biike.role.value = Role.biker;
              if (!isOnProfilePage) {
                _modeButtonForegroundColor.value = CustomColors.kOrange;
              }
            } else if (Biike.role.value == Role.biker) {
              Biike.role.value = Role.keer;
              if (!isOnProfilePage) {
                _modeButtonForegroundColor.value = CustomColors.kBlue;
              }
            }
            Get.offAllNamed(route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              Biike.role.value == Role.keer
                  ? CustomStrings.kKeerMode
                  : CustomStrings.kBikerMode,
              style: TextStyle(
                  color: _modeButtonForegroundColor.value, fontSize: 10),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: _modeButtonBackgroundColor.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
