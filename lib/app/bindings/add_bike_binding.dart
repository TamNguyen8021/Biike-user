import 'package:bikes_user/app/controllers/add_bike_controller.dart';
import 'package:bikes_user/app/data/providers/image_provider.dart';
import 'package:get/get.dart';

class AddBikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImageProvider());
    Get.lazyPut<AddBikeController>(() => AddBikeController());
  }
}
