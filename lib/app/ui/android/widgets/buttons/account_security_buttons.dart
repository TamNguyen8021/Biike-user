import 'package:bikes_user/app/controllers/app_setting_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSecurityButtons extends StatelessWidget {
  final appSettingController = Get.find<AppSettingController>();

  AccountSecurityButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Row(
                    children: <Widget>[
                      Text(
                        CustomStrings.kChangePassword.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.kLightGray),
                      elevation: MaterialStateProperty.all<double>(2.0)),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: SizedBox(
            //     height: 45,
            //     child: ElevatedButton(
            //       onPressed: () => {},
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Text(
            //             CustomStrings.kLoginByFingerprint.tr,
            //             style: Theme.of(context).textTheme.bodyText2,
            //           ),
            //           Obx(() => Switch(
            //               value: appSettingController.isLoginByFingerprint.value,
            //               onChanged: (bool value) {
            //                 appSettingController.changeLoginByFingerprintState();
            //               }
            //           ))
            //         ],
            //       ),
            //       style: ButtonStyle(
            //           backgroundColor:
            //           MaterialStateProperty.all<Color>(CustomColors.kLightGray),
            //           elevation: MaterialStateProperty.all<double>(2.0)),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
