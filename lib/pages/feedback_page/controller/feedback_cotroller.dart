import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  var _star, _feedback;

  void updateStarRating(star) {
    _star = star;
  }

  void updateFeedback(feedback) {
    _feedback = feedback;
  }

  bool sendFeedback() {
    //TODO
    print(_star.toString() + " - " + _feedback.toString());
    return true;
  }
}