import 'package:bikes_user/app/data/providers/bike_provider.dart';
import 'package:get/get.dart';

class BikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BikeProvider());
  }
}
