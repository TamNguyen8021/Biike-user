import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/models/bike.dart';
import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states for [ManageBikePage]
class ManageBikeController extends GetxController {
  final _bikeProvider = Get.find<BikeProvider>();

  Rx<bool> hasBike = false.obs;
  Bike bike = Bike.empty();

  Future<void> getBike() async {
    dynamic response = await _bikeProvider.getBike();
    if (response != null) {
      bike = Bike.fromJson(response);
      hasBike.value = true;
      update();
    }
  }

  Future<void> removeBike({required BuildContext context}) async {
    bool result = await _bikeProvider.removeBike();
    if (result) {
      hasBike.value = false;
      Biike.role.value = Role.keer;
      Get.offAllNamed(CommonRoutes.HOME);
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }
}
