import 'package:bikes_user/app/controllers/book_schedule_trip_controller.dart';
import 'package:get/get.dart';

class BookScheduleTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookScheduleTripController>(() => BookScheduleTripController());
  }
}
