import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/ui/android/pages/address_book/address_book_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/address_book_card.dart';
import 'package:bikes_user/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manage states of [AddressBookPage]
class AddressBookController extends GetxController {
  RxList<dynamic> addressBooks = [].obs;

  Future<void> getAddressBooks() async {
    addressBooks.clear();

    dynamic response =
        await UserProvider().getProfile(userId: Biike.userId.value);
    if (response != null) {
      try {
        for (var address in response['userAddresses']) {
          addressBooks.add(AddressBookCard(
              id: address['userAddressId'],
              name: address['userAddressName'],
              address: address['userAddressDetail'],
              note: address['userAddressNote'],
              isDefault: address['isDefault']));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> removeAddressBook(
      {required BuildContext context, required int id}) async {
    bool result = await AddressBookProvider().removeAddressBook(id: id);
    if (result) {
      await getAddressBooks();
      Get.back();
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kDevelopError.tr)
          .show();
    }
  }
}
