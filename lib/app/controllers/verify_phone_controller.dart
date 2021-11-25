import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  static VerifyPhoneController get to => Get.find<VerifyPhoneController>();
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
      Get.toNamed(CommonRoutes.REGISTER, arguments: {'fullPhone': fullPhone});
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kWrongOtp.tr);
    }
    _enableLoading(false);
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  bool _validate({required BuildContext context, required String otp}) {
    if (otp.trim().isEmpty) {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kEmptyOtp.tr);
      return false;
    }
    if (otp.trim().length != 6) {
      return false;
    }
    return true;
  }
}
