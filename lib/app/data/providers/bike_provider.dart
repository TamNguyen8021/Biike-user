import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class BikeProvider extends CommonProvider {
  Future<dynamic> getBike(userId) async {
    final response =
        await get(UrlStrings.bikeUrl + 'users/$userId', headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }
    logError(response);
    return Future.error(response.statusText!);
  }

  Future<bool> addBike(data) async {
    final response =
        await post(UrlStrings.bikeUrl, data, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
    }

    return response.statusCode == HttpStatus.ok
        ? Future.value(true)
        : Future.value(false);
  }

  Future<bool> removeBike(userId) async {
    final response =
        await delete(UrlStrings.bikeUrl + '$userId', headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
    }

    return response.statusCode == HttpStatus.ok
        ? Future.value(true)
        : Future.value(false);
  }
}
