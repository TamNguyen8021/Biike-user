import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class BikeProvider extends CommonProvider {
  Future<dynamic> getBike(userId) async {
    final response =
        await get(UrlStrings.bikeUrl + 'users/$userId', headers: await headers);

    if (response.statusCode == 200) {
      return response.body['data'];
    }

    return Future.error(response.statusText!);
  }

  Future<bool> addBike(data) async {
    final response =
        await post(UrlStrings.bikeUrl, data, headers: await headers);

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }

  Future<bool> removeBike(userId) async {
    final response =
        await delete(UrlStrings.bikeUrl + '$userId', headers: await headers);

    print(UrlStrings.bikeUrl + '$userId');
    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }
}
