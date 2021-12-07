import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/cho_now_settings_controller.dart';
import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:get/get.dart';

class ChoNowSettingsBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(ChoNowSettingsController());
    CommonFunctions.bind(StationProvider());
  }
}
