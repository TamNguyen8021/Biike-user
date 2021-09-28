import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  /// Loads upcoming trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getUpcomingTrips(
      {required int userId, required int role}) async {
    final response =
        await get(UrlStrings.tripUrl + '$userId/upcoming?role=$role');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }
}
