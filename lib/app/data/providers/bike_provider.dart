import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class BikeProvider extends CommonProvider {
  Future<dynamic> getBike() async {
    final response = await get(
        UrlStrings.bikeUrl + 'users/${Biike.userId.value}',
        headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      if (response.statusCode == 404) {
        return null;
      }
    } else {
      return response.body['data'];
    }
  }

  Future<bool> addBike({required Map<String, dynamic> body}) async {
    final response =
        await post(UrlStrings.bikeUrl, body, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeBike() async {
    final response = await delete(UrlStrings.bikeUrl + '${Biike.userId.value}',
        headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Edit bike's info
  ///
  /// Author: TamNTT
  Future<bool> replaceBike({required Map<String, dynamic> body}) async {
    final response = await post(UrlStrings.bikeUrl + 'bikeReplacement', body,
        headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
