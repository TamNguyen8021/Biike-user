import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class VoucherProvider extends CommonProvider {
  Future<dynamic> getVoucherList() async {
    final response = await get(UrlStrings.voucherUrl + '?page=1&limit=10',
        headers: await headers);

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}
