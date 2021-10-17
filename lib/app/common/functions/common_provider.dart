import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  /// Return header to attach to api request
  ///
  /// Author: UyenNLP
  Future<Map<String, String>> get headers async {
    String token = Biike.token.value;
    return <String, String>{'Authorization': 'Bearer $token'};
  }
}
