import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class AddAddressBookController extends GetxController {
  final _addressBookProvider = Get.find<AddressBookProvider>();

  Rx<String> name = ''.obs;
  Rx<String> address = ''.obs;
  Rx<String> note = ''.obs;
  Rx<bool> isDefault = false.obs;

  bool isLoading = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void changeDefault() {
    isDefault.value = !isDefault.value;
  }

  Future<bool> addAddress() async {
    _enableLoading(true);

    Map<String, dynamic> body = {
      'userId': Biike.userId.value,
      'userAddressName': name.value,
      'userAddressDetail': address.value,
      'userAddressCoordinate': '123,123',
      'userAddressNote': note.value,
      'isDefault': isDefault.value,
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
