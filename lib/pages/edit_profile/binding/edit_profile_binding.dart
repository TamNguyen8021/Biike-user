import 'package:bikes_user/pages/edit_profile/controller/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}
