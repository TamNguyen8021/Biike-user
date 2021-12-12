import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CreateTripButton extends StatelessWidget {
  const CreateTripButton({
    Key? key,
    required this.createTrip,
  }) : super(key: key);
  final Function() createTrip;
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime lowestBoundLimitTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day, 5);
    DateTime highestBoundLimitTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day, 21);

    return FloatingActionButton(
      elevation: 1.0,
      onPressed: currentTime.isBefore(lowestBoundLimitTime) &&
              currentTime.isAfter(highestBoundLimitTime)
          ? null
          : createTrip,
      backgroundColor: currentTime.isBefore(lowestBoundLimitTime) &&
              currentTime.isAfter(highestBoundLimitTime)
          ? CustomColors.kDarkGray
          : CustomColors.kOrange,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
