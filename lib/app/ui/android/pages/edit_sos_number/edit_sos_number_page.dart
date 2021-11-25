import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/edit_sos_number_controller.dart';
import 'package:bikes_user/app/controllers/sos_number_controller.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/sos_number_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_sos_number' screen
class EditSOSNumberPage extends StatelessWidget {
  final editSOSNumberController = Get.find<EditSOSNumberController>();
  final sosNumberController = Get.find<SOSNumberController>();

  int id = Get.arguments['id'];
  String name = Get.arguments['name'];
  String number = Get.arguments['number'];

  @override
  Widget build(BuildContext context) {
    editSOSNumberController.name.value = name;
    editSOSNumberController.number.value = number;

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kEditSOSNumber.tr),
        actionWidgets: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => {
                sosNumberController.removeSOSNumber(context: context, id: id)
              },
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
                    () => SOSNumberTextField(
                        hintText: CustomStrings.kEnterName.tr,
                        isReadOnly: false,
                        isEditSOSNumber: true,
                        initialValue: '${editSOSNumberController.name}',
                        labelText: CustomStrings.kName.tr,
                        onChangedFunc: (value) {
                          editSOSNumberController.name.value = value;
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
                        CustomStrings.kNumberPhone.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Obx(
                    () => SOSNumberTextField(
                        hintText: CustomStrings.kEnterNumberPhone.tr,
                        isReadOnly: false,
                        isEditSOSNumber: true,
                        initialValue: '${editSOSNumberController.number}',
                        labelText: CustomStrings.kNote.tr,
                        onChangedFunc: (value) {
                          editSOSNumberController.number.value = value;
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CustomElevatedIconHasLoadingButton(
                      onPressedFunc: () async {
                        if (editSOSNumberController.validate()) {
                          if (await editSOSNumberController
                              .editSOSNumber(id)) {
                            await sosNumberController.getSOSNumbers();
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
                      icon: Icons.save,
                      elevation: 0.0,
                      backgroundColor: CustomColors.kBlue,
                      foregroundColor: Colors.white,
                      isLoading: editSOSNumberController.isLoading,
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
