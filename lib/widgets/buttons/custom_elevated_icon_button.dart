import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final Function() onPressedFunc;
  final double? width;
  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;

  const CustomElevatedIconButton(
      {Key? key,
      required this.onPressedFunc,
      this.width,
      this.icon,
      required this.text,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: width,
      child: ElevatedButton.icon(
          onPressed: onPressedFunc,
          icon: Icon(
            icon,
            size: 22,
          ),
          label: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: foregroundColor),
          ),
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            primary:
                backgroundColor == CustomColors.kBlue ? null : backgroundColor,
            onPrimary: foregroundColor == Colors.white ? null : foregroundColor,
          )),
    );
  }
}
