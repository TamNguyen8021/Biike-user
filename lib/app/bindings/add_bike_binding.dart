import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:get/get.dart';

class AddBikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBikeController>(() => AddBikeController());
  }
}
