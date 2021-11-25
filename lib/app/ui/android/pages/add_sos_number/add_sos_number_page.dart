import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/controllers/add_sos_number_controller.dart';
import 'package:bikes_user/app/controllers/sos_number_controller.dart';
import 'package:bikes_user/app/ui/android/pages/manage_bike/widgets/custom_elevated_icon_has_loading_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/sos_number_text_field.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The 'add_sos_number' screen
class AddSOSNumberPage extends StatelessWidget {
  final addSOSNumberController = Get.find<AddSOSNumberController>();
  final sosNumberController = Get.find<SOSNumberController>();

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
        title: Text(CustomStrings.kAddSOSNumber.tr),
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
                        initialValue: '${addSOSNumberController.name}',
                        labelText: CustomStrings.kName.tr,
                        onChangedFunc: (value) => {
                          addSOSNumberController.name.value = value
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
                        initialValue: '${addSOSNumberController.number}',
                        labelText: CustomStrings.kNote.tr,
                        onChangedFunc: (value) => {
                          addSOSNumberController.number.value = value
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CustomElevatedIconHasLoadingButton(
                      onPressedFunc: () async {
                        if (addSOSNumberController.validate()) {
                          if (await addSOSNumberController
                              .addSOSNumber()) {
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
                      isLoading: addSOSNumberController.isLoading,
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
