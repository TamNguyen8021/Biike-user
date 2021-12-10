import 'package:bikes_user/app/controllers/add_address_book_controller.dart';
import 'package:bikes_user/app/controllers/profile_controller.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AddAddressBookController>(() => AddAddressBookController());
    Get.put(AddressBookProvider());
  }
}
