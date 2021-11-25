import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  bool isLoading = false;
  final FirebaseServices _firebaseServices = getIt<FirebaseServices>();
  // final UserRepository _userRepository = UserRepository();

  Future<void> login(
    String email,
    String pass,
    BuildContext context,
  ) async {
    if (!validate(context: context, email: email, pass: pass)) {
      return;
    }
    _enableLoading(true);

    final messageSignin =
        await _firebaseServices.signinWithEmailAndPassword(email, pass);

    if (messageSignin.isEmpty) {
      if (_firebaseServices.isVerifyEmail) {
        // Save user data to local memory
        await Biike.localAppData.saveUserInfo(_firebaseServices);
        await Biike.localAppData.loadDataFromLocal();
        Get.toNamed(CommonRoutes.CHOOSE_MODE);
        return;
      }
      _verifyEmail(context);
    } else {
      await CommonFunctions()
          .showErrorDialog(context: context, message: messageSignin);
    }
    _enableLoading(false);
  }

  void _verifyEmail(BuildContext context) {
    try {
      _firebaseServices.sentVerifyEmail(context: context).then((value) {
        CommonFunctions().showInfoDialog(
            context: context, message: CustomStrings.kSentVerifiedEmail.tr);
        // AwesomeDialog(
        //   context: context,
        //   animType: AnimType.SCALE,
        //   dialogType: DialogType.ERROR,
        //   dismissOnTouchOutside: false,
        //   dismissOnBackKeyPress: false,
        //   body: Center(
        //     child: Text(
        //       'Chúng tôi đã gửi 1 email xác thực đến email đăng ký tài khoản của bạn! vui lòng xác thực trước khi đăng nhập',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 15,
        //       ),
        //     ),
        //   ),
        //   btnOkOnPress: () {
        //     _firebaseServices.reloadUser();
        //     if (!_firebaseServices.isVerifyEmail) {
        //       SnackBarServices.showSnackbar(
        //           title: '', message: 'chưa xác thực vui lòng thử lại');
        //     } else {
        //       _userRepository.verifyUser(_firebaseServices.uid, null, true);
        //     }
        //   },
        //   btnOkText: 'Đã xác thực',
        //   btnCancelText: CustomStrings.kCancel.tr,
        //   btnCancelOnPress: () {},
        //   btnOkColor: Colors.redAccent,
        // )..show();
      });
    } catch (error) {
      CommonFunctions.catchExceptionError(error);

      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }

  bool validate(
      {required BuildContext context,
      required String email,
      required String pass}) {
    if (!(EmailValidator.validate(email) &&
        email.toUpperCase().contains('@FPT.EDU.VN'))) {
      CommonFunctions().showErrorDialog(
          context: context,
          message: CustomErrorsString.kMustLoginWithFPTEmail.tr);
      return false;
    }

    if (pass.trim().length < 1) {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kNoPasswordEnter.tr);
      return false;
    }
    return true;
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }
}
