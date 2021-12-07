import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(ProfileController());
    CommonFunctions.bind(UserProvider());
  }
}
