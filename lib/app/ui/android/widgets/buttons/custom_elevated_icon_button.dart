import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final Function()? onPressedFunc;
  final double? width;
  final double? height;
  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;

  const CustomElevatedIconButton(
      {Key? key,
      required this.onPressedFunc,
      this.width,
      this.height,
      this.icon,
      required this.text,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null ? height : 40,
      width: width,
      child: ElevatedButton.icon(
          onPressed: onPressedFunc,
          icon: Icon(
            icon,
            size: 25,
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
