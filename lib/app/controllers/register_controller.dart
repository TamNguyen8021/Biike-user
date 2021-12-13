import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/repos/user/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
      {required BuildContext context,
      required String name,
      required String email,
      required String pass,
      required String phone}) async {
    if (!validate(name, email, pass, phone)) {
      return;
    }

    signup(
        context: context, name: name, email: email, phone: phone, pass: pass);
  }

  Future<void> signup(
      {required BuildContext context,
      required String name,
      required String email,
      required String phone,
      required String pass}) async {
    try {
      _enableLoading(true);
      await _userRepo.signup(name, email, formatPhone(phone), pass);
      Get.offAndToNamed(CommonRoutes.LOGIN);
      AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO_REVERSED,
              headerAnimationLoop: false,
              desc: CustomStrings.kSentVerifiedEmail.tr)
          .show();
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 400) {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                headerAnimationLoop: false,
                desc: CustomErrorsString.kDuplicateEmailOrPhone.tr)
            .show();
      }
      CommonFunctions.catchExceptionError(error);
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
    if (name.trim().isEmpty) {
      return CustomErrorsString.kNotFillAllFields.tr;
    }
    if (email.trim().isEmpty) {
      return CustomErrorsString.kNotFillAllFields.tr;
    }

    if (!(EmailValidator.validate(email)) || !checkMail(email)) {
      return CustomErrorsString.kMustLoginWithFPTEmail.tr;
    }

    if (pass.trim().length < 6) {
      return CustomErrorsString.kPasswordMustAtLeast6.tr;
    }
    if (phone.trim().length < 9 || phone.trim().length > 11) {
      return CustomErrorsString.kInvalidPhoneNo.tr;
    }
    return '';
  }

  String formatPhone(String phone) {
    if (phone.startsWith('0')) {
      return '+84' + phone.substring(1);
    }
    return '+84' + phone;
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
