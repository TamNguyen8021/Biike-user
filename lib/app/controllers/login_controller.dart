import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:bikes_user/repos/user/user_repository.dart';
import 'package:bikes_user/services/firebase_cloud_message_service.dart';
import 'package:bikes_user/services/shared_preference_service.dart';
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
      final _fcmToken = await getIt<FirebaseCloudMessagingService>().token;
      final response = await _userRepository.signin(
        email: email,
        password: pass,
        fcmToken: _fcmToken,
      );

      if (response.data.idToken.isEmpty) {
        throw (CustomStrings.kEmptyToken);
      }

      // Set token, refresh token
      getIt<AppPref>()
        ..setToken(response.data.idToken)
        ..setRefreshToken(response.data.refreshToken);
      getIt<Repositories>().setHeaders();
      // *
      await Biike.localAppData.saveUserInfo(response.data);
      await Biike.localAppData.loadDataFromLocal();
      getIt<Repositories>().setHeaders();
      Get.toNamed(CommonRoutes.CHOOSE_MODE);
    } on DioError catch (e) {
      var _errorMessage = CustomStrings.kLoginExceptionError;
      final _errorResult = e.response?.data;

      if (_errorResult is String) {
        if (_errorResult.contains('EMAIL_NOT_FOUND')) {
          _errorMessage = CustomStrings.kNoAccount;
        }
        if (_errorResult.contains('INVALID_PASSWORD')) {
          _errorMessage = CustomStrings.kWrongAccount;
        }
        if (_errorResult.contains('verified') &&
            _errorResult.contains('email')) {
          _errorMessage = CustomErrorsString.kUnVerifiedEmail.tr;
        }
      }

      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: _errorMessage)
          .show();
    } catch (e) {
      CommonFunctions.catchExceptionError(e);
    } finally {
      _enableLoading(false);
    }
  }

  bool validate(
      {required BuildContext context,
      required String email,
      required String pass}) {
    if (!(EmailValidator.validate(email)) || !checkMail(email)) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kMustLoginWithFPTEmail.tr)
          .show();
      return false;
    }

    if (pass.trim().length < 1) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kNoPasswordEnter.tr)
          .show();
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
