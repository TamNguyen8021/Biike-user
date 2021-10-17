import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:flutter_logs/flutter_logs.dart';

abstract class UserBehavior {
  Future<dynamic> signup(String name, String email, String phone, String pass);
  Future<bool> isVerifyUser(String idUser);
  Future<void> verifyUser(
    String idUser,
    bool? isPhoneVerified,
    bool? isEmailVerified,
  );
}

class UserRepository extends UserBehavior {
  final _repositories = getIt<Repositories>();
  @override
  Future<dynamic> signup(
      String name, String email, String phone, String pass) async {
    final results = await _repositories.signup(
      name,
      email,
      phone,
      pass,
    );

    return results;
  }

  @override
  Future<bool> isVerifyUser(String idUser) async {
    try {
      final results = await _repositories.isVerifyUser(idUser);
      return results['data']['isVerified'];
    } catch (error) {
      FlutterLogs.logErrorTrace('Biike', 'UserRepository - isVerifyUser()',
          error.toString(), Error());
      return false;
    }
  }

  @override
  Future<void> verifyUser(
      String idUser, bool? isPhoneVerified, bool? isEmailVerified) async {
    try {
      await _repositories.verifyUser(idUser, isPhoneVerified, isEmailVerified);
    } catch (error) {
      FlutterLogs.logErrorTrace(
          'Biike', 'UserRepository - verifyUser()', error.toString(), Error());
    }
  }
}
