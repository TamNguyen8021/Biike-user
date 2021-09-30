import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class ViewUserProvider extends GetConnect {
  /// Loads partner's profile from API based on [partnerId]
  ///
  /// Author: TamNTT
  Future getPartnerProfile({required int partnerId}) async {
    final response = await get(UrlStrings.userUrl + '$partnerId');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }

  /// Loads history trips with user's partner based on [userId] and [partnerId]
  ///
  /// Author: TamNTT
  Future getHistoryPairTrips(
      {required int userId, required int partnerId}) async {
    final response = await get(UrlStrings.tripUrl +
        'historyPair?userOneId=$userId&userTwoId=$partnerId');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }
}
