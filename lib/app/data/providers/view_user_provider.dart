import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class ViewUserProvider extends GetConnect {
  /// Loads other user's profile from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future getUser({required int userId}) async {
    final response = await get(UrlStrings.userUrl + '$userId');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }
}
