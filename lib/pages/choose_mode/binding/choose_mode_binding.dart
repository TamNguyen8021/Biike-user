import 'package:bikes_user/pages/choose_mode/controller/choose_mode_controller.dart';
import 'package:get/get.dart';

class ChooseModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseModeController());
  }
}
