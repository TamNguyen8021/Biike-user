import 'package:bikes_user/pages/view_user/controller/view_user_controller.dart';
import 'package:get/get.dart';

class ViewUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewUserController());
  }
}
