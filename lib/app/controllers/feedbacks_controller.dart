import 'package:bikes_user/app/common/functions/BadWordsFilter/bad_words_filter.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:bikes_user/app/data/providers/feedback_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  var _star, _feedback;
  var _criteria;

  bool _isStarRated() {
    return _star != null ? true : false;
  }

  bool _isFeedbackContainsBadWords() {
    return _feedback != null && BadWordsFilter().hasBadWords(_feedback);
  }

  void updateStarRating(int star) {
    _star = star;
  }

  void updateFeedback(String feedback) {
    _feedback = feedback;
  }

  String validateFeedback() {
    if (!_isStarRated()) {
      return CustomErrorsString.kNotRated;
    }

    if (_isFeedbackContainsBadWords()) {
      return CustomErrorsString.kIncludeBadWords;
    }

    return '';
  }

  Future<dynamic> sendFeedback() async {
    //TODO tripId
    Feedback feedback = new Feedback(
        feedbackId: -1,
        userId: Biike.userId.value,
        tripId: 1,
        feedbackContent: _feedback ?? '',
        tripStar: _star.toInt(),
        criteria: _criteria ?? '');

    dynamic result = await FeedbackProvider().sendFeedback(feedback);

    _star = null;
    _feedback = null;
    return result;
  }
}
