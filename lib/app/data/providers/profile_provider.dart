import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getProfile({required int userId}) async {
    final response = await get(UrlStrings.userUrl + '$userId/profile');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }

  /// Edits profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future<String> editProfile(
      {required int userId, required dynamic body}) async {
    print(body);
    final response = await put(UrlStrings.userUrl + '$userId/profile', body);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CustomStrings.kEditProfileSuccess.tr;
    }
  }
}
