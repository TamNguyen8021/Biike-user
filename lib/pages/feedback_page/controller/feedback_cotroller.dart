import 'package:get/get.dart';

class FeedbackController extends GetxController {
  var _star, _feedback;

  void updateStarRating(star) {
    _star = star;
  }

  void updateFeedback(feedback) {
    _feedback = feedback;
  }

  bool isSendFeedbackSuccess() {
    //TODO
    print(_star.toString() + " - " + _feedback.toString());
    return true;
  }
}