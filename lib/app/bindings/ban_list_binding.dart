import 'package:bikes_user/app/controllers/ban_list_controller.dart';
import 'package:get/get.dart';

class BanListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BanListController>(() => BanListController());
  }
}
