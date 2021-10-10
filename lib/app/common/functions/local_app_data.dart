import 'package:bikes_user/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppData {
  late SharedPreferences _pref;

  Future<void> saveUserInfo(FirebaseServices services) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setInt('userId', int.parse(services.uid));
    _pref.setString('email', services.user!.email.toString());
    _pref.setString('token', await services.token);
    _pref.setString('refreshToken', services.user!.refreshToken.toString());
  }

  Future<int> getUserId() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getInt('userId') ?? -1;
  }

  Future<String> getToken() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString('token') ?? '';
  }
}