import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/app_setting_controller.dart';
import 'package:get/get.dart';

class AppSettingBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(AppSettingController());
  }
}
