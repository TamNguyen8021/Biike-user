import 'package:bikes_user/main.dart';
import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  /// Return header to attach to api request
  ///
  /// Author: UyenNLP
  Future<Map<String, String>> getHeaders() async {
    var token = await Biike.localAppData.getToken();
    return <String, String>{'Authorization': 'Bearer $token'};
  }
}
