import 'package:bikes_user/app/controllers/add_sos_number_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
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
                            () => SOSNumberTextField(
                            hintText: CustomStrings.kEnterName.tr,
                            isReadOnly: false,
                            isEditSOSNumber: true,
                            initialValue: '${addSOSNumberController.name}',
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
                            CustomStrings.kNumberPhone.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Obx(
                            () => SOSNumberTextField(
                            hintText: CustomStrings.kEnterNumberPhone.tr,
                            isReadOnly: false,
                            isEditSOSNumber: true,
                            initialValue: '${addSOSNumberController.number}',
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