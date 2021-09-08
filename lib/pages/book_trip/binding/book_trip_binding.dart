import 'package:bikes_user/pages/book_trip/controller/book_trip_controller.dart';
import 'package:get/get.dart';

class BookTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookTripController());
  }
}
