import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearMeButton extends StatelessWidget {
  NearMeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<bool> isSelected = false.obs;

    return SizedBox(
      width: 100,
      height: 36,
      child: Obx(() => ElevatedButton(
          onPressed: () {
            isSelected.value = !isSelected.value;
          },
          child: Text(
            CustomStrings.kNearMe.tr,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          style: ElevatedButton.styleFrom(
              primary:
                  !isSelected.value ? Colors.white : CustomColors.kLightBlue,
              elevation: 0.0,
              side: BorderSide(
                  width: 2.0,
                  color: !isSelected.value
                      ? CustomColors.kLightGray
                      : CustomColors.kBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )))),
    );
  }
}
