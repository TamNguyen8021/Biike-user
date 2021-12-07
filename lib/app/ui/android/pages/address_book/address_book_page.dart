import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/address_book_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/lists/list_address_books.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'address_book' screen
class AddressBookPage extends StatelessWidget {
  const AddressBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressBookController = Get.find<AddressBookController>();

    return FutureBuilder(
        future: addressBookController.getAddressBooks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => Scaffold(
                  appBar: CustomAppBar(
                    hasShape: true,
                    appBar: AppBar(),
                    hasLeading: true,
                    onPressedFunc: () {
                      Get.back();
                    },
                    title: Text(
                      CustomStrings.kAddressBook.tr,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(22.0),
                          child: ListAddressBooks(
                            listAddressBooks:
                                addressBookController.addressBooks.toList(),
                            itemPadding: 10.0,
                          )),
                    ]),
                  ),
                  floatingActionButton: FloatingActionButton(
                    elevation: 1.0,
                    onPressed: () => Get.toNamed(CommonRoutes.ADD_ADDRESS_BOOK)
                        ?.then(
                            (value) => addressBookController.getAddressBooks()),
                    backgroundColor: CustomColors.kDarkBlue,
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                ));
          } else {
            return Loading();
          }
        });
  }
}
