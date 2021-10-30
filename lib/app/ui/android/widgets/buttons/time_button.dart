import 'package:bikes_user/app/controllers/book_trip_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeButton extends StatelessWidget {
  final String time;
  final _bookTripController = Get.find<BookTripController>();

  TimeButton({Key? key, required this.time}) : super(key: key);

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
      onTap: () => _bookTripController.setTimeFromTag(time),
    );
  }
}
