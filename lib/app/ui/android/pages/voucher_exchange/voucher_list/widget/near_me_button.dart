import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearMeButton extends StatelessWidget {
  final _voucherController = Get.find<VoucherController>();

  NearMeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _voucherController.isNearMeSelected.value = false;

    return SizedBox(
      width: 100,
      height: 36,
      child: Obx(() => ElevatedButton(
          onPressed: () async {
            var result = await _voucherController.updateNearMe();
            if (result is String) {
              CommonFunctions()
                  .showErrorDialog(context: context, message: result);
            }
          },
          child: Text(
            CustomStrings.kNearMe.tr,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          style: ElevatedButton.styleFrom(
              primary: !_voucherController.isNearMeSelected.value
                  ? Colors.white
                  : CustomColors.kLightBlue,
              elevation: 0.0,
              side: BorderSide(
                  width: 2.0,
                  color: !_voucherController.isNearMeSelected.value
                      ? CustomColors.kLightGray
                      : CustomColors.kBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )))),
    );
  }
}
