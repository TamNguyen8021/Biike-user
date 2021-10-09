import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  Future<String> _getToken() async {
    final response = await post("https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU",
        <String, dynamic> {
          "email": "uyennlpse140355@fpt.edu.vn",
          "password": "190220",
          "returnSecureToken": true
        });
    final token = response.body['idToken'];
    return token;
  }

  Future<Map<String, String>> getHeaders() async {
    var token = await _getToken();
    return <String, String> {
      'Authorization' : 'Bearer $token'
    };
  }
}