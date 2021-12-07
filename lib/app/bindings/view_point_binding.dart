import 'package:bikes_user/app/controllers/view_point_controller.dart';
import 'package:bikes_user/app/data/providers/point_history_provider.dart';
import 'package:get/get.dart';

class ViewPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PointHistoryProvider());
    Get.lazyPut<ViewPointController>(() => ViewPointController());
  }
}
