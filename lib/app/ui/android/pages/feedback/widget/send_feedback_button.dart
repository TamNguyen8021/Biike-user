import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/controllers/feedbacks_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
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
  final _walletController = Get.find<WalletController>();

  final tripId;
  static const _STRING_EQUALS = 0;
  static const _NO_ERR_MSG = '';

  SendFeedbackButton({Key? key, required this.tripId}) : super(key: key);

  _sendFeedback(context) async {
    // validate feedback
    String validateMsg = await _feedbackController.validateFeedback();

    if (_NO_ERR_MSG.compareTo(validateMsg) != _STRING_EQUALS) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: validateMsg)
          .show();
    }
    CustomDialog customDialog = CustomDialog(context: context);
    customDialog.loadingDialog.show();

    // send feedback
    var result = await _feedbackController.sendFeedback(tripId);

    customDialog.loadingDialog.dismiss();

    if (result is bool) {
      await _walletController.updateWalletPoint();

      switch (Biike.role.value) {
        case Role.biker:
        case Role.keer:
          Get.offAllNamed(CommonRoutes.HOME);
          break;
        default:
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  headerAnimationLoop: false,
                  desc: CustomErrorsString.kSendFailed.tr)
              .show();
          break;
      }
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: result)
          .show();
    }
  }

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
