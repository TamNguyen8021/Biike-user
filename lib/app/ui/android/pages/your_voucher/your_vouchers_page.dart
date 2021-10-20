import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/ui/android/pages/your_voucher/widget/your_voucher_list.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourVoucherPage extends StatelessWidget {
  YourVoucherPage({Key? key}) : super(key: key);

  final voucherController = Get.find<VoucherController>();
  final _redemptionController = Get.find<RedemptionController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _redemptionController.getYourVoucherList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: CustomAppBar(
              isVisible: true,
              hasShape: true,
              hasLeading: true,
              onPressedFunc: () {
                Get.back();
              },
              appBar: AppBar(),
              title: Text(CustomStrings.kYourVouchers.tr),
            ),
            body: SingleChildScrollView(
                child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 22.0, right: 22.0),
                      child: YourVoucherList(
                          listVouchers: _redemptionController.yourVoucherList)),
                ],
              ),
            )),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
