import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [ChooseModePage]
class ChooseModeController extends GetxController {
  Rx<bool> isKeerModeSelected = false.obs;
  Rx<Color> keerBackgroundColor = CustomColors.kLightGray.obs;
  Rx<Color> keerTitleAndIconColor = CustomColors.kBlue.obs;
  Rx<Color> keerTextColor = CustomColors.kDarkGray.obs;

  Rx<bool> isBikerModeSelected = false.obs;
  Rx<Color> bikerBackgroundColor = CustomColors.kLightGray.obs;
  Rx<Color> bikerTitleAndIconColor = CustomColors.kBlue.obs;
  Rx<Color> bikerTextColor = CustomColors.kDarkGray.obs;

  void selectKeerMode({required BuildContext context}) async {
    if (isKeerModeSelected.isFalse) {
      if (isBikerModeSelected.isTrue) {
        Biike.role.value = Role.none;
        isBikerModeSelected.value = false;
        bikerBackgroundColor.value = CustomColors.kLightGray;
        bikerTitleAndIconColor.value = CustomColors.kBlue;
        bikerTextColor.value = CustomColors.kDarkGray;
      }

      isKeerModeSelected.value = true;
      Biike.role.value = Role.keer;
      keerBackgroundColor.value = CustomColors.kOrange;
      keerTitleAndIconColor.value = keerTextColor.value = Colors.white;
    } else {
      isKeerModeSelected.value = false;
      Biike.role.value = Role.none;
      keerBackgroundColor.value = CustomColors.kLightGray;
      keerTitleAndIconColor.value = CustomColors.kBlue;
      keerTextColor.value = CustomColors.kDarkGray;
    }
  }

  void selectBikerMode({required BuildContext context}) async {
    if (isBikerModeSelected.isFalse) {
      if (isKeerModeSelected.isTrue) {
        Biike.role.value = Role.none;
        isKeerModeSelected.value = false;
        keerBackgroundColor.value = CustomColors.kLightGray;
        keerTitleAndIconColor.value = CustomColors.kBlue;
        keerTextColor.value = CustomColors.kDarkGray;
      }

      isBikerModeSelected.value = true;
      Biike.role.value = Role.biker;
      bikerBackgroundColor.value = CustomColors.kOrange;
      bikerTitleAndIconColor.value = bikerTextColor.value = Colors.white;
    } else {
      isBikerModeSelected.value = false;
      Biike.role.value = Role.none;
      bikerBackgroundColor.value = CustomColors.kLightGray;
      bikerTitleAndIconColor.value = CustomColors.kBlue;
      bikerTextColor.value = CustomColors.kDarkGray;
    }
  }
}
