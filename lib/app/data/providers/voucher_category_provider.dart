import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class VoucherCategoryProvider extends CommonProvider {
  Future<dynamic> getVoucherCategoryList(
      {required int page, required int limit}) async {
    final response = await get(
        UrlStrings.voucherCategoryUrl + '?page=$page&limit=$limit',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }

    logError(response);
    return Future.error(response.statusText!);
  }
}
