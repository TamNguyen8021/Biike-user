import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/edit_address_book_controller.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:get/get.dart';

class EditAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(EditAddressBookController());
    CommonFunctions.bind(AddressBookProvider());
  }
}
