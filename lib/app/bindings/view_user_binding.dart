import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:get/get.dart';

class ViewUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewUserController());
  }
}
