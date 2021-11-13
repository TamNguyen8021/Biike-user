import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/providers/address_book_provider.dart';
import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
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

      dynamic response = await UserProvider().getProfile(userId: Biike.userId.value);
      if (response != null) {
        try {
          for (var address in response['userAddresses']) {
            print(address);
            addressBooks.add(
                AddressBookCard(
                    id: address['userAddressId'],
                    name: address['userAddressName'],
                    address: address['userAddressDetail'],
                    note: address['userAddressNote']
                )
            );
          }
        } catch (e) {
          print(e);
        }
      }
  }

  Future<void> removeAddressBook({required BuildContext context, required int id}) async {
    bool result = await AddressBookProvider().removeAddressBook(id: id);
    if (result) {
      await getAddressBooks();
      Get.back();
      CommonFunctions().showInfoDialog(
          context: context,
          message: "Xoá địa chỉ thành công!");
    } else {
      CommonFunctions().showErrorDialog(
          context: context, message: CustomErrorsString.kDevelopError.tr);
    }
  }
}