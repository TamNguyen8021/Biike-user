import 'package:get/get.dart';

class AppSettingController extends GetxController {
  Rx<bool> isLoginByFingerprint = false.obs;

  void changeLoginByFingerprintState() {
    isLoginByFingerprint.value = !isLoginByFingerprint.value;
  }
}
