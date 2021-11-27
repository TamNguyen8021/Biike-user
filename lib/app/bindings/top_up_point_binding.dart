import 'package:bikes_user/app/controllers/top_up_point_controller.dart';
import 'package:bikes_user/app/data/providers/top_up_point_provider.dart';
import 'package:get/get.dart';

class TopUpPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TopUpPointProvider());
    Get.lazyPut<TopUpPointController>(() => TopUpPointController());
  }
}
