import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/data/models/redemption.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MarkUsedButton extends StatelessWidget {
  final _redemptionController = Get.find<RedemptionController>();
  Redemption redemption;

  MarkUsedButton({Key? key, required this.redemption}) : super(key: key);

  _editUsage(context, redemptionId) {
    dynamic result = _redemptionController.editVoucherUsage(redemptionId);

    if (result is Redemption) {
      redemption = result;
    } else {
      CommonFunctions().showErrorDialog(context: context, message: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
            child: SizedBox(
          child: ElevatedButton(
            onPressed: () => _editUsage(context, redemption.redemptionId),
            child: redemption.isUsed
                ? Text(
                    CustomStrings.kMarkAsUnused.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                : Text(
                    CustomStrings.kMarkAsUsed.tr,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: CustomColors.kDarkGray,
                        fontWeight: FontWeight.bold),
                  ),
            style: ElevatedButton.styleFrom(
                primary: CustomColors.kBlue, elevation: 0.0),
          ),
        )));
  }
}
