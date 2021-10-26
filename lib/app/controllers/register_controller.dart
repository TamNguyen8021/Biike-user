import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/repos/user/user_repository.dart';
import 'package:bikes_user/app/common/functions/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find<RegisterController>();

  bool isLoading = false;
  String errorMessage = '';
  final _userRepo = UserRepository();

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<void> next(
      String name, String email, String pass, String phone) async {
    if (!validate(name, email, pass, phone)) {
      return;
    }

    signup(name, email, phone, pass);
  }

  Future<void> signup(
      String name, String email, String phone, String pass) async {
    try {
      _enableLoading(true);
      await _userRepo.signup(name, email, formatPhone(phone), pass);
      Get.toNamed(CommonRoutes.LOGIN);
      SnackBarServices.showSnackbar(
          title: '', message: 'Đăng ký thành công vui lòng đăng nhập');
    } catch (error) {
      Biike.logger.e('RegisterController - signup()', error);
      if (error is DioError && error.response?.statusCode == 400) {
        SnackBarServices.showSnackbar(
            title: 'Bikke',
            message: 'Số điiện thoại hoặc mail đã có người đăng ký');
      }
      FlutterLogs.logErrorTrace(
          'Biike', 'RegisterController - signup()', error.toString(), Error());
    } finally {
      _enableLoading(false);
    }
  }

  bool validate(String name, String email, String pass, String phone) {
    String error = _validate(name, email, pass, phone);
    if (error.isNotEmpty) {
      errorMessage = error;
      update();
      return false;
    } else {
      errorMessage = '';
      update();
      return true;
    }
  }

  String _validate(String name, String email, String pass, String phone) {
    if (name.replaceAll(" ", "").isEmpty) {
      return 'not null';
    }
    if (email.replaceAll(" ", "").isEmpty) {
      return 'email must not be null';
    }

    if (!(EmailValidator.validate(email) &&
        email.toUpperCase().contains('@FPT.EDU.VN'))) {
      return 'must login with FPT email';
    }

    if (pass.replaceAll(" ", "").length < 6) {
      return 'mat khau phia dat 6 ky tu';
    }
    if (phone.replaceAll(" ", "").length < 9 ||
        phone.replaceAll(" ", "").length > 11) {
      return 'vui long nhap so dien thoai đúng';
    }
    return '';
  }

  String formatPhone(String phone) {
    if (phone.startsWith('0')) {
      return '+84' + phone.substring(1);
    }
    return '+84' + phone;
  }
}
