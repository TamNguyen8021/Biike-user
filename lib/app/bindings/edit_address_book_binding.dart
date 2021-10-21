import 'package:bikes_user/app/controllers/edit_address_book_controller.dart';
import 'package:get/get.dart';

class EditAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressBookController>(() => EditAddressBookController());
  }
}
