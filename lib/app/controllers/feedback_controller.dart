import 'package:bikes_user/app/common/functions/BadWordsFilter/bad_words_filter.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  var _star, _feedback;
  final filter = BadWordsFilter();

  bool _isStarRated() {
    return _star != null ? true : false;
  }

  bool _isFeedbackContainsBadWords() {
    return _feedback != null && filter.hasBadWords(_feedback);
  }

  void updateStarRating(star) {
    _star = star;
  }

  void updateFeedback(feedback) {
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

  bool isSendFeedbackSuccess() {
    //TODO
    Biike.logger.i(_star.toString() + " - " + _feedback.toString());
    _star = null;
    _feedback = null;
    return true;
  }
}
