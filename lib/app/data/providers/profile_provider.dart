import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = UrlStrings.baseUrl;

    httpClient.addAuthenticator<dynamic>((request) async {
      print('addAuthenticator');
      final response = await httpClient.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU');
      final token = response.body['idToken'];
      print(token);
      // Set the header
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });

    // Autenticator will be called 1 time if HttpStatus is HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
  }

  /// Loads profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future getProfile({required int userId}) async {
    final response = await httpClient
        .get(httpClient.baseUrl! + UrlStrings.userUrl + '$userId/profile');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      // print(response.body);
      return response.body;
    }
  }

  /// Edits profile from API based on [userId]
  ///
  /// Author: TamNTT
  Future<String> editProfile(
      {required int userId, required dynamic body}) async {
    print(body);
    final response = await httpClient.put(
        httpClient.baseUrl! + UrlStrings.userUrl + '$userId/profile',
        body: body);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CustomStrings.kEditProfileSuccess.tr;
    }
  }
}
