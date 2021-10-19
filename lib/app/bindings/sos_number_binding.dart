import 'package:bikes_user/app/controllers/sos_number_controller.dart';
import 'package:get/get.dart';

class SOSNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SOSNumberController>(() => SOSNumberController());
  }
}
