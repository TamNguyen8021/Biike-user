import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/trip_history_controller.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class TripHistoryBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(TripHistoryController());
    CommonFunctions.bind(TripProvider());
  }
}
