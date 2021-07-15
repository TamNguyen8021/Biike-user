import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// This widget shows the finish trip button
class FinishTripButton extends StatelessWidget {
  const FinishTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton.icon(
        onPressed: () => {},
        icon: Icon(Icons.check),
        label: Text(
          CustomStrings.finishTrip,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.blue)),
      ),
    );
  }
}
