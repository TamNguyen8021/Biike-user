import 'package:bikes_user/app/controllers/top_biker_controller.dart';
import 'package:bikes_user/app/data/providers/top_biker_provider.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [TopBikerPage]
class TopBikerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopBikerController>(() => TopBikerController());
    Get.put(TopBikerProvider());
  }
}
