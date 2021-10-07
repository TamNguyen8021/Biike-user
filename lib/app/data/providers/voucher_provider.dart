import 'dart:convert';

import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:get/get.dart';

class VoucherProvider extends GetConnect {
  Future<dynamic> getVoucherList() async {

    final response = await
      get("https://biike-api.azurewebsites.net/api/biike/v1/vouchers?page=1&limit=10",
      headers: await new CommonProvider().getHeaders());

    if (response.statusCode == 200) {
      return response.body['data'];
    }
    return Future.error(response.statusText!);
  }
}