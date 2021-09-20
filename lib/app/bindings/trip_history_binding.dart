import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/data/providers/trip_history_provider.dart';
import 'package:get/get.dart';

class TripHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TripHistoryController());
    Get.put(TripHistoryProvider());
  }
}
