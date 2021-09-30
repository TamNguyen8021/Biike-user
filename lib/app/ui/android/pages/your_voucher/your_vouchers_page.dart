import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/ui/android/pages/your_voucher/widget/your_voucher_list.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourVoucherPage extends StatelessWidget {
  YourVoucherPage({Key? key}) : super(key: key);

  final voucherController = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        hasLeading: true,
        appBar: AppBar(),
        title: Text(CustomStrings.kYourVouchers.tr),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.only(top: 16.0, left: 22.0, right: 22.0),
                  child:
                  Obx(() =>
                      YourVoucherList(listVouchers: voucherController.getVoucherList()),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
