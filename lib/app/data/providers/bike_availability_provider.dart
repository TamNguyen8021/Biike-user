import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class BikeAvailabilityProvider extends CommonProvider {
  /// Loads Ride Now stations from API
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getRideNowStations(
      {required int page, required int limit}) async {
    final response = await get(
        UrlStrings.bikeAvailability + '?page=$page&limit=$limit',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Call API to add a Ride Now station
  ///
  /// Author: TamNTT
  Future<bool> addRideNowStation({required Map<String, dynamic> body}) async {
    final response =
        await post(UrlStrings.bikeAvailability, body, headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Call API to edit a Ride Now station
  ///
  /// Author: TamNTT
  Future<bool> editRideNowStation(
      {required int id, required Map<String, dynamic> body}) async {
    final response = await put(UrlStrings.bikeAvailability + '/$id', body,
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Call API to delete a Ride Now station
  ///
  /// Author: TamNTT
  Future<bool> deleteRideNowStation({required int id}) async {
    final response = await delete(UrlStrings.bikeAvailability + '/$id',
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
