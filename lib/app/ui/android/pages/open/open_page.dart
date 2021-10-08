import 'package:bikes_user/app/controllers/open_page_controller.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

/// The '001.1_open' screen
class OpenPage extends StatefulWidget {
  const OpenPage({Key? key}) : super(key: key);

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  void initState() {
    OpenPageController.to.navigateToWelcomeScreen();
    super.initState();
  }

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
