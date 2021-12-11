import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class EditAddressBookController extends GetxController {
  final _addressBookProvider = Get.find<AddressBookProvider>();

  Rx<String> name = ''.obs;
  Rx<String> address = ''.obs;
  Rx<String> note = ''.obs;
  Rx<bool> isDefault = false.obs;

  bool isLoading = false;
  String tempName = '';
  String tempAddress = '';
  String tempNote = '';
  bool tempDefault = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void changeDefault() {
    isDefault.value = !isDefault.value;
  }

  Future<bool> editAddress(int id) async {
    _enableLoading(true);

    Map<String, dynamic> body = {
      'userId': Biike.userId.value,
      'userAddressName': name.value,
      'userAddressDetail': address.value,
      'userAddressCoordinate': '123,123',
      'userAddressNote': note.value,
      'isDefault': isDefault.value,
    };

    return await _addressBookProvider.editAddressBook(body: body, id: id);
  }

  bool validate() {
    if (name.value.trim().isEmpty || address.value.trim().isEmpty) {
      return false;
    }

    return true;
  }

  bool isSaveButtonDisable(
      {required String newName,
      required String newAddress,
      required String newNote,
      required bool newDefault}) {
    return (tempName == newName) &&
        (tempAddress == newAddress) &&
        (tempNote == newNote) &&
        (tempDefault == newDefault);
  }
}
