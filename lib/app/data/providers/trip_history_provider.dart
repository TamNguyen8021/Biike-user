import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class TripHistoryProvider extends CommonProvider {
  /// Loads history trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<List> getHistoryTrips({required int userId}) async {
    final response = await get(
        UrlStrings.tripUrl + '$userId/history?page=1&limit=10',
        headers: await getHeaders());
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body['data'];
    }
  }
}
