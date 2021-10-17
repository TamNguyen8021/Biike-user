import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:flutter_logs/flutter_logs.dart';

class VoucherProvider extends CommonProvider {
  Future<dynamic> getVoucherList() async {
    final response = await get(UrlStrings.voucherUrl + '?page=1&limit=10',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (VoucherProvider - getVoucherList()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}
