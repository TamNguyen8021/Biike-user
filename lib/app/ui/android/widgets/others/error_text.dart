import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;
  final double marginTop;

  const ErrorText({Key? key, required this.errorText, required this.marginTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CustomColors.kLightBlue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        errorText,
        style: TextStyle(
          color: CustomColors.kRed,
        ),
      ),
    );
  }
}
