import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';

class ProfileProvider extends CommonProvider {
  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getProfile({required int userId}) async {
    final response = await get(UrlStrings.userUrl + '$userId/profile',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (ProfileProvider - getProfile()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Edits profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future<String> editProfile(
      {required int userId, required dynamic body}) async {
    final response = await put(UrlStrings.userUrl + '$userId/profile', body);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (ProfileProvider - editProfile()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CustomStrings.kEditProfileSuccess.tr;
    }
  }
}
