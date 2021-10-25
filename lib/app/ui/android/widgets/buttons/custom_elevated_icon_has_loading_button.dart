import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedIconHasLoadingButton extends StatelessWidget {
  final Function()? onPressedFunc;
  final double? width;
  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final bool isLoading;

  const CustomElevatedIconHasLoadingButton(
      {
        Key? key,
        required this.onPressedFunc,
        this.width,
        this.icon,
        required this.text,
        required this.backgroundColor,
        required this.foregroundColor,
        required this.elevation,
        this.isLoading = false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: width,
      child: ElevatedButton.icon(
          onPressed: isLoading ? null : onPressedFunc,
          icon: _content,
          label: Text(
            text,
            style: MediaQuery.of(context).size.width >= 400
                ? Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: foregroundColor)
                : Theme.of(context)
                .textTheme
                .subtitle1!
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

  Widget get _content => isLoading
      ? SizedBox.fromSize( size: Size(22, 22), child: CircularProgressIndicator() )
      : Icon( icon, size: 22 );
}
