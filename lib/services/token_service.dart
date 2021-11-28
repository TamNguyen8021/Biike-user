import 'dart:developer';

import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:dio/dio.dart';

class TokenService {
  static init() async {
    final tokenService = TokenService();
    // tokenService._refreshToken();
    return tokenService;
  }

  final _apiKey = 'AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU';

  _refreshToken() async {
    final refreshToken = await LocalAppData().refreshToken;
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://securetoken.googleapis.com/v1/token?key=$_apiKey',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
        },
      );
      log(response.data);
    } catch (e) {}
  }
}
