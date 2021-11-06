import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/data/models/redemption.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/voucher_details.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 16.0),
                    child: Text(CustomStrings.kYourCode.tr,
                        style: Theme.of(context).textTheme.bodyText2!),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        color: CustomColors.kLightGray,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SelectableText(
                              redemption.voucherCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: CustomColors.kDarkGray,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
