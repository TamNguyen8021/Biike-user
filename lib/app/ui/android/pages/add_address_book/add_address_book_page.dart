import 'package:bikes_user/app/controllers/add_address_book_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_action_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_address_book' screen
class AddAddressBookPage extends StatelessWidget {
  final addAddressBookPageController = Get.find<AddAddressBookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kAddAddressBook.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Form(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '* ',
                            style: TextStyle(
                                color: Colors.red
                            ),
                          ),
                          Text(
                            CustomStrings.kName.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Obx(
                            () => AddressBookTextField(
                                hintText: 'Nhập tên',
                                isReadOnly: false,
                                isEditAddressBook: true,
                                initialValue: '${addAddressBookPageController.name}',
                                labelText: CustomStrings.kName.tr),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '* ',
                            style: TextStyle(
                                color: Colors.red
                            ),
                          ),
                          Text(
                            CustomStrings.kAddress.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Obx(
                            () => AddressBookTextActionField(
                                hintText: 'Chọn địa chỉ',
                                isReadOnly: true,
                                isEditAddressBook: true,
                                initialValue: '${addAddressBookPageController.address}',
                                labelText: CustomStrings.kAddress.tr),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '* ',
                            style: TextStyle(
                                color: Colors.red
                            ),
                          ),
                          Text(
                            CustomStrings.kNote.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Obx(
                            () => AddressBookTextField(
                                hintText: 'Nhập ghi chú',
                                isReadOnly: false,
                                isEditAddressBook: true,
                                initialValue: '${addAddressBookPageController.note}',
                                labelText: CustomStrings.kNote.tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child:  CustomElevatedIconButton(
                          onPressedFunc: () => Get.back(),
                          text: CustomStrings.kSave.tr,
                          icon: Icons.save,
                          elevation: 0.0,
                          backgroundColor: CustomColors.kBlue,
                          foregroundColor: Colors.white,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}