import 'package:bikes_user/app/controllers/input_phone_controller.dart';
import 'package:get/get.dart';

class InputPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InputPhoneController());
  }
}
