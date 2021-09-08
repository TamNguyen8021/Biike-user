import 'package:bikes_user/pages/feedback_page/controller/feedback_cotroller.dart';
import 'package:bikes_user/utils/bad_words_list.dart';
import 'package:get/get.dart';
import 'package:profanity_filter/profanity_filter.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FeedbackController());
    ProfanityFilter.filterAdditionally(additionalBadWords);
  }
}