import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:bikes_user/repos/user/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();
  bool isLoading = false;
  final UserRepository _userRepository = UserRepository();

  Future<void> login(
    String email,
    String pass,
    BuildContext context,
  ) async {
    if (!validate(context: context, email: email, pass: pass)) {
      return;
    }
    _enableLoading(true);

    try {
      final response =
          await _userRepository.signin(email: email, password: pass);

      if (response.data.idToken.isEmpty) {
        throw ('Lỗi server trả token empty');
      }

      // Save user data to local memory
      await Biike.localAppData.saveUserInfo(response.data);
      await Biike.localAppData.loadDataFromLocal();
      getIt<Repositories>().setToken();
      Get.toNamed(CommonRoutes.CHOOSE_MODE);
    } on DioError catch (e) {
      print(e);
      await CommonFunctions()
          .showErrorDialog(context: context, message: e.response?.data ?? '');
    } finally {
      _enableLoading(false);
    }
  }

  bool validate(
      {required BuildContext context,
      required String email,
      required String pass}) {
    if (!(EmailValidator.validate(email)) || !checkMail(email)) {
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

  checkMail(String val) {
    final a = '@Fe.edu.vn';
    final b = '@FPT.EDU.VN';

    if (val.toUpperCase().contains(a.toUpperCase()) ||
        val.toUpperCase().contains(b.toUpperCase())) {
      return true;
    }
    return false;
  }
}
