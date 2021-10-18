import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';

class TripHistoryProvider extends CommonProvider {
  /// Loads history trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getHistoryTrips(
      {required int userId, required int page, required int limit}) async {
    final response = await get(
        UrlStrings.tripUrl + '$userId/history?page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripHistoryProvider - getHistoryTrips()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e('TripHistoryProvider - getHistoryTrips()',
          response.statusCode.toString() + ' ' + response.statusText!);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
