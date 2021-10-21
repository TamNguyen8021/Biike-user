import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class TripProvider extends CommonProvider {
  /// Loads upcoming trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getUpcomingTrips(
      {required int userId, required int page, required int limit}) async {
    final response = await get(
        UrlStrings.tripUrl + 'upcoming/users/$userId?page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripProvider - getUpcomingTrips()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - getUpcomingTrips()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Loads history trips from API based on [userId] and [role]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getHistoryTrips(
      {required int userId, required int page, required int limit}) async {
    final response = await get(
        UrlStrings.tripUrl + 'history/users/$userId?page=$page&limit=$limit',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripProvider - getHistoryTrips()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - getHistoryTrips()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body;
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
        logMessage: '\n\nBiike (TripProvider - getHistoryPairTrips()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - getHistoryPairTrips()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Loads trip details from API based on [tripId]
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getTripDetails({required int tripId}) async {
    final response = await get(UrlStrings.tripUrl + '$tripId/details',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripProvider - getTripDetails()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - getTripDetails()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
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
        logMessage: '\n\nBiike (TripProvider - getLocationDetails()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - getLocationDetails()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
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
        logMessage: '\n\nBiike (TripProvider - cancelTrip()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);
    if (response.status.hasError) {
      Biike.logger.e(
          'TripProvider - cancelTrip()',
          response.statusCode.toString() +
              ' ' +
              response.statusText! +
              '\n' +
              response.body);
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> createKeNowTrip(Map<String, dynamic> data) async {
    final response = await post(UrlStrings.tripUrl, data,
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (TripProvider - createKeNowTrip()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    return response.statusCode == HttpStatus.created
        ? Future.value(true)
        : Future.value(response.bodyString ?? '');
  }
}
