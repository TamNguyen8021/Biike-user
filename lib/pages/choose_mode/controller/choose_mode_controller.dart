import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/choose_mode/view/choose_mode_page.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [ChooseModePage]
class ChooseModeController extends GetxController {
  Rx<bool> isCustomerModeSelected = false.obs;
  Rx<Color> customerBackgroundColor = CustomColors.kLightGray.obs;
  Rx<Color> customerTitleAndIconColor = CustomColors.kBlue.obs;
  Rx<Color> customerTextColor = CustomColors.kDarkGray.obs;

  Rx<bool> isDriverModeSelected = false.obs;
  Rx<Color> driverBackgroundColor = CustomColors.kLightGray.obs;
  Rx<Color> driverTitleAndIconColor = CustomColors.kBlue.obs;
  Rx<Color> driverTextColor = CustomColors.kDarkGray.obs;

  void selectCustomerMode() {
    if (isCustomerModeSelected.isFalse) {
      if (isDriverModeSelected.isTrue) {
        Biike.role.value = Role.None;
        isDriverModeSelected.value = false;
        driverBackgroundColor.value = CustomColors.kLightGray;
        driverTitleAndIconColor.value = CustomColors.kBlue;
        driverTextColor.value = CustomColors.kDarkGray;
      }

      isCustomerModeSelected.value = true;
      Biike.role.value = Role.Customer;
      customerBackgroundColor.value = CustomColors.kOrange;
      customerTitleAndIconColor.value = customerTextColor.value = Colors.white;
    } else {
      isCustomerModeSelected.value = false;
      Biike.role.value = Role.None;
      customerBackgroundColor.value = CustomColors.kLightGray;
      customerTitleAndIconColor.value = CustomColors.kBlue;
      customerTextColor.value = CustomColors.kDarkGray;
    }
  }

  void selectDriverMode() {
    if (isDriverModeSelected.isFalse) {
      if (isCustomerModeSelected.isTrue) {
        Biike.role.value = Role.None;
        isCustomerModeSelected.value = false;
        customerBackgroundColor.value = CustomColors.kLightGray;
        customerTitleAndIconColor.value = CustomColors.kBlue;
        customerTextColor.value = CustomColors.kDarkGray;
      }

      isDriverModeSelected.value = true;
      Biike.role.value = Role.Driver;
      driverBackgroundColor.value = CustomColors.kOrange;
      driverTitleAndIconColor.value = driverTextColor.value = Colors.white;
    } else {
      isDriverModeSelected.value = false;
      Biike.role.value = Role.None;
      driverBackgroundColor.value = CustomColors.kLightGray;
      driverTitleAndIconColor.value = CustomColors.kBlue;
      driverTextColor.value = CustomColors.kDarkGray;
    }
  }
}
