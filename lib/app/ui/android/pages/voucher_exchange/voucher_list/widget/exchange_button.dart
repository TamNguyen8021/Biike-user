import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_dialog.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/widget/return_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeVoucherButton extends StatelessWidget {
  final _redemptionController = Get.find<RedemptionController>();
  final _walletController = Get.find<WalletController>();

  final Voucher voucher;

  ExchangeVoucherButton({Key? key, required this.voucher}) : super(key: key);

  _exchangeVoucher(BuildContext context) async {
    CustomDialog customDialog = CustomDialog(context: context);
    customDialog.loadingDialog.show();

    if (_walletController.isNotEnoughPoint(
        voucherPoint: voucher.amountOfPoint!)) {
      customDialog.loadingDialog.dismiss();
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              headerAnimationLoop: false,
              desc: CustomErrorsString.kNotEnoughPoint.tr)
          .show();
      return;
    }

    try {
      dynamic result =
      await _redemptionController.exchangeVoucher(voucher.voucherId);
      customDialog.loadingDialog.dismiss();

      if (result is String) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            headerAnimationLoop: false,
            desc:
            result == '' ? CustomErrorsString.kExchangeFailed.tr : result)
            .show();
      } else {
        _walletController.updateWalletPoint();
        int redemptionId = CommonFunctions.getIdFromUrl(
            url: result.headers['location'] as String);

        _successDialog(redemptionId);
      }
    } catch (e) {
      CommonFunctions.catchExceptionError(e);
      customDialog.loadingDialog.dismiss();
    }

  }

  _successDialog(redemptionId) => Get.defaultDialog(
        title: CustomStrings.kExchangeVoucherSuccess.tr,
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(
            image: AssetImage('assets/images/coupon.png'),
            width: 100,
          ),
        ),
        actions: <Widget>[
          Column(
            children: <Widget>[
              ViewVoucherButton(redemptionId: redemptionId),
              ReturnToVoucherPageButton(),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _exchangeVoucher(context),
        child: Text(
          CustomStrings.kExchangeNow.tr,
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
