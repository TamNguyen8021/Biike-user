import 'package:bikes_user/app/common/functions/BadWordsFilter/bad_words_filter.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:bikes_user/app/data/providers/feedback_provider.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
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

  bool isSendFeedbackSuccess() {
    //TODO
    Feedback feedback = new Feedback(
        feedbackId: -1,
        userId: 2,
        tripId: 1,
        feedbackContent: _feedback ?? '',
        tripStar: _star.toInt(),
        criteria: "criteria");

    FeedbackProvider fp = new FeedbackProvider();
    var x= fp.sendFeedback(feedback);
    print(">>>>>>>>>>>>" +  x.toString());

    // var y = fp.getFeedback();

    _star = null;
    _feedback = null;
    return true;
  }
}
