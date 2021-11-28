import 'dart:async';
import 'dart:developer';

import 'package:bikes_user/injectable/injectable.dart';
import 'package:bikes_user/network/repositories.dart';
import 'package:bikes_user/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

class TokenService {
  static TokenService init() {
    final tokenService = TokenService()
      ..cronJob()
      ..refreshToken();
    return tokenService;
  }

  final _apiKey = 'AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU';
  late Timer _timer;

  cronJob() {
    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      refreshToken();
    });
  }

  cancel() {
    _timer.cancel();
  }

  Future<void> refreshToken() async {
    final _refreshToken = getIt<AppPref>().refreshToken;
    if (_refreshToken.isEmpty) {
      log('refreshToken.isEmpty');
      return;
    }
    try {
      log('start');
      final dio = Dio();
      final response = await dio.post(
        'https://securetoken.googleapis.com/v1/token?key=$_apiKey',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken,
        },
      );
      final idToken = response.data['id_token'];
      final refreshToken = response.data['refresh_token'];
      getIt<AppPref>()
        ..setToken(idToken)
        ..setRefreshToken(refreshToken);
      getIt<Repositories>().setHeaders();
      log(response.data.toString());
    } on DioError catch (e) {
      log(e.response?.data ?? 'data is null');
    } catch (e) {
      log(e.toString());
    }
  }
}
