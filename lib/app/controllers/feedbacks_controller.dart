import 'package:bikes_user/app/common/functions/BadWordsFilter/bad_words_filter.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/models/feedback.dart';
import 'package:bikes_user/app/data/providers/feedback_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final _feedbackProvider = Get.find<FeedbackProvider>();
  final _walletController = Get.find<WalletController>();

  var _star, _feedbackContent, _tip;
  List<String> _criteria = [];
  final filter = BadWordsFilter();

  void updateStarRating(star) {
    _star = star;
  }

  void updateFeedback(feedbackContent) {
    _feedbackContent = feedbackContent;
  }

  void updateCriteria(String criteria, {isRemove = false}) {
    if (isRemove == true) {
      _criteria.remove(criteria);
      return;
    }
    _criteria.addIf(!_criteria.contains(criteria), criteria);
  }

  void updateTip(tip) {
    _tip = tip;
  }

  bool _isStarRated() {
    return _star != null ? true : false;
  }

  bool _isFeedbackContainsBadWords() {
    return _feedbackContent != null && filter.hasBadWords(_feedbackContent);
  }

  Future<String> validateFeedback() async {
    if (!_isStarRated()) {
      return CustomErrorsString.kNotRated.tr;
    }

    if (_isFeedbackContainsBadWords()) {
      return CustomErrorsString.kIncludeBadWords.tr;
    }

    await _walletController.updateWalletPoint();

    if (_tip != null && _walletController.totalWalletPoint < int.parse(_tip)) {
      return CustomErrorsString.kNotEnoughPoint.tr;
    }
    return '';
  }

  Future<bool> sendFeedback(tripId) async {
    Feedback feedback = Feedback(
        feedbackId: 0,
        userId: Biike.userId.value,
        tripId: tripId,
        feedbackContent: _feedbackContent ?? '',
        tripStar: _star.round(),
        tripTip: _tip ?? 0,
        criteria: _criteria.isEmpty ? '' : _criteria.toString(),
        createdDate: DateTime.now());

    return await _feedbackProvider.sendFeedback(feedback);
  }
}
