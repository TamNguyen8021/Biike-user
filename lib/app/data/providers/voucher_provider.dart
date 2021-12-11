import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class VoucherProvider extends CommonProvider {
  Future<dynamic> getVoucherList(
      {required int page,
      required int limit,
      cateId = 0,
      userCoordinate = ''}) async {
    String url = UrlStrings.voucherUrl +
        '?page=$page&limit=$limit&voucherCategoryId=$cateId';
    if (userCoordinate != '') url += '&userCoordinate=$userCoordinate';

    final response = await get(url, headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }

    logError(response);
    return Future.error(response.statusText!);
  }
}
