import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/address_book_controller.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class AddressBookBinding extends Bindings {
  @override
  void dependencies() {
    CommonFunctions.bind(AddressBookController());
    CommonFunctions.bind(UserProvider());
    CommonFunctions.bind(AddressBookProvider());
  }
}
