import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/ui/android/widgets/appbars/custom_appbar.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/account_security_buttons.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/change_language_button.dart';
import 'package:bikes_user/app/ui/android/widgets/buttons/other_setting_buttons.dart';
import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The app setting screen
class AppSettingPage extends StatelessWidget {
  const AppSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        isVisible: true,
        hasShape: true,
        appBar: AppBar(),
        hasLeading: true,
        title: Text(
          CustomStrings.kAppSetting.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(22.0),
            child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      CustomStrings.kAccountSecurity.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  AccountSecurityButtons(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      CustomStrings.kLanguage.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  ChangeLanguageButton(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      CustomStrings.kOther.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  OtherSettingButtons(),
                  Container(
                    margin: const EdgeInsets.only(top: 22.0),
                    child: Text(
                      CustomStrings.kDevelopBy.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      CustomStrings.kDevelopAt.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  )
                ]
            )
        )
      )
    );
  }
}
