import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/add_address_book_controller.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/address_book_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_address_book' screen
class AddAddressBookPage extends StatelessWidget {
  final addAddressBookPageController = Get.find<AddAddressBookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kAddAddressBook.tr),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
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
                        initialValue: '${addAddressBookPageController.name}',
                        labelText: CustomStrings.kName.tr,
                        onChangedFunc: (value) {
                          addAddressBookPageController.name.value = value;
                        },
                      ),
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
                      () => AddressBookTextField(
                        hintText: CustomStrings.kEnterAddress.tr,
                        isReadOnly: false,
                        initialValue: '${addAddressBookPageController.address}',
                        labelText: CustomStrings.kAddress.tr,
                        onChangedFunc: (String address) {
                          addAddressBookPageController.address.value = address;
                        },
                      ),
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
                        initialValue: '${addAddressBookPageController.note}',
                        labelText: CustomStrings.kNote.tr,
                        onChangedFunc: (value) {
                          addAddressBookPageController.note.value = value;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          CustomStrings.kSetAsDefault.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(() => Switch(
                            value: addAddressBookPageController.isDefault.value,
                            onChanged: (bool value) {
                              addAddressBookPageController.changeDefault();
                            })),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: CustomElevatedIconHasLoadingButton(
                        onPressedFunc: () async {
                          if (addAddressBookPageController.validate()) {
                            if (await addAddressBookPageController
                                .addAddress()) {
                              Get.back();
                            } else {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      headerAnimationLoop: false,
                                      desc: CustomErrorsString.kDevelopError.tr)
                                  .show();
                            }
                          } else {
                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    headerAnimationLoop: false,
                                    desc:
                                        CustomErrorsString.kNotFillAllFields.tr)
                                .show();
                          }
                        },
                        text: CustomStrings.kSave.tr,
                        backgroundColor: CustomColors.kBlue,
                        foregroundColor: Colors.white,
                        elevation: 2.0,
                        icon: Icons.save,
                        isLoading: addAddressBookPageController.isLoading,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
