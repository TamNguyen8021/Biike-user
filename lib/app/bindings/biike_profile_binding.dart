import 'package:bikes_user/app/controllers/biike_profile_controller.dart';
import 'package:get/get.dart';

class BiikeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiikeProfileController>(() => BiikeProfileController());
  }
}
