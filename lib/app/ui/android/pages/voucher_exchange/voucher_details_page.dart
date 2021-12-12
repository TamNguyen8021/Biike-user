import 'package:back_pressed/back_pressed.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/voucher_list/widget/exchange_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_details.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoucherDetailPage extends StatelessWidget {
  final voucherController = Get.find<VoucherController>();

  VoucherDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Voucher voucher = Get.arguments;

    return OnBackPressed(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            hasShape: true,
            hasLeading: true,
            onPressedFunc: () {
              Get.back();
            },
            appBar: AppBar(),
            title: Text(CustomStrings.kVoucherDetail.tr),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VoucherDetails(voucher: voucher),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ExchangeVoucherButton(voucher: voucher),
                ),
              ],
            ),
          ),
        ),
        perform: () => Get.back());
  }
}
