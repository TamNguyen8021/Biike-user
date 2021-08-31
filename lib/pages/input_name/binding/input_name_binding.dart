import 'package:bikes_user/pages/input_name/controller/input_name_controller.dart';
import 'package:get/get.dart';

class InputNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InputNameController());
  }
}
