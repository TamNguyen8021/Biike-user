import 'package:bikes_user/pages/top_biker/controller/top_biker_controller.dart';
import 'package:bikes_user/pages/top_biker/view/top_biker_page.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [TopBikerPage]
class TopBikerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TopBikerController());
  }
}
