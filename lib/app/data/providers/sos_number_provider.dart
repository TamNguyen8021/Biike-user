import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class SOSNumberProvider extends CommonProvider {
  Future<dynamic> getSOSNumbers() async {
    final response = await get(
        UrlStrings.sos + '/users/${Biike.userId.value}?page=1&limit=100',
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

  Future<bool> addSOSNumber({required Map<String, dynamic> body}) async {
    final response = await post(UrlStrings.sos, body, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> editSOSNumber(
      {required Map<String, dynamic> body, required int id}) async {
    final response =
        await put(UrlStrings.sos + '/$id', body, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> removeSOSNumber({required int id}) async {
    final response =
        await delete(UrlStrings.sos + '/$id', headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
