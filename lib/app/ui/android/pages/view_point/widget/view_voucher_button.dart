import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewVoucherButton extends StatelessWidget {
  const ViewVoucherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.sp,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(CommonRoutes.EXCHANGE_VOUCHER),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              CustomStrings.kExchangeVoucher.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(primary: CustomColors.kBlue, elevation: 0.0),
      ),
    );
  }
}