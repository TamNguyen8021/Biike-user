import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/controllers/voucher_controller.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/return_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/exit_button.dart';
import 'package:bikes_user/app/ui/android/widgets/others/loading.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeVoucherButton extends StatelessWidget {
  final _redemptionController = Get.find<RedemptionController>();

  final int voucherId;
  ExchangeVoucherButton({Key? key, required this.voucherId}) : super(key: key);

  _x() async {
    FutureBuilder(
      future: _redemptionController.exchangeVoucher(voucherId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Loading();
        } else {
          return Loading();
        }
      }
    );
  }

  _exchangeVoucher() async {
    bool result = await _redemptionController.exchangeVoucher(voucherId);
    if (result) {
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
              ViewVoucherButton(),
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
        onPressed: () => _exchangeVoucher(),
        child: Text(
          CustomStrings.kExchangeNow.tr,
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 35.0)
            ),
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)
        ),
      ),
    );
  }
}