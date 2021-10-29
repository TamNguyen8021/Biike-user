import 'package:bikes_user/app/ui/android/pages/ban_list/model/black_list_response.dart';
import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/network/retrofit.dart';
import 'package:bikes_user/services/firebase_services.dart';
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
    setToken();

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
  Future verifyUser(
      String idUser, bool? isPhoneVerified, bool? isEmailVerified) {
    return _client.verifyUser(idUser, isPhoneVerified, isEmailVerified);
  }

  @override
  Future<BlackListResponse> getBlackList(String idUser, int page, int limit) {
    return _client.getBlackList(
      idUser,
      page,
      limit,
    );
  }

  Future<void> setToken() async {
    final token = await getIt<FirebaseServices>().token;
    dio.options.headers = {'Authorization': 'Bearer $token'};
    getIt<FirebaseServices>()
        .firebaseAuth
        .idTokenChanges()
        .listen((event) async {
      final token = await event?.getIdToken() ?? '';
      dio.options.headers = {'Authorization': 'Bearer $token'};
    });
  }

  @override
  Future<dynamic> unBlock({required BlackListItem blackListItem}) {
    return _client.unBlock(
      blackListItem: blackListItem,
    );
  }
}
