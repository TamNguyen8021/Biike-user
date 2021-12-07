import 'package:bikes_user/app/controllers/add_address_book_controller.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:get/get.dart';

class AddAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressBookController>(() => AddAddressBookController());
    Get.put(AddressBookProvider());
  }
}
