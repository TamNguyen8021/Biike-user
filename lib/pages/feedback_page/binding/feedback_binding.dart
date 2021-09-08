import 'package:bikes_user/pages/feedback_page/controller/feedback_cotroller.dart';
import 'package:get/get.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FeedbackController());
  }
}