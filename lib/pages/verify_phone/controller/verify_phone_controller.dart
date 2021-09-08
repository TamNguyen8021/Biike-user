import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  Rx<String> verifyCode = ''.obs;

  void inputVerifyCode(code) {
    verifyCode.value = code;
  }
}
