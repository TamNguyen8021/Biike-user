import 'package:bikes_user/app/controllers/open_page_controller.dart';
import 'package:bikes_user/app/data/providers/trip_provider.dart';
import 'package:get/get.dart';

class OpenPageBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenPageController>(() => OpenPageController());
    Get.put(TripProvider());
  }
}
