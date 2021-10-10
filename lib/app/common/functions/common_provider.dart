import 'package:bikes_user/app/common/functions/local_app_data.dart';
import 'package:get/get.dart';

class CommonProvider extends GetConnect {
  final apiUrl = 'https://biike-api.azurewebsites.net/api/biike/v1';

  Future<Map<String, String>> getHeaders() async {
    var token = await new LocalAppData().getToken();
    return <String, String> {
      'Authorization' : 'Bearer $token'
    };
  }
}