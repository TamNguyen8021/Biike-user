import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  /// Get duration and distance for two locations
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getDurationAndDistance(
      {required double startLat,
      required double startLng,
      required double endLat,
      required double endLng}) async {
    String language = 'vi-VN';
    if (Get.locale == Locale('en', 'US')) {
      language = 'en_US';
    }

    final response = await get(UrlStrings.distancematrixUrl +
        '?language=$language&origins=$startLat,$startLng&destinations=$endLat,$endLng&key=${UrlStrings.googleMapApiKey}');

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Get location details from API.
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getLocationDetails(
      {required String placeId}) async {
    // final response = await get(
    //     'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longtitude');
    final response = await get(UrlStrings.placeDetailsUrl +
        '?fields=formatted_address,name,geometry,photo&place_id=$placeId&key=${UrlStrings.googleMapApiKey}');

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body;
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

  /// Search upcoming trips for biker
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> searchTrips(
      {required int page,
      required int limit,
      DateTime? date,
      TimeOfDay? time,
      int? departureId,
      int? destinationId}) async {
    String _dateString = '';
    String _timeString = '';

    if (date != null) {
      _dateString = date.toIso8601String();
    }

    if (time != null) {
      _timeString = time.hour.toString() + ':' + time.minute.toString();
    }

    final response = await get(
        UrlStrings.tripUrl +
            'newlyCreatedTrip?page=$page&limit=$limit&date=$_dateString&time=$_timeString&departureId=$departureId&destinationId=$destinationId',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Accept a trip based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> acceptTrip({required int tripId}) async {
    final response = await put(
        UrlStrings.tripUrl + '$tripId?bikerId=${Biike.userId.value.toString()}',
        {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Change trip status to waiting based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> markArrivedAtPickUpPoint({required int tripId}) async {
    final response = await put(UrlStrings.tripUrl + '$tripId/waitingTime', {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Mark a trip as started based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> startTrip({required int tripId}) async {
    final response = await put(UrlStrings.tripUrl + '$tripId/startTime', {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Mark a trip as completed based on [tripId].
  ///
  /// Author: TamNTT
  Future<bool> completeTrip({required int tripId}) async {
    final response = await put(UrlStrings.tripUrl + '$tripId/finishTime', {},
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
