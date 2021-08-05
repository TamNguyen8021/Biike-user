import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String time;
  const TimeButton({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: CustomColors.kLightBlue,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 8, right: 8),
          primary: CustomColors.kBlue,
          textStyle: const TextStyle(fontSize: 12),
        ),
        onPressed: () {},
        child: Text(
          "$time",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
