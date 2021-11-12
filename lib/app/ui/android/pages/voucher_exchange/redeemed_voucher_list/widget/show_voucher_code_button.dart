import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowVoucherCodeButton extends StatelessWidget {
  final voucherCode;

  ShowVoucherCodeButton({Key? key, required this.voucherCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isSelected = false.obs;
    return Obx(() => Expanded(
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () => isSelected.value = !isSelected.value,
              child: isSelected.value
                  ? SelectableText(
                      voucherCode,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      CustomStrings.kShowVoucherCode.tr,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
              style: ElevatedButton.styleFrom(
                  primary: isSelected.value
                      ? CustomColors.kLightGray
                      : CustomColors.kBlue,
                  elevation: 0.0),
            ),
          ),
        ));
  }
}
