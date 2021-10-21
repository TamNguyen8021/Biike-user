import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:get/get.dart';

class BookTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookTripController>(() => BookTripController());
  }
}
