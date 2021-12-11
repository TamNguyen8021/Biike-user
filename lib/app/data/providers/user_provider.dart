import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class UserProvider extends CommonProvider {
  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getProfile({required int userId}) async {
    final response = await get(UrlStrings.userUrl + '$userId/profile',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Change user's role.
  ///
  /// Author: TamNTT
  Future<dynamic> changeRole({required int role}) async {
    final response = await put(
        UrlStrings.userUrl + 'role?startupRole=$role', {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return response.bodyString;
    } else {
      return true;
    }
  }

  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getRideNowStatus() async {
    final response = await get(
        UrlStrings.userUrl + '${Biike.userId.value}/tripNowAvailability',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Change Ride Now status
  ///
  /// Author: TamNTT
  Future<bool> changeRideNowStatus() async {
    final response = await put(UrlStrings.userUrl + 'tripNowAvailability', {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Loads user's achievement from API
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getUserAchievement() async {
    final response = await get(
        UrlStrings.userUrl + '${Biike.userId.value}/achievement',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Update user's phone number verification to true
  ///
  /// Author: TamNTT
  Future<bool> modifyVerification() async {
    final response = await put(
        UrlStrings.userUrl + '${Biike.userId.value}/activation',
        {'isPhoneVerified': true},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
