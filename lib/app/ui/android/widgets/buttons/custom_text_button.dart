import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double? width;
  final double? elevation;
  final String text;
  final Function() onPressedFunc;
  final bool hasBorder;

  const CustomTextButton(
      {Key? key,
      required this.backgroundColor,
      required this.foregroundColor,
      this.width,
      this.elevation,
      required this.text,
      required this.onPressedFunc,
      required this.hasBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            backgroundColor: backgroundColor,
            primary: foregroundColor,
            elevation: elevation,
            side: hasBorder
                ? BorderSide(color: CustomColors.kBlue)
                : BorderSide.none),
        onPressed: onPressedFunc,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
