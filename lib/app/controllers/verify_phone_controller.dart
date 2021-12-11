import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/home_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  static VerifyPhoneController get to => Get.find<VerifyPhoneController>();
  final _profileController = Get.find<ProfileController>();
  final _homeController = Get.find<HomeController>();
  final _userProvider = Get.find<UserProvider>();
  bool isLoading = false;
  final _phoneAuthServices = getIt<FirebaseServices>();

  Future<void> verifyOtp(
      {required BuildContext context,
      required String otp,
      required String fullPhone}) async {
    if (!_validate(context: context, otp: otp)) {
      return;
    }
    _enableLoading(true);
    final result = await _phoneAuthServices.verifyOtp(otp);
    if (result) {
      bool isSuccess =
          await _userProvider.modifyVerification().catchError((error) {
        _enableLoading(false);
        CommonFunctions.catchExceptionError(error);
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kDevelopError.tr)
            .show();
      });

      if (isSuccess) {
        await _profileController.getProfile();
        if (Get.arguments['from'] == 'accountVerification') {
          Get.back();
          Get.back();
          Get.toNamed(CommonRoutes.ACCOUNT_VERIFICATION);
        } else {
          _homeController.upcomingTrips.clear();
          _homeController.pagingController.itemList!.clear();
          _homeController.pagingController.notifyPageRequestListeners(0);
          if (Biike.role.value == Role.biker) {
            await _homeController.searchTrips(
                date: _homeController.searchDate.value,
                time: _homeController.searchTime.value,
                departureId: _homeController.departureStation.value.stationId,
                destinationId:
                    _homeController.destinationStation.value.stationId);
          }
          Get.back();
        }
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kDevelopError.tr)
            .show();
      }
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomStrings.kInvalidPin.tr)
          .show();
    }
    _enableLoading(false);
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  bool _validate({required BuildContext context, required String otp}) {
    if (otp.trim().isEmpty) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kEmptyOtp.tr)
          .show();
      return false;
    }
    if (otp.trim().length != 6) {
      return false;
    }
    return true;
  }
}
