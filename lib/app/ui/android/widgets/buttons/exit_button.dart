import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.offAllNamed(CommonRoutes.HOME),
        child: Text(
          CustomStrings.kBtnExit.tr,
          style: TextStyle(
              color: CustomColors.kDarkGray,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0.0),
      ),
    );
  }
}
