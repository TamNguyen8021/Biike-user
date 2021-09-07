import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/feedback_page/controller/feedback_cotroller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackButton extends StatelessWidget {
  final feedbackController = Get.find<FeedbackController>();
  // var star, feedback;

  SendFeedbackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          if (feedbackController.sendFeedback()) {
            print('Send feedback success');
            switch (Biike.role.value) {
              case Role.Driver:
                Get.offAllNamed('/driverHome');
                break;
              case Role.Customer:
                Get.offAllNamed('/customerHome');
                break;
              default:
                Get.defaultDialog(
                  title: 'Error',
                  middleText: 'Error',
                  middleTextStyle: TextStyle(color: CustomColors.kDarkGray),
                );
                break;
            }
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
