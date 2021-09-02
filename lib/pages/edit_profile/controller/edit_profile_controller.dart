import 'package:bikes_user/utils/enums.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  Rx<String> fullname = 'Nguyễn Hoàng Thảo Vân'.obs;
  Rx<Gender> gender = Gender.Male.obs;

  void changeGender(newGender) {
    gender.value = newGender;
  }
}
