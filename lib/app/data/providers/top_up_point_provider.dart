import 'package:bikes_user/app/common/functions/common_provider.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/url_strings.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TopUpPointProvider extends CommonProvider {
  Future<Map<String, dynamic>> paymentWithMomo({ required Map<String, dynamic> body }) async {
    try {
      Map<String, String> headers = {
        Headers.contentTypeHeader: "application/json",
      };
      final response = await post(UrlStrings.apiMomoPayment, body, headers: headers);

      var status = response.body['status'];
      if (status == 0) {
        return {
          'isSuccess': true,
          'data': response.body
        };
      } else {
        return {
          'isSuccess': false,
          'errorMsg': response.body['message']
        };
      }
    } catch (e) {
      print(e.toString());
      return {
        'isSuccess': false,
        'errorMsg': CustomErrorsString.kDevelopError.tr
      };
    }
  }

  Future<dynamic> getConfigurations() async {
    final response = await get(
        UrlStrings.configurationUrl + '?configName=conversionrate',
        headers: await headers);

    print(response.body);
    logResponse(response);

    if (response.hasError) {
      logError(response);
      if (response.statusCode == 404) {
        return null;
      }
    } else {
      return response.body['data'];
    }
  }

  Future<bool> createTransaction({ required Map<String, dynamic> body }) async {
    final response =
    await post(UrlStrings.momoTransactionUrl, body, headers: await headers);

    logResponse(response);
    if (response.hasError) {
      logError(response);
      return false;
    } else {
      return true;
    }
  }
}