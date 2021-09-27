import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SOSNumberDescription extends StatelessWidget {
  const SOSNumberDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 10.0,
                  color: CustomColors.kDarkBlue,
                ),
                children: [
                  TextSpan(
                      text: CustomStrings.kSOSNumberFirstDescription.tr
                  ),
                  TextSpan(
                      text: CustomStrings.kSOSNumber.tr,
                      style: TextStyle( fontWeight: FontWeight.bold )
                  ),
                  TextSpan(
                    text: CustomStrings.kSOSNumberSecondDescription.tr,
                  ),
                  TextSpan(
                      text: CustomStrings.kNeedSOS.tr,
                      style: TextStyle( fontWeight: FontWeight.bold )
                  ),
                  TextSpan(
                    text: CustomStrings.kSOSNumberThirdDescription.tr,
                  ),
                ]
            )
        )
      ],
    );
  }
}
