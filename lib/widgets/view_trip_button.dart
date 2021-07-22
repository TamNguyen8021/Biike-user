import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class ViewTripButton extends StatelessWidget {
  const ViewTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextButton(
        onPressed: () => {},
        child: Text(
          CustomStrings.viewTrip,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        style: ButtonStyle(
            //padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.blue),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}