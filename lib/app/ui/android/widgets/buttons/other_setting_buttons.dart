import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherSettingButtons extends StatelessWidget {
  const OtherSettingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 22.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                    CommonFunctions.openLink(
                        url: 'https://www.facebook.com/biikeapp',
                        context: context)
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        CustomStrings.kFollowOnFacebook.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.kLightGray),
                      elevation: MaterialStateProperty.all<double>(2.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                    CommonFunctions.openLink(
                        url: 'https://biike.in', context: context)
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        CustomStrings.kWebsite.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        'www.biike.in',
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.kLightGray),
                      elevation: MaterialStateProperty.all<double>(2.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                    CommonFunctions.openLink(
                        url: 'https://www.biike.in/terms.html',
                        context: context)
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        CustomStrings.kTermOfUse.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.kLightGray),
                      elevation: MaterialStateProperty.all<double>(2.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => {
                    CommonFunctions.openLink(
                        url: 'https://www.biike.in/privacy.html',
                        context: context)
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        CustomStrings.kPrivacyPolicy.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.kLightGray),
                      elevation: MaterialStateProperty.all<double>(2.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
