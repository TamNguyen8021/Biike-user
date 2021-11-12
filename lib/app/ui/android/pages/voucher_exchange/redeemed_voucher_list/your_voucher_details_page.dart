import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/redemption.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/widget/mark_used_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/redeemed_voucher_list/widget/show_voucher_code_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_details.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourVoucherDetailPage extends StatelessWidget {
  final data;

  YourVoucherDetailPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    Voucher voucher = Voucher.fromJson(data);
    Redemption redemption = Redemption.fromJson(data);
    voucher.setAmountOfPoint(redemption.voucherPoint);

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        onPressedFunc: () {
          Get.back();
        },
        appBar: AppBar(),
        title: Text(CustomStrings.kYourVoucherDetail.tr),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VoucherDetails(voucher: voucher),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Divider(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  ShowVoucherCodeButton(voucherCode: redemption.voucherCode),
                  MarkUsedButton(redemption: redemption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
