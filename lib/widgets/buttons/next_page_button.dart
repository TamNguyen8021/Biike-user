import 'package:flutter/material.dart';

/// The floating button for moving to next screen
class NextPageButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color hoverColor;
  final Function() onPressedFunc;

  const NextPageButton(
      {Key? key,
      required this.onPressedFunc,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.hoverColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'nextPageButton',
      onPressed: onPressedFunc,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      hoverColor: hoverColor,
      child: Icon(
        Icons.arrow_forward_ios,
        size: 25,
      ),
    );
  }
}
