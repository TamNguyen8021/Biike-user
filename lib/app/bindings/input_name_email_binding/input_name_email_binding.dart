import 'package:bikes_user/app/controllers/register_controller.dart';
import 'package:get/get.dart';

class InputNameEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}