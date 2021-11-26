import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/data/models/login.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/network/repositories.dart';

abstract class UserBehavior {
  Future<dynamic> signup(String name, String email, String phone, String pass);
  Future<bool> isVerifyUser(String idUser);
  Future<void> verifyUser(
    String idUser,
    bool? isPhoneVerified,
  );
}

class UserRepository extends UserBehavior {
  final _repositories = getIt<Repositories>();

  Future<LoginResponse> signin(
      {required String email,
      required String password,
      bool isAdmin = false}) async {
    return await _repositories.signin(
      email: email,
      password: password,
      isAdmin: isAdmin,
    );
  }

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
      CommonFunctions.catchExceptionError(error);
      return false;
    }
  }

  @override
  Future<bool> verifyUser(String idUser, bool? isPhoneVerified) async {
    try {
      await _repositories.verifyUser(idUser, isPhoneVerified);
      return true;
    } catch (error) {
      CommonFunctions.catchExceptionError(error);
      return false;
    }
  }
}
