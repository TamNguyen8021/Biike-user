import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class TripBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TripProvider());
  }
}
