import 'package:bikes_user/utils/custom_colors.dart';
import 'package:flutter/material.dart';

/// The open screen
class OpenPage extends StatelessWidget {
  const OpenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Container(
        child: Center(
            child: Image(
          image: AssetImage('assets/images/logo-app-blue.jpg'),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
