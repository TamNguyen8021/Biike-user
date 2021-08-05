import 'package:bikes_user/utils/custom_colors.dart';
import 'package:bikes_user/utils/custom_strings.dart';
import 'package:bikes_user/widgets/buttons/log_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login_Page  extends StatelessWidget {
  const Login_Page ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBlue,
      // appBar: AppBar(

      //   title: Text(
      //     CustomStrings.kLogoApp,
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //               fontSize: 50,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //               wordSpacing: 2.0,
      //             )
      //     ),

      // ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Text(
                CustomStrings.kLogoApp,
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    wordSpacing: 4.0,
                  
                  )
              ),
              new Text(
                CustomStrings.kIntroQuote,
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    wordSpacing: 1.0,
                  )
                ),
                // Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[LoginButton()]),
                //       ),
                LoginButton(),
                new Text(
                CustomStrings.kConfirmTerm,
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    wordSpacing: 1.0,
                  )
                ),
                new Text(
                CustomStrings.kTerm,
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: CustomColors.kRed,
                    wordSpacing: 1.0,
                  )
                ),
              Container(
              child: SvgPicture.asset("assets/images/biike-two-person.svg", fit: BoxFit.fill ),
              
            )
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //             image: AssetImage("assets/images/line-map.png"),
            //             fit: BoxFit.cover
            //             )
            //   ),
            // )
          
          ],
          
        )
        )
    );
  }
}