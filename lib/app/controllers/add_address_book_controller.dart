import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:get/get.dart';

class AddAddressBookController extends GetxController {
  final _addressBookProvider = Get.find<AddressBookProvider>(); 
  
  Rx<String> name = ''.obs;
  Rx<String> address = '1426/39, Nguyễn Duy Trinh'.obs;
  Rx<String> note =''.obs;

  bool isLoading = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<bool> addAddress() async {
    _enableLoading(true);

    Map<String, dynamic> body = {
      'addressName': name.value,
      'addressDetail': address.value,
      'addressCoordinate': '123,123',
      'note': note.value
    };

    return await _addressBookProvider.addAddressBook(body: body);
  }

  bool validate() {
    if (name.value.trim().isEmpty || address.value.trim().isEmpty) {
      return false;
    }

    return true;
  }
}
