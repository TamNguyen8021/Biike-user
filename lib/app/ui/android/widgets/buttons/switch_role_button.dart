import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchRoleButton extends StatelessWidget {
  final _userProvider = Get.find<UserProvider>();
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
          onPressed: () async {
            final hasRoleChanged = await _userProvider.changeRole();
            if (hasRoleChanged) {
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
              Biike.localAppData.saveRole(Biike.role.value);
              Get.offAllNamed(route);
            } else {
              CommonFunctions().showErrorDialog(
                  context: context,
                  message: CustomErrorsString.kDevelopError.tr);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              Biike.role.value == Role.keer
                  ? CustomStrings.kKeerMode.tr
                  : CustomStrings.kBikerMode.tr,
              style: TextStyle(
                  color: _modeButtonForegroundColor.value, fontSize: 10.sp),
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
