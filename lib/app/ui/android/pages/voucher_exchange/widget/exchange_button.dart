import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/return_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeVoucherButton extends StatelessWidget {
  final _redemptionController = Get.find<RedemptionController>();
  final _walletController = Get.find<WalletController>();

  final Voucher voucher;
  ExchangeVoucherButton({Key? key, required this.voucher}) : super(key: key);

  _exchangeVoucher(BuildContext context) async {
    if (_walletController.isNotEnoughPoint(voucherPoint: voucher.amountOfPoint!)) {
      new CommonFunctions().showErrorDialog(
          context: context,
          message: CustomErrorsString.kNotEnoughPoint.tr);
      return;
    }

    dynamic result = await _redemptionController.exchangeVoucher(voucher.voucherId);
    if (result is String) {
      new CommonFunctions().showErrorDialog(
          context: context,
          message: result == ''
              ? CustomErrorsString.kExchangeFailed.tr
              : result);
    } else {
      _walletController.updateWalletPoint();
      int redemptionId = CommonFunctions.
          getIdFromUrl(url: result.headers['location'] as String);

      Get.defaultDialog(
        title: CustomStrings.kExchangeVoucherSuccess.tr,
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(
            image: AssetImage('assets/images/coupon.png'),
            width: 100.sp,
            // height: 70,
          ),
        ),
        actions: [
          Column(
            children: [
              ViewVoucherButton(redemptionId: redemptionId),
              ReturnToVoucherPageButton(),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, //match_parent
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
