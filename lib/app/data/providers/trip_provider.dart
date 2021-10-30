import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
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

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['address'];
    }
  }

  Future getRouteData(
      String startLng, String startLat, String endLng, String endLat) async {
    final response = await get(
        'https://api.openrouteservice.org/v2/directions/cycling-road?api_key=5b3ce3597851110001cf6248de4262d7d04449e6a17f0d0473072352&start=$startLng,$startLat&end=$endLng,$endLat');

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return jsonDecode(response.body);
    }
  }

  /// Cancel a trip based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> cancelTrip({required int tripId, required dynamic body}) async {
    final response = await put(
        UrlStrings.tripUrl +
            '$tripId/cancel?userId=${Biike.userId.value.toString()}',
        body,
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Create a ke-now trip
  ///
  /// Author: UyenNLP
  Future<dynamic> createKeNowTrip(Map<String, dynamic> data) async {
    final response =
        await post(UrlStrings.tripUrl, data, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
    }

    if (response.statusCode == HttpStatus.created) {
      return true;
    }

    logError(response);
    return response.bodyString ?? '';
  }

  /// Create a scheduled trip
  ///
  /// Author: UyenNLP
  Future<dynamic> createScheduledTrip(Map<String, dynamic> data) async {
    final response = await post(UrlStrings.tripUrl + 'schedule', data,
        headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
    }

    if (response.statusCode == HttpStatus.created) {
      return true;
    }

    logError(response);
    return response.bodyString ?? '';
  }
}
