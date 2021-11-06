import 'package:bikes_user/app/data/providers/user_provider.dart';
import 'package:bikes_user/app/ui/android/pages/address_book/address_book_page.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/address_book_card.dart';
import 'package:bikes_user/main.dart';
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
                    id: address['addressId'],
                    name: address['addressName'],
                    address: address['addressDetail'],
                    note: address['note']
                )
            );
          }
        } catch (e) {
          print(e);
        }
      }
  }
}