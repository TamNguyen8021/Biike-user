import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class StationProvider extends CommonProvider {
  /// Loads stations from API.
  ///
  /// Author: TamNTT
  Future<Map<String, dynamic>> getStations(
      {required int page, required int limit}) async {
    final response = await get(
        UrlStrings.stationUrl + '?page=$page&limit=$limit',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  /// Author: UyenNLP
  Future<dynamic> getListRelatedStation(
      {required int page, required int limit, required int departureId}) async {
    final response = await get(
        UrlStrings.stationUrl +
            '/relatedStations?page=$page&limit=$limit&departureId=$departureId',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    logError(response);
    return Future.value(null);
  }
}
