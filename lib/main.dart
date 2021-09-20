import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/localization/localization_service.dart';
import 'package:bikes_user/app/routes/app_pages.dart';
import 'package:bikes_user/app/routes/app_routes.dart';
import 'package:bikes_user/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Runs the application.
void main() {
  runApp(Biike());
}

/// This widget is the root of your application.
class Biike extends StatelessWidget {
  static Rx<Role> role = Role.none.obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Remove debug banner when running app.
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      initialRoute: CommonRoutes.OPEN,
      getPages: AppPages.pages,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
