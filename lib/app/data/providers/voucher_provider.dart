import 'package:bikes_user/app/common/functions/common_provider.dart';

class VoucherProvider extends CommonProvider {
  Future<dynamic> getVoucherList() async {
    final response = await
      get('$apiUrl/vouchers?page=1&limit=10',
        headers: await getHeaders());

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}