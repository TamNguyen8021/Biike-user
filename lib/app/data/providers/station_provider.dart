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

  Future<dynamic> getListRelatedStation({required int departureId}) async {
    final response = await get(
        UrlStrings.stationUrl + '/relatedStations?page=1&limit=10&departureId=$departureId',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }

    return Future.value(null);
  }
}
