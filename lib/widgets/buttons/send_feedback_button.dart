import 'package:bikes_user/main.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackButton extends StatelessWidget {
  const SendFeedbackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          if (Biike.role.value == Role.Driver) {
            Get.offAllNamed('/driverHome');
          } else if (Biike.role.value == Role.Customer) {
            Get.offAllNamed('/customerHome');
          } else {
            Get.defaultDialog(
              title: 'Error',
              middleText: 'Error',
              middleTextStyle: TextStyle(color: CustomColors.kDarkGray),
            );
          }
        },
        child: Text(
          CustomStrings.kBtnSend,
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 35.0)),
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}
