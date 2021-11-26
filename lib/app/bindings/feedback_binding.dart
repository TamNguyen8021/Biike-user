import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/data/providers/feedback_provider.dart';
import 'package:get/get.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
    Get.put(FeedbackProvider());
  }
}
