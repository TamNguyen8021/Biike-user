import 'package:bikes_user/utils/custom_colors.dart';
// import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// The open screen
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo-white.png"),
            fit: BoxFit.cover,
            ),
        ),
        child: null
        )
      );
  }
}
