import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyPointButton extends StatelessWidget {
  const BuyPointButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.sp,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(CommonRoutes.TOP_UP_POINT),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: CustomColors.kBlue,
            ),
            Text(
              CustomStrings.kBuyPoint.tr,
              style: TextStyle(
                  color: CustomColors.kBlue,
                  fontSize: 10.sp),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0.0,
            side: BorderSide(width: 1.0, color: CustomColors.kBlue),
        ),
      ),
    );
  }
}