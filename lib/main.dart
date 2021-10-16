import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/ui/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/localization/localization_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'injectable/injectable.dart';

/// Runs the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(Biike());
}

/// This widget is the root of your application.
class Biike extends StatelessWidget {
  static final LocalAppData localAppData = LocalAppData();
  static Rx<Role> role = Role.none.obs;

  void getRoleFromLocal() async {
    String roleString = await localAppData.role;
    role.value = role.value.getRoleEnum(roleString);
  }

  @override
  Widget build(BuildContext context) {
    getRoleFromLocal();
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: () => GetMaterialApp(
        // Remove debug banner when running app.
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        initialRoute: CommonRoutes.OPEN,
        getPages: AppPages.pages,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
      ),
    );
  }
}
