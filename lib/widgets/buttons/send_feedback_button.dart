import 'package:bikes_user/main.dart';
import 'package:bikes_user/pages/feedback_page/controller/feedback_controller.dart';
import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_error_strings.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackButton extends StatelessWidget {
  final feedbackController = Get.find<FeedbackController>();
  static const _STRING_EQUALS = 0;
  static const _NO_ERR_MSG = '';

  SendFeedbackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          // validate feedback
          String validateMsg = feedbackController.validateFeedback();
          if (_NO_ERR_MSG.compareTo(validateMsg) != _STRING_EQUALS) {
            Get.snackbar('Error', validateMsg,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
            return;
          }

          // send feedback
          if (feedbackController.isSendFeedbackSuccess()) {
            print(CustomStrings.kSendSuccess);
            switch (Biike.role.value) {
              case Role.biker:
              case Role.keer:
                Get.offAllNamed('/home');
                break;
              default:
                Get.defaultDialog(
                  title: 'Error',
                  middleText: 'User role error!',
                  middleTextStyle: TextStyle(color: CustomColors.kDarkGray),
                );
                break;
            }
          } else {
            Get.defaultDialog(
              title: 'Error',
              middleText: FeedbackError.kSendFailed,
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
