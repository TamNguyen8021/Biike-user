import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPref extends BasePrefs {
  static Future<AppPref> instance() async {
    final _appPref = AppPref();
    await _appPref.init();
    return _appPref;
  }

  bool get initOpenApp {
    return getValueForKey(PrefKey.initOpenApp) ?? false;
  }

  void setInitOpenApp(bool isInitOpenApp) {
    setValueForKey(PrefKey.initOpenApp, isInitOpenApp);
  }

  String get token {
    return getValueForKey(PrefKey.token) ?? '';
  }

  void setToken(String token) {
    setValueForKey(PrefKey.token, token);
  }

  String get refreshToken {
    return getValueForKey(PrefKey.refreshToken) ?? '';
  }

  void setRefreshToken(String token) {
    setValueForKey(PrefKey.refreshToken, token);
  }

  logout() {
    setToken('');
    setRefreshToken('');
  }
}

class PrefKey {
  static const String initOpenApp = 'INIT_OPEN_APP';
  static const String token = 'TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
}

class BasePrefs {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  T getValueForKey<T>(String key) {
    return prefs.get(key) as T;
  }

  Future<bool> setValueForKey(String key, dynamic value) {
    if (value is int) {
      return prefs.setInt(key, value);
    }

    if (value is String) {
      return prefs.setString(key, value);
    }

    if (value is List<String>) {
      return prefs.setStringList(key, value);
    }

    if (value is bool) {
      return prefs.setBool(key, value);
    }

    if (value is double) {
      return prefs.setDouble(key, value);
    }

    final jsonValue = json.encode(value);
    return prefs.setString(key, jsonValue);
  }
}
