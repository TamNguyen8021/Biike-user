import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';

class StationProvider extends CommonProvider {
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
        logMessage: '\n\nBiike (StationProvider - getStations()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);
    if (response.status.hasError) {
      Biike.logger.e(
          'StationProvider - getStations()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
