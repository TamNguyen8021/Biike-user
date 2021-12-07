import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/choose_mode_controller.dart';
import 'package:get/get.dart';

class ChooseModeBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(ChooseModeController());
  }
}
