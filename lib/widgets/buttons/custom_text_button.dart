import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double? width;
  final String text;
  final Function() onPressedFunc;

  const CustomTextButton(
      {Key? key,
      required this.backgroundColor,
      required this.foregroundColor,
      this.width,
      required this.text,
      required this.onPressedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 20.0)),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        ),
        onPressed: onPressedFunc,
        child: Text(text),
      ),
    );
  }
}
