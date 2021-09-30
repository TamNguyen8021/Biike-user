import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


/// The '002.1_welcome_1' screen
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Future<void> _navigateToLoginScreen() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Get.offAllNamed(CommonRoutes.ON_BOARD);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _navigateToLoginScreen(),
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: CustomColors.kBlue,
              body: Stack(
                children: <Widget>[
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/logo-white.png'),
                          width: 204,
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            CustomStrings.kIntroduction.tr,
                            style: TextStyle(
                                color:
                                    CustomColors.kLightGray.withOpacity(0.7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 0.6,
                      image: AssetImage('assets/images/line-map.png'),
                      fit: BoxFit.fitWidth,
                      color: CustomColors.kLightGray.withOpacity(0.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: SvgPicture.asset(
                        "assets/images/biike-two-person.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
