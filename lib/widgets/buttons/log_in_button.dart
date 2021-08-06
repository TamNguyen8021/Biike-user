import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {},
        child: Text(

          CustomStrings.kLoginButton,
          style: TextStyle(
            backgroundColor: Colors.white,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              letterSpacing: 1.0
              ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(CustomColors.kBlue),
            elevation: MaterialStateProperty.all<double>(0.0)),
      ),
    );
  }  
}