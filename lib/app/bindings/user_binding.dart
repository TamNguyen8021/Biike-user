import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserProvider());
  }
}
