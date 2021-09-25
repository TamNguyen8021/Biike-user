import 'dart:convert';

import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:get/get.dart';

class VoucherProvider extends GetConnect {
  Future<dynamic> getVoucherList() async {
    final response = await
      get("https://biike-api.azurewebsites.net/api/biike/v1/vouchers");

    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString.toString());
    }
    return Future.error(response.statusText!);
  }
}