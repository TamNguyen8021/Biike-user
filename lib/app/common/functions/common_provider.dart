import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  final apiUrl = 'https://biike-api.azurewebsites.net/api/biike/v1';

  /// Return header to attach to api request
  ///
  /// Author: UyenNLP
  Future<Map<String, String>> get headers async {
    var token = await LocalAppData().token;
    return <String, String>{'Authorization': 'Bearer $token'};
  }
}
