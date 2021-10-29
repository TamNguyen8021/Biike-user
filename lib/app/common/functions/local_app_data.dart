import 'package:bikes_user/app/data/enums/role_enum.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppData {
  late SharedPreferences _pref;

  /// Save user data to local storage
  ///
  /// Author: UyenNLP
  Future<void> saveUserInfo(FirebaseServices services) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setInt(
        'userId', int.tryParse(services.firebaseAuth.currentUser!.uid) ?? -1);
    _pref.setString(
        'email', services.firebaseAuth.currentUser!.email.toString());
    // _pref.setString('token', await services.token);
    // _pref.setString('refreshToken',
    //     services.firebaseAuth.currentUser!.refreshToken.toString());
    _pref.setString('role', 'Role.none');
  }

  /// Load token, role, and userId from local
  ///
  /// Author: TamNTT
  Future<void> loadDataFromLocal() async {
    // Biike.token.value = await Biike.localAppData.token;
    Biike.userId.value = await Biike.localAppData.userId;
    String roleString = await Biike.localAppData.role;
    Biike.role.value = Biike.role.value.getRoleEnum(roleString);
  }

  /// Get user's id
  ///
  /// Author: UyenNLP
  Future<int> get userId async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getInt('userId') ?? -1;
  }

  /// Get idToken saved when login
  ///
  /// Author: UyenNLP
  // Future<String> get token async {
  //   _pref = await SharedPreferences.getInstance();
  //   return _pref.getString('token') ?? '';
  // }

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
}
