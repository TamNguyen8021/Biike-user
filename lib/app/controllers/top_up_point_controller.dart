import 'package:bikes_user/app/common/functions/common_functions.dart';
import 'package:bikes_user/app/common/values/custom_error_strings.dart';
import 'package:bikes_user/app/common/values/custom_strings.dart';
import 'package:bikes_user/app/controllers/wallet_controller.dart';
import 'package:bikes_user/app/data/providers/top_up_point_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TopUpPointController extends GetxController {
  final _topUpPointProvider = Get.find<TopUpPointProvider>();
  final _walletController = Get.find<WalletController>();

  Rx<String> point = '0'.obs;
  Rx<String> amount = '0'.obs;
  Rx<String> percent = '0.06'.obs;

  bool isLoading = false;

  void _enableLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void setAmount(value) {
    var tempAmount =
        (int.parse(value) / double.parse(this.percent.value)).ceil();
    this.amount.value = '$tempAmount';
  }

  Future<void> createPayment(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    _enableLoading(true);

    final response = await _topUpPointProvider.paymentWithMomo(body: body);
    if (response['isSuccess']) {
      Map<String, dynamic> data = {
        'transactionId': response['data']['transid'],
        'amount': response['data']['amount'],
        'orderId': body['partnerRefId']
      };

      final result = await _topUpPointProvider.createTransaction(body: data);
      if (result) {
        await _walletController.updateWalletPoint();
        Get.back();
        CommonFunctions().showSuccessDialog(
            context: context, message: CustomStrings.kTopUpSuccess.tr);
      } else {
        Get.back();
        CommonFunctions().showErrorDialog(
            context: context, message: CustomErrorsString.kDevelopError.tr);
      }
    } else {
      Get.back();
      CommonFunctions()
          .showErrorDialog(context: context, message: response['errorMsg']);
    }
  }

  Future<void> getConfigurations() async {
    dynamic response = _topUpPointProvider.getConfigurations();
    print(response);
  }
}
