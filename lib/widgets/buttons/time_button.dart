import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String time;
  const TimeButton({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: CustomColors.kLightBlue,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            time,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: CustomColors.kBlue),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
