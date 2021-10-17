import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:flutter_logs/flutter_logs.dart';

class HomeProvider extends CommonProvider {
  /// Loads upcoming trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getUpcomingTrips(
      {required int userId, required int page, required int limit}) async {
    final response = await get(
        UrlStrings.tripUrl + '$userId/upcoming?page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (HomeProvider - getUpcomingTrips()): ' +
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

  /// Loads stations from API.
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getStations(
      {required int page, required int limit}) async {
    final response = await get(
        UrlStrings.stationUrl + '?page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (HomeProvider - getStations()): ' +
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
