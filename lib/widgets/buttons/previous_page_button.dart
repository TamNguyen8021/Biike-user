import 'package:flutter/material.dart';

/// The floating button for moving to previous screen
class PreviousPageButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color hoverColor;
  final Function() onPressedFunc;

  const PreviousPageButton(
      {Key? key,
      required this.onPressedFunc,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.hoverColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'previousPageButton',
      onPressed: onPressedFunc,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      hoverColor: hoverColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
        ),
      ),
    );
  }
}
