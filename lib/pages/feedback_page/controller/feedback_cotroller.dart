import 'package:bikes_user/utils/custom_error_strings.dart';
import 'package:get/get.dart';
import 'package:profanity_filter/profanity_filter.dart';

class FeedbackController extends GetxController {
  var _star, _feedback;
  final filter = ProfanityFilter();

  bool _isStarRated() {
    return _star != null ? true : false;
  }

  bool _isFeedbackContainsBadWords() {
    return _feedback != null && filter.hasProfanity(_feedback);
  }

  void updateStarRating(star) {
    _star = star;
  }

  void updateFeedback(feedback) {
    _feedback = feedback;
  }

  String validateFeedback() {
    if (!_isStarRated()) {
      return FeedbackError.kNotRated;
    }

    if (_isFeedbackContainsBadWords()) {
      return FeedbackError.kIncludeBadWords;
    }

    return '';
  }

  bool isSendFeedbackSuccess() {
    //TODO
    print(_star.toString() + " - " + _feedback.toString());
    _star = null;
    _feedback = null;
    return true;
  }
}