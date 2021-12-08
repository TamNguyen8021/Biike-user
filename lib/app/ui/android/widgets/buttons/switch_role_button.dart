import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/services/token_service.dart';
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
            CustomDialog customDialog = CustomDialog(context: context);
            customDialog.loadingDialog.show();

            int role = 2;

            if (Biike.role.value == Role.biker) {
              role = 1;
            }

            final hasRoleChanged = await _userProvider.changeRole(role: role);

            if (hasRoleChanged is bool) {
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
              await getIt<TokenService>().refreshToken();
              Biike.localAppData.saveRole(Biike.role.value);
              customDialog.loadingDialog.dismiss();
              Get.offAllNamed(route);
            } else {
              if (hasRoleChanged.contains('have bike')) {
                customDialog.loadingDialog.dismiss();
                Get.toNamed(CommonRoutes.REQUIRE_ADD_BIKE);
              } else if (hasRoleChanged.contains('verified')) {
                customDialog.loadingDialog.dismiss();
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO_REVERSED,
                        headerAnimationLoop: false,
                        desc: CustomStrings.kWaitingAdminVerifiedBike.tr)
                    .show();
              } else {
                customDialog.loadingDialog.dismiss();
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        headerAnimationLoop: false,
                        desc: CustomErrorsString.kDevelopError.tr)
                    .show();
              }
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
