import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';

class RedemptionProvider extends CommonProvider {
  Future<bool> exchangeVoucher(data) async {
    final response =
        await post(UrlStrings.redemptionUrl, data, headers: await getHeaders());

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }

  Future<dynamic> getYourVoucherList({int? userId}) async {
    final response = await get(
        UrlStrings.redemptionUrl + '/users/$userId/full?page=1&limit=10',
        headers: await getHeaders());

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}
