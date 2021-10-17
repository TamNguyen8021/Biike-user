import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class RedemptionProvider extends CommonProvider {
  Future<dynamic> exchangeVoucher(data) async {
    final response =
        await post(UrlStrings.redemptionUrl, data, headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (RedemptionProvider - exchangeVoucher()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    return response.statusCode == HttpStatus.created
        ? Future.value(response)
        : Future.value(response.bodyString ?? '');
  }

  Future<dynamic> getYourVoucherList({userId}) async {
    final response = await get(
        UrlStrings.redemptionUrl + '/users/$userId/full?page=1&limit=10',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage: '\n\nBiike (RedemptionProvider - getYourVoucherList()): ' +
            response.statusCode.toString() +
            ' ' +
            response.statusText!,
        appendTimeStamp: true);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }

  Future<dynamic> getRedemptionDetailByRedemptionId(redemptionId) async {
    final response = await get(UrlStrings.redemptionUrl + '/$redemptionId/full',
        headers: await headers);

    FlutterLogs.logToFile(
        logFileName: 'API',
        overwrite: false,
        logMessage:
            '\n\nBiike (RedemptionProvider - getRedemptionDetailByRedemptionId()): ' +
                response.statusCode.toString() +
                ' ' +
                response.statusText!,
        appendTimeStamp: true);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}
