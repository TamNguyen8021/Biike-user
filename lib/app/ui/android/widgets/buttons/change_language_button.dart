import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLg = Get.locale ?? Locale('vi', 'VN');

    return Container(
      margin: const EdgeInsets.only(top: 15.0, bottom: 22.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              if (currentLg == Locale('vi', 'VN')) {
                Get.updateLocale(Locale('en', 'US'));
              } else {
                Get.updateLocale(Locale('vi', 'VN'));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  CustomStrings.kLanguage.tr,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        CustomStrings.kCurrentLanguage.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(CustomColors.kLightGray),
                elevation: MaterialStateProperty.all<double>(2.0)),
          ),
        ),
      ),
    );
  }
}
