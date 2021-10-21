import 'package:bikes_user/app/data/providers/station_provider.dart';
import 'package:get/get.dart';

class StationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StationProvider());
  }
}
