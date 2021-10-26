import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

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
}
