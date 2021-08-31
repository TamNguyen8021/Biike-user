import 'package:bikes_user/pages/input_phone/controller/input_phone_controller.dart';
import 'package:get/get.dart';

class InputPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InputPhoneController());
  }
}
