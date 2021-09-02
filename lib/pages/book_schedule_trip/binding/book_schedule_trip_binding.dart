import 'package:bikes_user/pages/book_schedule_trip/controller/book_schedule_trip_controller.dart';
import 'package:get/get.dart';

class BookScheduleTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookScheduleTripController());
  }
}
