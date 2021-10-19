import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:get/get.dart';

class TripHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripHistoryController>(() => TripHistoryController());
  }
}
