import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/return_button.dart';
import 'package:bikes_user/app/ui/android/pages/voucher_exchange/widget/view_voucher_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/exit_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeVoucherButton extends StatelessWidget {
  const ExchangeVoucherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, //match_parent
      child: ElevatedButton(
        onPressed: () {
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
        },
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