import 'package:bikes_user/app/controllers/address_book_controller.dart';
import 'package:get/get.dart';

class AddressBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressBookController());
  }
}