import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/verify_phone_controller.dart';
import 'package:get/get.dart';

class VerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(VerifyPhoneController());
  }
}
