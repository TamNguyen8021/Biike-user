import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class FeedbackProvider extends CommonProvider {
  Future<dynamic> sendFeedback(Feedback feedback) async {
    final response = await post(UrlStrings.feedbackUrl,
        feedback.toJson(),
        headers: await headers);

    logResponse(response);

    if (response.statusCode != HttpStatus.created) {
      logError(response);
      return Future.value(response.bodyString ?? '');
    }
    return Future.value(true);
  }
}