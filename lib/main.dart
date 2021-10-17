import 'dart:async';

import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/ui/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/localization/localization_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'injectable/injectable.dart';

/// Runs the application.
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await configureDependencies();

    //Initialize Logging
    await FlutterLogs.initLogs(
        logLevelsEnabled: [
          LogLevel.INFO,
          LogLevel.WARNING,
          LogLevel.ERROR,
          LogLevel.SEVERE
        ],
        timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
        directoryStructure: DirectoryStructure.SINGLE_FILE_FOR_DAY,
        logTypesEnabled: ['Device', 'Network', 'Errors', 'API'],
        logFileExtension: LogFileExtension.TXT,
        logSystemCrashes: true,
        singleLogFileSize: 5,
        logsWriteDirectoryName: "Logs",
        logsExportDirectoryName: "Logs/Exported",
        debugFileOperations: true,
        isDebuggable: true);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterLogs.logErrorTrace(
          'Biike', 'main()', details.exception.toString(), Error());
    };

    runApp(Biike());
  }, (Object error, StackTrace stack) {
    FlutterLogs.logErrorTrace('Biike', 'main()',
        error.toString() + ' - stack: ' + stack.toString(), Error());
  });
}

/// This widget is the root of your application.
class Biike extends StatelessWidget {
  static final LocalAppData localAppData = LocalAppData();
  static Rx<Role> role = Role.none.obs;
  static Rx<int> userId = (-1).obs;

  void getRoleAndUserIdFromLocal() async {
    userId.value = await localAppData.userId;
    String roleString = await localAppData.role;
    role.value = role.value.getRoleEnum(roleString);
  }

  @override
  Widget build(BuildContext context) {
    getRoleAndUserIdFromLocal();
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
