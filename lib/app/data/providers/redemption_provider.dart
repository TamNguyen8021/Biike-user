import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class RedemptionProvider extends CommonProvider {
  Future<dynamic> exchangeVoucher(data) async {
    final response =
        await post(UrlStrings.redemptionUrl, data, headers: await headers);

    logResponse(response);

    if (response.hasError) {
      logError(response);
    }

    return response.statusCode == HttpStatus.created
        ? Future.value(response)
        : Future.value(response.bodyString ?? '');
  }

  Future<dynamic> getYourVoucherList(
      {required int userId, required bool expiredStatus, required int page, required int limit}) async {
    final response = await get(
        UrlStrings.redemptionUrl + '/users/$userId/full?page=1&limit=10&isExpired=$expiredStatus',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    logError(response);
    return Future.error(response.statusText!);
  }

  Future<dynamic> getRedemptionDetailByRedemptionId(redemptionId) async {
    final response = await get(UrlStrings.redemptionUrl + '/$redemptionId/full',
        headers: await headers);

    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response.body['data'];
    }
    logError(response);
    return Future.error(response.statusText!);
  }

  Future<dynamic> editVoucherUsage(redemptionId) async {
    final response = await put(
        UrlStrings.redemptionUrl + '/$redemptionId', null,
        headers: await headers);
    logResponse(response);

    if (response.statusCode == HttpStatus.ok) {
      return response;
    }

    logError(response);
    return Future.value(response.bodyString ?? '');
  }
}
