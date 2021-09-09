import 'package:bikes_user/pages/home/controller/home_controller.dart';
import 'package:bikes_user/pages/home/controller/search_trip_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(SearchTripController());
  }
}
