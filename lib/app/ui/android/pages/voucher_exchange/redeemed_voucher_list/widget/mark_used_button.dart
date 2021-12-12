import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/data/models/redemption.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkUsedButton extends StatelessWidget {
  final _redemptionController = Get.find<RedemptionController>();
  final Redemption redemption;
  final bool isOutOfDate;

  MarkUsedButton({Key? key, required this.redemption, this.isOutOfDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> status = redemption.isUsed.obs;

    return Obx(() => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              if (isOutOfDate) return;
              CustomDialog customDialog = CustomDialog(context: context);
              customDialog.loadingDialog.show();

              dynamic result = await _redemptionController
                  .editVoucherUsage(redemption.redemptionId);
              customDialog.loadingDialog.dismiss();
              if (result is String) {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        headerAnimationLoop: false,
                        desc: result)
                    .show();
              } else {
                // redemption = Redemption.fromJson(result);
                status.value = !status.value;
              }
            },
            child: isOutOfDate
                ? Text(
                    CustomErrorsString.kOutOfDate.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                : status.value
                    ? Text(
                        CustomStrings.kMarkAsUnused.tr,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        CustomStrings.kMarkAsUsed.tr,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
            style: ElevatedButton.styleFrom(
                primary:
                    status.value ? CustomColors.kLightGray : CustomColors.kBlue,
                elevation: 0.0),
          ),
        ));
  }
}
