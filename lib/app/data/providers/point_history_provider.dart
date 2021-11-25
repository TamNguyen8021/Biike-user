import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class PointHistoryProvider extends CommonProvider {
  Future<dynamic> getUserPointHistory(
      {required userId, required page, required limit}) async {
    final response = await get(
        UrlStrings.pointUrl + '/$userId?page=$page&limit=$limit',
        headers: await headers);
    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }

    logError(response);
    return Future.error(response.statusText!);
  }
}
