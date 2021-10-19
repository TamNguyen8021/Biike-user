import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class WalletProvider extends CommonProvider {
  Future<dynamic> getUserWalletList({required int userId}) async {
    final response = await get(
        UrlStrings.walletUrl + 'users/$userId?page=1&limit=10',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (WalletProvider - getUserWalletList()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }
    Biike.logger.e(
        'WalletProvider - getUserWalletList()',
        response.statusCode.toString() +
            ' ' +
            response.statusText! +
            response.body);
    return Future.value(null);
  }
}
