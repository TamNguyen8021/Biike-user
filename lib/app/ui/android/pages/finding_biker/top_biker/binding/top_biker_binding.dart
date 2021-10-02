import 'package:bikes_user/app/ui/android/pages/finding_biker/top_biker/controller/top_biker_controller.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [TopBikerPage]
class TopBikerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TopBikerController());
  }
}
