import 'package:bikes_user/app/controllers/address_book_controller.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/add_address_book_button.dart';
import 'package:bikes_user/app/ui/android/widgets/cards/address_book_card.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_address_books.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The address book screen
class AddressBookPage extends StatelessWidget {
  const AddressBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressBookController = Get.find<AddressBookController>();

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(
          CustomStrings.kAddressBook.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(22.0),
              child: ListAddressBooks(
                listAddressBooks: [
                  AddressBookCard(name: 'Chung cư SKY9', address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  AddressBookCard(name: 'Chung cư SKY9', address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  AddressBookCard(name: 'Chung cư SKY9', address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM'),
                  AddressBookCard(name: 'Chung cư SKY9', address: 'CT1SKY9, Phường Phú Hiệp, Tp.Thủ Đức, TP.HCM')
                ],
                itemPadding: 10.0,
              )
            ),
          ]),
      ),
      floatingActionButton: AddAddressBookButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
