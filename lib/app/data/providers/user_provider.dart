import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';

class UserProvider extends CommonProvider {
  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getProfile({required int userId}) async {
    final response = await get(UrlStrings.userUrl + '$userId/profile',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (UserProvider - getProfile()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'UserProvider - getProfile()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Edits profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future<bool> editProfile({required int userId, required dynamic body}) async {
    final response = await put(UrlStrings.userUrl + '$userId/profile', body,
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (UserProvider - editProfile()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'UserProvider - editProfile()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return false;
    } else {
      return true;
    }
  }

  /// Loads partner's profile from API based on [partnerId]
  ///
  /// Author: TamNTT
  Future getPartnerProfile({required int partnerId}) async {
    final response =
        await get(UrlStrings.userUrl + '$partnerId', headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (UserProvider - getPartnerProfile()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'UserProvider - getPartnerProfile()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }
}
