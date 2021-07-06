import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';

/// The open screen
class OpenPage extends StatelessWidget {
  const OpenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.blue,
      body: Container(
        child: Center(
            child: Text(
          CustomStrings.appName,
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontStyle: FontStyle.italic),
        )),
      ),
    );
  }
}
