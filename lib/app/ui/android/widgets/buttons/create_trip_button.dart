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
    return FloatingActionButton(
      elevation: 1.0,
      onPressed: createTrip,
      backgroundColor: CustomColors.kOrange,
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}
