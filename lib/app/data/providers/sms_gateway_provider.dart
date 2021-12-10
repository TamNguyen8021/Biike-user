import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/main.dart';

class SpeedSMSProvider extends CommonProvider {
  /// Author: TamNTT
  Future<bool> sendSms(
      {required List<String> phoneNo,
      required String link,
      required userName,
      required userPhone}) async {
    final response = await post(
        UrlStrings.speedSMSSendSMSUrl +
            '?access-token=${UrlStrings.speedSMSApiKey}&to=$phoneNo&content=Cảnh báo S.O.S từ Biiké: $link. $userName ($userPhone) có thể đang gặp nguy hiểm. Hãy liên hệ họ ngay.\n\n$userName ($userPhone) triggered the Emergency button during a Biiké ride. See details here - $link. As $userName\'s Emergency contact, we suggest you call $userName now or the local police.&type=5&sender=0972824676',
        {
          // 'access-token': UrlStrings.speedSMSApiKey,
          // 'to': phoneNo,
          // 'content':
          //     'Cảnh báo S.O.S từ Biiké: $link. $userName ($userPhone) có thể đang gặp nguy hiểm. Hãy liên hệ họ ngay.\n\n$userName ($userPhone) triggered the Emergency button during a Biiké ride. See details here - $link. As $userName\'s Emergency contact, we suggest you call $userName now or the local police.',
          // 'type': 5,
          // 'sender': '0972824676'
        });

    logResponse(response);

    if (response.status.hasError) {
      logError(response);
      return false;
    } else {
      if (response.body['status'] == 'success') {
        return true;
      }
      logError(response);
      Biike.logger.d(response.bodyString);
      return false;
    }
  }
}
