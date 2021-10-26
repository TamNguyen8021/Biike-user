import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class VoucherProvider extends CommonProvider {
  Future<dynamic> getVoucherList() async {
    final response = await get(UrlStrings.voucherUrl + '?page=1&limit=10',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }

    logError(response);
    return Future.error(response.statusText!);
  }
}
