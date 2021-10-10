import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewVoucherButton extends StatelessWidget {
  const ViewVoucherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.sp,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(CommonRoutes.YOUR_VOUCHERS),
        child: Text(
          CustomStrings.kViewAVoucher.tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        style: ElevatedButton.styleFrom(primary: CustomColors.kBlue, elevation: 0.0),
      ),
    );
  }
}
