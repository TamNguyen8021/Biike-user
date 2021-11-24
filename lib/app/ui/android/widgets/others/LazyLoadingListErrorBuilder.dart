import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/custom_text_button.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LazyLoadingListErrorBuilder extends StatelessWidget {
  final Function() onPressed;

  const LazyLoadingListErrorBuilder({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            CustomErrorsString.kDevelopError.tr,
            textAlign: TextAlign.center,
          ),
        ),
        CustomTextButton(
            backgroundColor: CustomColors.kBlue,
            foregroundColor: Colors.white,
            text: CustomErrorsString.kTryAgain.tr,
            onPressedFunc: onPressed,
            hasBorder: false),
      ],
    );
  }
}
