import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/repos/user/user_repository.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  bool isLoading = false;
  final FirebaseServices _firebaseServices = getIt<FirebaseServices>();
  final UserRepository _userRepository = UserRepository();

  Future<void> login(
    String email,
    String pass,
    BuildContext context,
  ) async {
    if (!validate(email, pass)) {
      return;
    }
    _enableLoading(true);

    final messageSignin =
        await _firebaseServices.signinWithEmailAndPassword(email, pass);

    if (messageSignin.isEmpty) {
      if (_firebaseServices.isVerifyEmail) {
        // Save user data to local memory
        Biike.localAppData.saveUserInfo(_firebaseServices);
        Get.toNamed(CommonRoutes.CHOOSE_MODE);
        return;
      }
      _verifyEmail(context);
    } else {
      SnackBarServices.showSnackbar(title: '', message: messageSignin);
    }
    _enableLoading(false);
  }

  void _verifyEmail(BuildContext context) {
    try {
      _firebaseServices.sentVerifyEmail().then((value) {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          body: Center(
            child: Text(
              'Chúng tôi đã gửi 1 email xác thực đến email đăng ký tài khoản của bạn! vui lòng xác thực trước khi đăng nhập',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          btnOkOnPress: () {
            _firebaseServices.reloadUser();
            if (!_firebaseServices.isVerifyEmail) {
              SnackBarServices.showSnackbar(
                  title: '', message: 'chưa xác thực vui lòng thử lại');
            } else {
              _userRepository.verifyUser(_firebaseServices.uid, null, true);
            }
          },
          btnOkText: 'Đã xác thực',
          btnCancelText: CustomStrings.kCancel.tr,
          btnCancelOnPress: () {},
          btnOkColor: Colors.redAccent,
        )..show();
      });
    } catch (e) {
      SnackBarServices.showSnackbar(
          title: '', message: 'da co loi xay ra vui long thu lai sau');
    }
  }

  bool validate(String email, String pass) {
    if (!(EmailValidator.validate(email) &&
        email.toUpperCase().contains('@FPT.EDU.VN'))) {
      SnackBarServices.showSnackbar(
          title: '', message: 'must login with FPT email');
      return false;
    }

    if (pass.replaceAll(' ', '').length < 6) {
      SnackBarServices.showSnackbar(
          title: '', message: 'mat khau phai dat 6 ky tu');
      return false;
    }
    return true;
  }

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }
}
