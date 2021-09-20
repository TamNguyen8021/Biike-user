import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class ChooseDateTimeButton extends StatelessWidget {
  final String text;
  final Function() onPressedFunc;

  const ChooseDateTimeButton(
      {Key? key, required this.text, required this.onPressedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 54.0,
      child: ElevatedButton(
        onPressed: onPressedFunc,
        style: ElevatedButton.styleFrom(
          primary: CustomColors.kLightGray,
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
