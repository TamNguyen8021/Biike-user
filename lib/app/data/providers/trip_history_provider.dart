import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class TripHistoryProvider extends GetConnect {
  /// Loads history trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getHistoryTrips({required int userId, required int role}) async {
    final response =
        await get(UrlStrings.tripUrl + '$userId/history?role=$role');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body['data'];
    }
  }
}
