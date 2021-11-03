import 'package:bikes_user/app/controllers/view_point_controller.dart';
import 'package:get/get.dart';

class ViewPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewPointController>(() => ViewPointController());
  }
}
