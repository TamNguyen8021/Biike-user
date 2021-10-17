import 'dart:async';
import 'dart:io';

import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/ui/theme/app_theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
//ignore: must_be_immutable
class Biike extends StatefulWidget {
  static final LocalAppData localAppData = LocalAppData();
  static Rx<Role> role = Role.none.obs;
  static Rx<int> userId = (-1).obs;
  static Rx<String> token = ''.obs;

  const Biike({Key? key}) : super(key: key);

  @override
  State<Biike> createState() => _BiikeState();
}

class _BiikeState extends State<Biike> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  RxMap _deviceData = {}.obs;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadDataFromLocal();
    FlutterLogs.logToFile(
        logFileName: 'Device',
        overwrite: true,
        logMessage: _deviceData.entries.toString());
  }

  /// Load token, role, and userId from local
  ///
  /// Author: TamNTT
  void loadDataFromLocal() async {
    Biike.token.value = await Biike.localAppData.token;
    Biike.userId.value = await Biike.localAppData.userId;
    String roleString = await Biike.localAppData.role;
    Biike.role.value = Biike.role.value.getRoleEnum(roleString);
  }

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _deviceData.value = _readAndroidBuildData(await deviceInfo.androidInfo);
      } else {
        _deviceData.value = _readIosDeviceInfo(await deviceInfo.iosInfo);
      }
    } on PlatformException {
      _deviceData.putIfAbsent('Error', () => 'Failed to get platform version.');
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
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
