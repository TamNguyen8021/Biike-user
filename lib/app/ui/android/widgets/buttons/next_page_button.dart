import 'package:flutter/material.dart';

/// The floating button for moving to next screen
class NextPageButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color hoverColor;
  final Function() onPressedFunc;
  final bool isLoading;
  const NextPageButton({
    Key? key,
    required this.onPressedFunc,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hoverColor,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'nextPageButton',
      onPressed: isLoading ? null : onPressedFunc,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      hoverColor: hoverColor,
      child: _content,
    );
  }

  Widget get _content => isLoading
      ? SizedBox.fromSize(
          size: Size(25, 25), child: CircularProgressIndicator())
      : Icon(
          Icons.arrow_forward_ios,
          size: 25,
        );
}
