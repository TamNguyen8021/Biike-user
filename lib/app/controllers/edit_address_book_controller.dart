import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class EditAddressBookController extends GetxController {
  final _addressBookProvider = Get.find<AddressBookProvider>();

  Rx<String> name = ''.obs;
  Rx<String> address = '1426/39, Nguyễn Duy Trinh'.obs;
  Rx<String> note =''.obs;

  bool isLoading = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  Future<bool> editAddress(int id) async {
    _enableLoading(true);

    Map<String, dynamic> body = {
      'userId' : Biike.userId.value,
      'userAddressName': name.value,
      'userAddressDetail': address.value,
      'userAddressCoordinate': '123,123',
      'userAddressNote': note.value
    };

    return await _addressBookProvider.editAddressBook(body: body, id: id);
  }

  bool validate() {
    if (name.value.trim().isEmpty || address.value.trim().isEmpty) {
      return false;
    }

    return true;
  }
}
