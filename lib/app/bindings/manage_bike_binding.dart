import 'package:bikes_user/app/controllers/manage_bike_controller.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [ManageBikePage]
class ManageBikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageBikeController>(() => ManageBikeController());
  }
}
