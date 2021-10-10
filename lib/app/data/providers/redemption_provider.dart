import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class RedemptionProvider extends CommonProvider {
  Future<bool> exchangeVoucher(data) async {
    final response = await post('$apiUrl/redemptions', data,
      headers: await getHeaders());

    return response.statusCode == HttpStatus.created
        ? Future.value(true)
        : Future.value(false);
  }

  Future<dynamic> getYourVoucherList({userId}) async {
    final response = await
      get('$apiUrl/redemptions/users/$userId/full?page=1&limit=10', headers: await getHeaders());

    if (response.statusCode ==  HttpStatus.ok) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}