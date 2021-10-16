import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class WalletProvider extends CommonProvider {
  Future<dynamic> getUserWalletList({required int userId}) async {
    final response = await get('$apiUrl/wallets/users/$userId?page=1&limit=10',
      headers: await headers);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }

    return Future.value(null);
  }
}