import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class IntimaciesProvider extends CommonProvider {
  /// Check two users intimacies based on userId and [partnerId]
  ///
  /// Author: TamNTT
  Future<bool> checkIntimacies({required int partnerId}) async {
    final response = await get(
        UrlStrings.intimaciesUrl +
            '?userOneId=${Biike.userId.value}&userTwoId=$partnerId',
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return Future.error(response.statusText!);
    } else {
      return response.body['data'];
    }
  }

  /// Call API to create intimacies
  ///
  /// Author: TamNTT
  Future<bool> createIntimacies({required Map<String, dynamic> body}) async {
    final response =
        await post(UrlStrings.intimaciesUrl, body, headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }

  /// Call API to edit intimacies
  ///
  /// Author: TamNTT
  Future<bool> editIntimacies({required Map<String, dynamic> body}) async {
    final response =
        await put(UrlStrings.intimaciesUrl, body, headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
