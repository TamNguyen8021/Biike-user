import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/address_book_controller.dart';
import 'package:bikes_user/app/controllers/edit_address_book_controller.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_action_field.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'edit_address_book' screen
class EditAddressBookPage extends StatelessWidget {
  final editAddressBookPageController = Get.find<EditAddressBookController>();
  final _addressBookController = Get.find<AddressBookController>();

  int id = Get.arguments['id'];
  String name = Get.arguments['name'];
  String address = Get.arguments['address'];
  String note = Get.arguments['note'];

  @override
  Widget build(BuildContext context) {
    editAddressBookPageController.name.value = name;
    editAddressBookPageController.address.value = address;
    editAddressBookPageController.note.value = note;

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
                        labelText: CustomStrings.kName.tr,
                        onChangedFunc: (value) {
                          editAddressBookPageController.name.value = value;
                        }),
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
                  Row(
                    children: <Widget>[
                      Text(
                        CustomStrings.kNote.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Obx(
                    () => AddressBookTextField(
                        hintText: CustomStrings.kEnterNote.tr,
                        isReadOnly: false,
                        isEditAddressBook: true,
                        initialValue: '${editAddressBookPageController.note}',
                        labelText: CustomStrings.kNote.tr,
                        onChangedFunc: (value) {
                          editAddressBookPageController.note.value = value;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CustomElevatedIconHasLoadingButton(
                      onPressedFunc: () async {
                        if (editAddressBookPageController.validate()) {
                          if (await editAddressBookPageController
                              .editAddress(id)) {
                            await _addressBookController.getAddressBooks();
                            Get.back();
                          } else {
                            CommonFunctions().showErrorDialog(
                                context: context,
                                message: CustomErrorsString.kDevelopError.tr);
                          }
                        } else {
                          CommonFunctions().showErrorDialog(
                              context: context,
                              message: CustomErrorsString
                                  .kFillInAllField.tr);
                        }
                      },
                      text: CustomStrings.kSave.tr,
                      backgroundColor: CustomColors.kBlue,
                      foregroundColor: Colors.white,
                      elevation: 2.0,
                      icon: Icons.save,
                      isLoading: editAddressBookPageController.isLoading,
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
