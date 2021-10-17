import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';

class TripDetailsProvider extends CommonProvider {
  /// Loads trip details from API based on [tripId]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getTripDetails({required int tripId}) async {
    final response = await get(UrlStrings.tripUrl + '$tripId/details',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripDetailsProvider - getTripDetails()): ' +
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

  /// Loads location data from API based on [latitude] and [longtitude].
  ///
  /// Author: TamNTT
  Future<Map<String, String>> getLocationDetails(
      {required double latitude, required double longtitude}) async {
    final response = await get(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longtitude');

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripDetailsProvider - getLocationDetails()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body['address'];
    }
  }

  /// Cancel a trip based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> cancelTrip({required int tripId, required dynamic body}) async {
    final response = await put(
        UrlStrings.tripUrl +
            '$tripId/cancel?userId=' +
            Biike.userId.value.toString(),
        body,
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripDetailsProvider - cancelTrip()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);
    if (response.status.hasError) {
      return false;
    } else {
      return true;
    }
  }
}
