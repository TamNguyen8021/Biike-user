import 'package:bikes_user/app/controllers/edit_sos_number_controller.dart';
import 'package:get/get.dart';

class EditSOSNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditSOSNumberController());
  }
}