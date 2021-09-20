import 'package:bikes_user/app/data/enums/gender_enum.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  Rx<String> fullname = 'Nguyễn Hoàng Thảo Vân'.obs;
  Rx<Gender> gender = Gender.male.obs;

  void changeGender(newGender) {
    gender.value = newGender;
  }
}
