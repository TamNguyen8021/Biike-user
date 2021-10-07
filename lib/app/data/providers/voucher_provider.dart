import 'dart:convert';

import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:get/get.dart';

class VoucherProvider extends GetConnect {

  @override
  void onInit() {
    httpClient.addAuthenticator<dynamic>((request) async {
      final response = await get("https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCCMLMl1CZBpHU0P97gYFUtpNp2y5wN1RU");
      final token = response.body['token'];

      request.headers['Authorization'] = "$token";
      return request;
    });
  }

  Future<dynamic> getVoucherList() async {
    final response = await
      get("https://biike-api.azurewebsites.net/api/biike/v1/vouchers");

    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString.toString());
    }
    return Future.error(response.statusText!);
  }
}