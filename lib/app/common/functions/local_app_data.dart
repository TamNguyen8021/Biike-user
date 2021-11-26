import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/app/data/models/login.dart';
import 'package:bikes_user/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppData {
  late SharedPreferences _pref;

  /// Save user data to local storage
  ///
  /// Author: UyenNLP
  Future<void> saveUserInfo(LoginData data) async {
    _pref = await SharedPreferences.getInstance()
      ..setString('token', data.idToken)
      ..setString('refreshToken', data.refreshToken)
      ..setInt('userId', int.tryParse(data.userId) ?? -1)
      ..setString('email', data.email)
      ..setString('role', 'Role.none')
      ..setString('pathshareUserToken', '')
      ..setString('pathshareUserIdentifier', '');
  }

  /// Load role, and userId from local
  ///
  /// Author: TamNTT
  Future<void> loadDataFromLocal() async {
    Biike.userId.value = await Biike.localAppData.userId;
    String roleString = await Biike.localAppData.role;
    Biike.role.value = Biike.role.value.getRoleEnum(roleString);
    Biike.pathshareUserToken = await Biike.localAppData.pathshareUserToken;
    Biike.pathshareUserIdentifier =
        await Biike.localAppData.pathshareUserIdentifier;
  }

  /// Author: van
  Future<String> get token async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('token') ?? '';
  }

  /// Get user's id
  ///
  /// Author: UyenNLP
  Future<int> get userId async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getInt('userId') ?? -1;
  }

  /// Get role
  ///
  /// Author: TamNTT
  Future<String> get role async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('role') ?? 'Role.none';
  }

  /// Save current role to local
  ///
  /// Author: TamNTT
  Future<void> saveRole(Role role) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString('role', role.toString());
  }

  /// Get Pathshare user token
  ///
  /// Author: TamNTT
  Future<String> get pathshareUserToken async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('pathshareUserToken') ?? '';
  }

  /// Save Pathshare user token to local
  ///
  /// Author: TamNTT
  Future<void> savePathshareUserToken(String token) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString('pathshareUserToken', token);
  }

  /// Get Pathshare user identifier
  ///
  /// Author: TamNTT
  Future<String> get pathshareUserIdentifier async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('pathshareUserIdentifier') ?? '';
  }

  /// Save Pathshare user identifier to local
  ///
  /// Author: TamNTT
  Future<void> savePathshareUserIdentifier(String identifier) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString('pathshareUserIdentifier', identifier);
  }
}
