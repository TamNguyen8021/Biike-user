import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The '006-login' screen
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.kBlue,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/logo-white.png'),
                    width: 204,
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(CustomStrings.kIntroQuote,
                        style: TextStyle(
                          color: CustomColors.kLightGray.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        CustomStrings.kLoginButton,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(5.0),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(
                                  left: 60.0,
                                  right: 30.0,
                                  top: 20.0,
                                  bottom: 20.0))),
                    ),
                  ),
                  // LoginButton(),
                  Text(CustomStrings.kConfirmTerm,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      )),
                  Text(
                    CustomStrings.kTerm,
                    style: TextStyle(
                      fontSize: 10,
                      color: CustomColors.kOrange.withOpacity(0.9),
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
                color: CustomColors.kLightGray.withOpacity(0.3),
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
  }
}
