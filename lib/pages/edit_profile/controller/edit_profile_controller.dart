import 'package:bikes_user/utils/enums.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  Rx<String> fullname = ''.obs;
  Rx<String> email = ''.obs;
  Rx<Gender> gender = Gender.Male.obs;

  void changeGender(newGender) {
    gender.value = newGender;
  }
}
