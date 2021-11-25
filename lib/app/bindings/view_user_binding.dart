import 'package:bikes_user/app/controllers/view_user_controller.dart';
import 'package:bikes_user/app/data/providers/intimacies_provider.dart';
import 'package:bikes_user/app/data/providers/report_provider.dart';
import 'package:get/get.dart';

class ViewUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IntimaciesProvider());
    Get.put(ReportProvider());
    Get.lazyPut<ViewUserController>(() => ViewUserController());
  }
}
