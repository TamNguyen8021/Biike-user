import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:dio/dio.dart';

class TopUpPointProvider extends CommonProvider {
  Future<dynamic> paymentWithMomo({ required Map<String, dynamic> body }) async {
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
      };
      final response = await post(UrlStrings.apiMomoPayment, body, headers: headers);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}