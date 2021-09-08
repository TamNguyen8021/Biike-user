import 'package:bikes_user/pages/verify_phone/controller/verify_phone_controller.dart';
import 'package:get/get.dart';

class VerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VerifyPhoneController());
  }
}
