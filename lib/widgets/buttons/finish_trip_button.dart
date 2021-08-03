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
          icon: Icon(Icons.check, size: 30),
          label: Text(
            CustomStrings.kFinishTrip,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: Theme.of(context)
              .elevatedButtonTheme
              .style!
              .copyWith(elevation: MaterialStateProperty.all<double>(0.0))),
    );
  }
}
