import 'package:bikes_user/app/controllers/cho_now_settings_controller.dart';
import 'package:bikes_user/app/data/providers/bike_availability_provider.dart';
import 'package:get/get.dart';

class ChoNowSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BikeAvailabilityProvider());
    Get.lazyPut<ChoNowSettingsController>(() => ChoNowSettingsController());
  }
}
