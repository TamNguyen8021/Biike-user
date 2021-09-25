import 'package:bikes_user/app/controllers/app_setting_controller.dart';
import 'package:get/get.dart';

class AppSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppSettingController());
  }
}