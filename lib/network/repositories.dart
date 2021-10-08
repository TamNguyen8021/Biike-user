import 'package:bikes_user/network/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class Repositories implements RestClient {
  final dio = Dio();
  late RestClient _client;

  Repositories() {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    _client = RestClient(
      dio,
    );
  }

  @override
  Future<dynamic> signup(String name, String email, String phone, String pass) {
    return _client.signup(
      name,
      email,
      phone,
      pass,
    );
  }

  @override
  Future isVerifyUser(String idUser) {
    return _client.isVerifyUser(idUser);
  }

  @override
  Future verifyUser(
      String idUser, bool? isPhoneVerified, bool? isEmailVerified) {
    return _client.verifyUser(idUser, isPhoneVerified, isEmailVerified);
  }
}
