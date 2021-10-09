import 'dart:convert';

import 'package:bikes_user/app/data/models/custom/custom_redemption.dart';
import 'package:bikes_user/app/data/models/voucher.dart';
import 'package:get/get.dart';

class RedemptionProvider extends GetConnect {
  Future<bool> exchangeVoucher(data) async {
    final response = await post('https://biike-api.azurewebsites.net/api/biike/v1/redemptions', data);

    return response.statusCode == 200
        ? Future.value(true)
        : Future.value(false);
  }

  Future<List<dynamic>> getYourVoucherList({userId}) async {
    //TODO
    final response = await
      get('https://biike-api.azurewebsites.net/api/biike/v1/redemptions/' + userId +'/full');

    if (response.statusCode == 200) {
      return jsonDecode(response.bodyString.toString());
    }
    return Future.error(response.statusText!);
  }
}