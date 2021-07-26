import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          // Navigator.pop(context);
        },
        child: Text(
          CustomStrings.btnExit,
          style: TextStyle(
              color: CustomColors.kDarkGray, fontWeight: FontWeight.bold, fontSize: 12),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }
}