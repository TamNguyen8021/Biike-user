import 'package:bikes_user/app/controllers/redemption_controller.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewVoucherButton extends StatelessWidget {
  final int redemptionId;
  ViewVoucherButton({Key? key, required this.redemptionId}) : super(key: key);

  final _redemptionController = Get.find<RedemptionController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.sp,
      child: ElevatedButton(
        onPressed: () async {
          dynamic data = await _redemptionController
              .getRedemptionDetailByRedemptionId(redemptionId);

          Get.offAndToNamed(CommonRoutes.YOUR_VOUCHER_DETAIL, arguments: data);
        },
        child: Text(
          CustomStrings.kViewAVoucher.tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        style: ElevatedButton.styleFrom(
            primary: CustomColors.kBlue, elevation: 0.0),
      ),
    );
  }
}
