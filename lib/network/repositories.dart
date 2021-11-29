import 'package:bikes_user/app/data/models/login.dart';
import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/main.dart';
import 'package:bikes_user/network/retrofit.dart';
import 'package:bikes_user/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'config_network.dart';

@singleton
class Repositories implements RestClient {
  final dio = Dio();
  late RestClient _client;

  Repositories() {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    setHeaders();

    _client = RestClient(
      dio,
      baseUrl: baseUrl,
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
  Future verifyUser(String idUser, bool? isPhoneVerified) {
    return _client.verifyUser(idUser, isPhoneVerified);
  }

  @override
  Future<BlackListResponse> getBlackList(int userId, int page, int limit) {
    return _client.getBlackList(
      Biike.userId.value,
      page,
      limit,
    );
  }

  Future<void> setHeaders() async {
    final token = getIt<AppPref>().token;
    dio.options.headers = {'Authorization': 'Bearer $token'};
  }

  @override
  Future<dynamic> unBlock({required BlackListItem blackListItem}) {
    return _client.unBlock(
      blackListItem: blackListItem,
    );
  }

  @override
  Future<LoginResponse> signin(
      {required String email, required String password, bool isAdmin = false}) {
    return _client.signin(
      email: email,
      password: password,
      isAdmin: isAdmin,
    );
  }
}
