import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double? width;
  final double? elevation;
  final String text;
  final Function() onPressedFunc;

  const CustomTextButton(
      {Key? key,
      required this.backgroundColor,
      required this.foregroundColor,
      this.width,
      this.elevation,
      required this.text,
      required this.onPressedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          backgroundColor: backgroundColor,
          primary: foregroundColor,
          elevation: elevation,
        ),
        onPressed: onPressedFunc,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
