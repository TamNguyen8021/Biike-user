import 'package:bikes_user/app/controllers/edit_address_book_controller.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_action_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'edit_address_book' screen
class EditAddressBookPage extends StatelessWidget {
  final editAddressBookPageController = Get.find<EditAddressBookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kEditAddressBook.tr),
        actionWidgets: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          ),
        ],
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
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        CustomStrings.kName.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Obx(
                    () => AddressBookTextField(
                        hintText: CustomStrings.kEnterName.tr,
                        isReadOnly: false,
                        isEditAddressBook: true,
                        initialValue: '${editAddressBookPageController.name}',
                        labelText: CustomStrings.kName.tr),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '* ',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        CustomStrings.kAddress.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Obx(
                    () => AddressBookTextActionField(
                        hintText: CustomStrings.kSelectAddress.tr,
                        isReadOnly: true,
                        isEditAddressBook: true,
                        initialValue:
                            '${editAddressBookPageController.address}',
                        labelText: CustomStrings.kAddress.tr),
                  ),
                  Text(
                    CustomStrings.kNote.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => AddressBookTextField(
                        hintText: CustomStrings.kEnterNote.tr,
                        isReadOnly: false,
                        isEditAddressBook: true,
                        initialValue: '${editAddressBookPageController.note}',
                        labelText: CustomStrings.kNote.tr),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CustomElevatedIconButton(
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
