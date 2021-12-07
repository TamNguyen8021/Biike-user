import 'package:bikes_user/app/controllers/cho_now_settings_controller.dart';
import 'package:get/get.dart';

class ChoNowSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoNowSettingsController>(() => ChoNowSettingsController());
  }
}
