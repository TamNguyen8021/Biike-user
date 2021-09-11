import 'package:bikes_user/trip_history/controller/trip_history_controller.dart';
import 'package:bikes_user/trip_history/provider/trip_history_provider.dart';
import 'package:get/get.dart';

class TripHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TripHistoryController());
    Get.put(TripHistoryProvider());
  }
}
