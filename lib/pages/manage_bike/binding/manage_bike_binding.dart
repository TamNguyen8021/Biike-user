import 'package:bikes_user/pages/manage_bike/controller/manage_bike_controller.dart';
import 'package:bikes_user/pages/manage_bike/view/manage_bike_page.dart';
import 'package:get/get.dart';

/// Contains controllers and services for [ManageBikePage]
class ManageBikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManageBikeController());
  }
}
