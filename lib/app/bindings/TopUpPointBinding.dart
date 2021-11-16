import 'package:bikes_user/app/controllers/top_up_point_controller.dart';
import 'package:get/get.dart';

class TopUpPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopUpPointController>(() => TopUpPointController());
  }
}
