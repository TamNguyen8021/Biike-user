import 'package:bikes_user/utils/custom_colors.dart';
// import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The welcoe screen
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: SvgPicture.asset("assets/images/biike-two-person.svg",fit: BoxFit.fill ),
              
            )
          ],
        )
        )
      );
  }
}
