import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextButton(
        onPressed: () {
          // Navigator.pop(context);
        },
        child: Text(
          CustomStrings.returnButton,
          style: TextStyle(
              color: CustomColors.darkGray, fontWeight: FontWeight.bold, fontSize: 12),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}