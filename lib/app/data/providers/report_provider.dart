import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class ReportProvider extends CommonProvider {
  /// Report a user with [partnerId] and [reportReason]
  ///
  /// Author: TamNTT
  Future<bool> reportUser(
      {required int partnerId, required String reportReason}) async {
    final response = await post(
        UrlStrings.reportUrl,
        {
          "userOneId": Biike.userId.value,
          "userTwoId": partnerId,
          "reportReason": reportReason
        },
        headers: await headers);

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}
