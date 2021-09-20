import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The '001.1_open' screen
class OpenPage extends StatelessWidget {
  const OpenPage({Key? key}) : super(key: key);

  Future<String> _navigateToWelcomeScreen() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Get.offAllNamed(CommonRoutes.WELCOME);
    });
    return CommonRoutes.WELCOME;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _navigateToWelcomeScreen(),
        builder: (context, snapshot) {
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
        });
  }
}