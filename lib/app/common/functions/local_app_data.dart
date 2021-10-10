import 'package:bikes_user/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppData {
  late SharedPreferences _pref;

  /// Save user data to local storage
  ///
  /// Author: UyenNLP
  Future<void> saveUserInfo(FirebaseServices services) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setInt('userId', int.parse(services.firebaseAuth.currentUser!.uid));
    _pref.setString(
        'email', services.firebaseAuth.currentUser!.email.toString());
    _pref.setString('token', await services.token);
    _pref.setString('refreshToken',
        services.firebaseAuth.currentUser!.refreshToken.toString());
  }

  /// Get user Id
  ///
  /// Author: UyenNLP
  Future<int> getUserId() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getInt('userId') ?? -1;
  }

  /// Get api idToken saved when login
  ///
  /// Author: UyenNLP
  Future<String> getToken() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('token') ?? '';
  }
}
