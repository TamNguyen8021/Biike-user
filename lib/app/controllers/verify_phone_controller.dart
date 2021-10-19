import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  static VerifyPhoneController get to => Get.find<VerifyPhoneController>();
  bool isLoading = false;
  final _phoneAuthServices = getIt<FirebaseServices>();

  Future<void> verifyOtp(String otp, String fullPhone) async {
    if (!_validate(otp)) {
      return;
    }
    _enableLoading(true);
    final result = await _phoneAuthServices.verifyOtp(otp);
    if (result) {
      Get.toNamed(CommonRoutes.REGISTER, arguments: {'fullPhone': fullPhone});
    } else {
      SnackBarServices.showSnackbar(title: '', message: 'sai otp');
    }
    _enableLoading(false);
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  bool _validate(String otp) {
    if (otp.replaceAll(' ', "").isEmpty) {
      SnackBarServices.showSnackbar(
          title: '', message: 'vui long nhap ma xac minh');
      return false;
    }
    if (otp.replaceAll(' ', "").length != 6) {
      SnackBarServices.showSnackbar(
          title: '', message: 'vui long nhap dung 6 so OPT');
      return false;
    }
    return true;
  }
}
