import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/add_address_book_controller.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:get/get.dart';

class AddAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(AddAddressBookController());
    CommonFunctions.bind(AddressBookProvider());
  }
}
