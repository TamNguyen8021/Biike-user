import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackButton extends StatelessWidget {
  final _feedbackController = Get.find<FeedbackController>();
  static const _STRING_EQUALS = 0;
  static const _NO_ERR_MSG = '';

  SendFeedbackButton({Key? key}) : super(key: key);

  _sendFeedback(context) async {
    // validate feedback
    String validateMsg = _feedbackController.validateFeedback();
    if (_NO_ERR_MSG.compareTo(validateMsg) != _STRING_EQUALS) {
      CommonFunctions().showErrorDialog(context: context,
          message: validateMsg.tr);
      return;
    }

    // send feedback
    var result = await _feedbackController.sendFeedback();
    if (result is bool) {
      Biike.logger.d(CustomStrings.kSendSuccess.tr);

      switch (Biike.role.value) {
        case Role.biker:
        case Role.keer:
          Get.offAllNamed(CommonRoutes.HOME);
          break;
        default:
          CommonFunctions().showErrorDialog(context: context,
              message: CustomErrorsString.kSendFailed.tr);
          break;
      }
    } else {
      CommonFunctions().showErrorDialog(context: context,
          message: result);
    }
  },

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () => _sendFeedback(context),
        child: Text(
          CustomStrings.kBtnSend.tr,
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
