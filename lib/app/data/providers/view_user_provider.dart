import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:flutter_logs/flutter_logs.dart';

class ViewUserProvider extends CommonProvider {
  /// Loads partner's profile from API based on [partnerId]
  ///
  /// Author: TamNTT
  Future getPartnerProfile({required int partnerId}) async {
    final response =
        await get(UrlStrings.userUrl + '$partnerId', headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (ViewUserProvider - getPartnerProfile()): ' +
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

  /// Loads history trips with user's partner based on [userId] and [partnerId]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getHistoryPairTrips(
      {required int userId,
      required int partnerId,
      required int page,
      required int limit}) async {
    final response = await get(
        UrlStrings.tripUrl +
            'historyPair?userOneId=$userId&userTwoId=$partnerId&page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (ViewUserProvider - getHistoryPairTrips()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
