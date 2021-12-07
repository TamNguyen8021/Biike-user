import 'package:bikes_user/app/controllers/add_sos_number_controller.dart';
import 'package:get/get.dart';

class AddSOSNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSOSNumberController>(() => AddSOSNumberController());
  }
}
