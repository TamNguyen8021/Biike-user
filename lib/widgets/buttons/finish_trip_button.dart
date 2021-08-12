import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// This widget shows the finish trip button
class FinishTripButton extends StatefulWidget {
  const FinishTripButton({Key? key}) : super(key: key);

  @override
  _FinishTripButtonState createState() => _FinishTripButtonState();
}

class _FinishTripButtonState extends State<FinishTripButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 152,
      child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          icon: Icon(Icons.done_all, size: 25),
          label: Text(
            _isPressed
                ? CustomStrings.kFinishTrip
                : CustomStrings.kConfirmFinishTrip,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all<double>(0.0),
              backgroundColor: _isPressed
                  ? MaterialStateProperty.all<Color>(CustomColors.kDarkGray)
                  : MaterialStateProperty.all<Color>(CustomColors.kBlue))),
    );
  }
}
