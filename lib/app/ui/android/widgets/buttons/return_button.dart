import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text(
          CustomStrings.kBtnReturn.tr,
          style: TextStyle(
              color: CustomColors.kDarkGray,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.kLightGray),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}
