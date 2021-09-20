import 'dart:ui';
import 'package:bikes_user/app/localization/en_US/en_us_translations.dart';
import 'package:bikes_user/app/localization/vi_VN/vi_vn_translations.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {

  static final locale = _getLocaleFromDevice();
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'vi_VN': vi,
  };

  static Locale? _getLocaleFromDevice() {
    return Get.deviceLocale;
  }
}